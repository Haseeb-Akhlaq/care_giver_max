import 'package:caregiver_max/styles/colors.dart';
import 'package:caregiver_max/widgets/error_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../landing_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/SignInScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('CareGiverMax'),
        centerTitle: true,
        backgroundColor: Color(0xff788B91),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                ),
                SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email = '';
  String? password = '';
  bool isLoading = false;

  login() async {
    bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      _formKey.currentState!.save();

      email = email.toString().trim();

      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LandingScreen(),
          ),
          (Route<dynamic> route) => false);
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
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.mainGrey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(0)),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Email',
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
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(0)),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              hintText: '.......',
                              border: InputBorder.none,
                            ),
                            onSaved: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid password';
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
                                  login();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            GoogleButton(),
          ],
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.36,
          top: 40,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
          ),
        )
      ],
    );
  }
}

class GoogleButton extends StatelessWidget {
  signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );

        String userId = authResult.user!.uid;
        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (user.exists) {
          return;
        } else {
          final result = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'userName': authResult.user!.displayName,
            'email': authResult.user!.email,
            'userId': authResult.user!.uid,
            'profilePic': authResult.user!.photoURL,
          });
        }
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Authentication Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign In aborted by user',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await signInWithGoogle();
        } catch (e) {
          showErrorSnackBar(context, e.toString());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                child: Image.asset('assets/images/googlelogo.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Sign In with Google',
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
