import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ostab_assignment/screen/macth_details_screen.dart';
import 'package:ostab_assignment/services/firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Macth List", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getMatches(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(child: Text('Some error Occured!!'),);
          }
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final macthes = snapshot.data!.docs;
          return ListView.builder(
            itemCount: macthes.length,
            itemBuilder: (context, index) {
              final macth = macthes[index].data() as Map<String, dynamic>;
              final macthId = macthes[index].id;

              return ListTile(
                title: Text("${macth['team1_name']} vs ${macth['team2_name']}"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MacthDetailsScreen(
                        macthId: macthId, 
                        teamOneName: macth['team1_name'], 
                        teamTwoName: macth['team2_name'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}