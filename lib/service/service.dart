import 'package:cloud_firestore/cloud_firestore.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //veri gösterme

  Stream<QuerySnapshot> getUrunler() {
    var ref = _firestore.collection("urunler").snapshots();
    return ref;
  }

  Stream<QuerySnapshot> getMalzemeler() {
    var ref = _firestore.collection("malzemeler").snapshots();
    return ref;
  }
}
