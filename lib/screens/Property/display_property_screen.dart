import 'package:caregiver_max/Models/property.dart';
import 'package:caregiver_max/screens/Property/edit_property_screen.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/material.dart';

class DisplayPropertyScreen extends StatefulWidget {
  const DisplayPropertyScreen({Key? key}) : super(key: key);

  @override
  State<DisplayPropertyScreen> createState() => _DisplayPropertyScreenState();
}

class _DisplayPropertyScreenState extends State<DisplayPropertyScreen> {
  List<Property> dummyProperties = [
    Property(
      id: '0004',
      address: '1586 Beltine Road',
      businessName: 'Synergy Care',
      city: 'Dallas',
      contactNumber: '',
      contactPerson: '',
      statusActive: true,
      zipCode: '75240',
      state: 'TX',
    ),
    Property(
      id: '0005',
      address: '2212 Bluebonnet',
      businessName: 'Synergy Care',
      city: 'Richardson',
      contactNumber: '972-299990-22',
      contactPerson: 'akl',
      statusActive: false,
      zipCode: '75240',
      state: 'AL',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('All Properties'),
        backgroundColor: Color(0xff788B91),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return PropertyCard(
                property: dummyProperties[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: dummyProperties.length),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property? property;

  const PropertyCard({this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'ID :  ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          property!.id!,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditPropertyScreen(property: property),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: AppColors.background,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.address!,
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
                    'City :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.city!,
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
                    'State :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.state!,
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
                    'Zip :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.zipCode!,
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
                    'Business name :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.businessName!,
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
                    'Contact No :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.contactNumber!,
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
                    'Contact Person :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      property!.contactPerson!,
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
                    'Status :  ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  property!.statusActive! ? ActiveStatus() : InActiveStatus(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Text(
          '  Active',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class InActiveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Text(
          '  InActive',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
