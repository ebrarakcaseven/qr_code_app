import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/nav.dart';
import 'package:qr_code_app/service/service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: prefer_final_fields, unused_field
  StatusService _statusService = StatusService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "QR CODE İLE SAĞLIKLI YAŞAM",
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("urunler").snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'no data...',
                  );
                } else {
                  List<DocumentSnapshot> denemece = snapshot.data?.docs;
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot mypost = denemece[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 234, 235, 243),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // color: Color.fromARGB(255, 223, 221, 223),
                            // color: Color.fromARGB(255, 234, 235, 243),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    height: 130,
                                    image: NetworkImage(mypost['image'])),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text("${mypost['urunAdi']}",
                                      style: const TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        ]),
      ),
    );
  }
}
