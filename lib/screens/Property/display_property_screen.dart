import 'package:caregiver_max/Models/property.dart';
import 'package:caregiver_max/screens/Property/widgets/property_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayPropertyScreen extends StatefulWidget {
  const DisplayPropertyScreen({Key? key}) : super(key: key);

  @override
  State<DisplayPropertyScreen> createState() => _DisplayPropertyScreenState();
}

class _DisplayPropertyScreenState extends State<DisplayPropertyScreen> {
  bool isLoading = false;
  List<Property> properties = [];

  getAllProperties() async {
    setState(() {
      isLoading = true;
    });

    final allUsers =
        await FirebaseFirestore.instance.collection('properties').get();

    if (allUsers.docs.length == 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    allUsers.docs.forEach((element) {
      print(element.data());
      properties.add(Property.fromMap(element.data()));
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('All Properties'),
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
                delegate: SearchProperty(properties: properties),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return PropertyCard(
                    property: properties[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: properties.length),
      ),
    );
  }
}

class SearchProperty extends SearchDelegate<String> {
  final List<Property>? properties;

  SearchProperty({this.properties});

  List<Property>? searchResults(String query) {
    if (query.isEmpty) {
      return properties;
    }

    return properties!
        .where((element) => element.businessName!.contains(query))
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
    List<Property> results =
        query.isEmpty ? properties! : searchResults(query)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return PropertyCard(
              property: results[index],
            );
          }),
    );
  }
}
