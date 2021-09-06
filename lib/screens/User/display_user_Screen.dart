import 'package:caregiver_max/Models/user.dart';
import 'package:flutter/material.dart';

class DisplayUserScreen extends StatefulWidget {
  const DisplayUserScreen({Key? key}) : super(key: key);

  @override
  State<DisplayUserScreen> createState() => _DisplayUserScreenState();
}

class _DisplayUserScreenState extends State<DisplayUserScreen> {
  List<CareGiverUser> dummyUsers = [
    CareGiverUser(
      id: '0004',
      email: 'jailynedee98@gmail.com',
      name: 'JaiLyne Daniels',
      cellPhone: '0304022',
      homePhone: '323223',
      workPhone: '',
      role: 'Care Giver',
      initial: 'JLD',
    ),
    CareGiverUser(
      id: '0004',
      email: '',
      name: 'Numoipre Ola-Keji',
      cellPhone: '',
      homePhone: '',
      workPhone: '',
      role: 'Care Giver',
      initial: 'no',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('All Users'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return UserCard(
                careGiverUser: dummyUsers[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: dummyUsers.length),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final CareGiverUser? careGiverUser;

  const UserCard({this.careGiverUser});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      careGiverUser!.name!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      careGiverUser!.email!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Initial :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      careGiverUser!.initial!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Phone :  ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'CellPhone      : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(careGiverUser!.cellPhone!)
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          'HomePhone : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(careGiverUser!.homePhone!)
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          'WorkPhone   : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(careGiverUser!.workPhone!)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Role :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      careGiverUser!.role!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  Icon(Icons.delete, color: Colors.red),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
