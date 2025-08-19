import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ostab_assignment/services/firestore.dart';

class MacthDetailsScreen extends StatelessWidget {

  final String macthId;
  final String teamOneName;
  final String teamTwoName;
  final FirestoreService _firestoreService = FirestoreService();
  MacthDetailsScreen({super.key, required this.macthId, required this.teamOneName, required this.teamTwoName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$teamOneName vs $teamTwoName'),),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestoreService.getMatchDetails(macthId),
        builder: (context, snapshot){
          if(snapshot.hasError) {
            return Center(child: Text('An Error Occured'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final macth = snapshot.data!.data() as Map<String, dynamic>;
          return SizedBox(
            height: 250,
            width: double.infinity,
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$teamOneName vs $teamTwoName', style: TextStyle(fontSize: 25)),
                      Text('${macth['team1_score']} : ${macth['team2_score']}', style: TextStyle(
                            fontSize: 30, 
                            fontWeight: FontWeight.bold
                          )
                        ),
                      Text('Time: ${macth['currentTime']}',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text('Total Time: ${macth['totalTime']}', style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}