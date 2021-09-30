import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/widget/resident_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DisplayResidentsScreen extends StatefulWidget {
  const DisplayResidentsScreen({Key? key}) : super(key: key);

  @override
  State<DisplayResidentsScreen> createState() => _DisplayResidentsScreenState();
}

class _DisplayResidentsScreenState extends State<DisplayResidentsScreen> {
  bool isLoading = false;
  List<Resident> allResidents = [];

  getAllResidents() async {
    setState(() {
      isLoading = true;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final allUsers = await FirebaseFirestore.instance
        .collection('residents')
        .where('addedBy', isEqualTo: userId)
        .get();

    if (allUsers.docs.length == 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    allUsers.docs.forEach((element) {
      print(element.data());
      allResidents.add(Resident.fromMap(element.data()));
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllResidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('All Residents'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchResident(residents: allResidents),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ResidentCard(
                      resident: allResidents[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: allResidents.length),
            ),
    );
  }
}

class SearchResident extends SearchDelegate<String> {
  final List<Resident>? residents;

  SearchResident({this.residents});

  List<Resident>? searchResults(String query) {
    if (query.isEmpty) {
      return residents;
    }

    return residents!
        .where((element) => element.residentName!.contains(query))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Resident> results = query.isEmpty ? residents! : searchResults(query)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ResidentCard(
              resident: results[index],
            );
          }),
    );
  }
}
