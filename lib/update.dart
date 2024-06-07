import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor(
      {super.key,
      required this.name,
      required this.phone,
      required this.group,
      required this.id});
  final String name;
  final String phone;
  final String group;
  final String id;
// arguments: {
//                                         'name': donorSnap['name'],
//                                         'phone': donorSnap['phone'].toString(),
//                                         'group': donorSnap['group'],
//                                         'id': donorSnap.id
//                                       }
  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  String? selectedGroup;
  void updateDonor(docId) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup
    };
    donor.doc(docId).update(data).then(
          (value) => Navigator.pop(context),
        );
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as Map;

    final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    double kheight = MediaQuery.of(context).size.height - kToolbarHeight;

    donorName.text = widget.name;
    donorPhone.text = widget.phone;
    selectedGroup = widget.group;
    final docId = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Donors info',
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
                    hintText: 'Donor Name',
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
                  value: selectedGroup,
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
                updateDonor(docId);
              },
              child: const Text('Update'),
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
