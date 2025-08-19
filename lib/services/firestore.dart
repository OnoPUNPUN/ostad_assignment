import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _data = FirebaseFirestore.instance;


  // GET THE SAPARATED MACTHES
  Stream<QuerySnapshot> getMatches() {
    return _data.collection('matches').snapshots();
  }

  // GET THE DETAILS OF MACTHES
  Stream<DocumentSnapshot> getMatchDetails(String matchId) {
    return _data.collection('matches').doc(matchId).snapshots();
  }
}