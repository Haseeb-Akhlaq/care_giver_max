import 'package:caregiver_max/screens/landing_screen.dart';
import 'package:caregiver_max/widgets/error_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  static const route = '/SignUpwithEmail';
  @override
  _SignUpWithEmailScreenState createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
            child: Column(
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 50,
                ),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email = '';
  String? password = '';
  String? firstName = '';
  String? secondName = '';

  bool isLoading = false;

  registerWithEmail() async {
    bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    email = email.toString().trim();

    setState(() {
      isLoading = true;
    });

    try {
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      String userId = authResult.user!.uid;

      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (user.exists) {
        print(
            '$userId----------------------------------------------setting user ID------');
        return;
      } else {
        final result = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set({
          'email': authResult.user!.email,
          'userId': authResult.user!.uid,
          'name': firstName! + secondName!,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Account Created Successfully!!'),
      ));

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LandingScreen(),
            ),
            (Route<dynamic> route) => false);
      });
    } on FirebaseAuthException catch (error) {
      showErrorSnackBar(context, error.message!);
    } catch (e) {
      print(e);

      showErrorSnackBar(context, e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name'),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (v) {
                    firstName = v;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Last Name'),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (v) {
                    secondName = v;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Second Name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Email'),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid Email';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Password'),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid password';
                    }
                    if (value.length < 6) {
                      return 'Password Must be 6 characters long';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        registerWithEmail();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Done',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'By Clicking "Sign Up". you accept',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Terms and Condition of Use',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
