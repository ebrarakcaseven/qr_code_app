import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_app/service/service.dart';

class Besinler extends StatefulWidget {
  const Besinler({Key? key}) : super(key: key);

  @override
  State<Besinler> createState() => _BesinlerState();
}

class _BesinlerState extends State<Besinler> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  bool _selectedGender = false;
  bool _selectedGender2 = false;

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
              stream: FirebaseFirestore.instance
                  .collection("malzemeler")
                  .snapshots(),
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
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        crossAxisCount: 1,
                        childAspectRatio: 9,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot mypost = denemece[index];
                        return Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: _selectedGender,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                              /* Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: _selectedGender2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _selectedGender2 = value!;
                                  });
                                },
                              ),
                              Radio<String>(
                                  value: 'orange$index',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                  activeColor: Colors.green),*/
                              Text("${mypost['malzemeAdi']}",
                                  style: const TextStyle(fontSize: 16)),
                            ],
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
