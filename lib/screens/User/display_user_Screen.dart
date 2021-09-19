import 'package:caregiver_max/screens/User/Model/care_giver_user.dart';
import 'package:caregiver_max/screens/User/widgets/care_giver_user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayUserScreen extends StatefulWidget {
  const DisplayUserScreen({Key? key}) : super(key: key);

  @override
  State<DisplayUserScreen> createState() => _DisplayUserScreenState();
}

class _DisplayUserScreenState extends State<DisplayUserScreen> {
  List<CareGiverUser> careGiverUsers = [];
  bool isLoading = false;

  getAllUsers() async {
    setState(() {
      isLoading = true;
    });

    final allUsers =
        await FirebaseFirestore.instance.collection('careGiverUsers').get();

    if (allUsers.docs.length == 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    allUsers.docs.forEach((element) {
      print(element.data());
      careGiverUsers.add(CareGiverUser.fromMap(element.data()));
    });

    setState(() {
      isLoading = false;
    });
  }

  reset() {
    careGiverUsers = [];
    getAllUsers();
  }

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('All Users'),
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
                delegate: SearchCareGiverUsers(
                    careGiverUsers: careGiverUsers, reset: reset),
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
                    return CareGiverUserCard(
                      careGiverUser: careGiverUsers[index],
                      reset: reset,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: careGiverUsers.length),
            ),
    );
  }
}

class SearchCareGiverUsers extends SearchDelegate<String> {
  final List<CareGiverUser>? careGiverUsers;
  final Function? reset;

  SearchCareGiverUsers({this.careGiverUsers, this.reset});

  List<CareGiverUser>? searchResults(String query) {
    if (query.isEmpty) {
      return careGiverUsers;
    }

    return careGiverUsers!
        .where((element) => element.firstName!.contains(query))
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
    List<CareGiverUser> results =
        query.isEmpty ? careGiverUsers! : searchResults(query)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return CareGiverUserCard(
              careGiverUser: results[index],
              reset: reset,
            );
          }),
    );
  }
}
