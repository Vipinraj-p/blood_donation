import 'package:blood_donation/donor.dart';
import 'package:blood_donation/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Donation App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Donors(),
              ));
        },
        backgroundColor: Colors.red[900],
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donorSnap =
                    snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                return Column(
                  children: [
                    Container(
                      height: 80,
                      color: Colors.red[50],
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(
                              child: CircleAvatar(
                                backgroundColor: Colors.red[900],
                                radius: 30,
                                child: Text(
                                  donorSnap['group'],
                                  // donorSnap['group'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  donorSnap['name'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  donorSnap['phone'].toString(),
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                )
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateDonor(
                                            name: donorSnap['name'],
                                            phone:
                                                donorSnap['phone'].toString(),
                                            group: donorSnap['group'],
                                            id: donorSnap.id),
                                      ));

                                  // pushNamed(
                                  //   context,
                                  //   '/update',
                                  // );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () {
                                  deleteDonor(donorSnap.id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 0,
                      color: Colors.blueGrey[100],
                    )
                  ],
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
