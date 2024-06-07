import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Donors extends StatefulWidget {
  const Donors({super.key});

  @override
  State<Donors> createState() => _DonorsState();
}

class _DonorsState extends State<Donors> {
  final donorName = TextEditingController();
  final donorPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CollectionReference donor =
        FirebaseFirestore.instance.collection('donor');
    final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    String? selectedGroup;
    double kheight = MediaQuery.of(context).size.height - kToolbarHeight;

    void addDonor() {
      final data = {
        'name': donorName.text,
        'phone': donorPhone.text,
        'group': selectedGroup
      };
      donor.add(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Donors',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[900],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Icon(
              Icons.groups_outlined,
              color: Colors.red[700],
              size: 80,
            ),
            Padding(
              padding: EdgeInsets.all(kheight * 0.04),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: 'Donor Name',
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(kheight * 0.025)))),
                controller: donorName,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  kheight * 0.04, 0, kheight * 0.04, kheight * 0.04),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_outlined),
                    hintText: 'Phone Number',
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(kheight * 0.025)))),
                controller: donorPhone,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kheight * 0.04),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      label: Text('Select Blood Group'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(kheight * 0.025))),
                  items: bloodGroups
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    selectedGroup = val as String;
                  }),
            ),
            SizedBox(
              height: kheight * 0.1,
            ),
            ElevatedButton(
              onPressed: () {
                addDonor();
                Navigator.pop(context);
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.red[900],
                  foregroundColor: Colors.white,
                  fixedSize: const Size(180, 50)),
            )
          ],
        ),
      ),
    );
  }
}
