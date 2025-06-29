import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_fridge_monitoring/data/graph.dart';
import 'package:smart_fridge_monitoring/widgets/fridge_graph.dart';

class FridgePage extends StatelessWidget {
  final String fridgeid;
  // ignore: prefer_const_constructors_in_immutables
  FridgePage({super.key, required this.fridgeid});

  @override
  Widget build(BuildContext context) {
    final DocumentReference fridgeRef =
        FirebaseFirestore.instance.collection('fridges').doc(fridgeid);

    return Scaffold(
      appBar: AppBar(
        title: Text("Fridge $fridgeid"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: fridgeRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("No Fridge Data Found"),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          if (FridgesIndex[fridgeid] as double >= 30) {
            FridgesIndex[fridgeid] = 0;
            FridgesDataGraph[fridgeid]?[0] = [];
            FridgesDataGraph[fridgeid]?[1] = [];
            FridgesDataGraph[fridgeid]?[2] = [];
            FridgesDataGraph[fridgeid]?[3] = [];
          }
          FridgesDataGraph[fridgeid]?[0].add(FlSpot(FridgesIndex[fridgeid] as double, data['cabinTemp'].toDouble()));
          FridgesDataGraph[fridgeid]?[1].add(FlSpot(FridgesIndex[fridgeid] as double, data['cabinCurrent'].toDouble()));
          FridgesDataGraph[fridgeid]?[2].add(FlSpot(FridgesIndex[fridgeid] as double, data['freezerTemp'].toDouble()));
          FridgesDataGraph[fridgeid]?[3].add(FlSpot(FridgesIndex[fridgeid] as double, data['freezerCurrent'].toDouble()));

          FridgesIndex[fridgeid] = (FridgesIndex[fridgeid] as double) + 1;
          log(FridgesIndex[fridgeid].toString());

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FridgeGraph(
                            title: "Cabin Temperature (°C)",
                            yname: "Temperature (°C)",
                            xname: "Time",
                            data: FridgesDataGraph[fridgeid]![0],
                            color: Colors.blue),
                        SizedBox(
                          width: 100,
                        ),
                        FridgeGraph(
                            title: "Cabin Current (A)",
                            yname: "Current (A)",
                            xname: "Time",
                            data: FridgesDataGraph[fridgeid]![1],
                            color: Colors.green),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FridgeGraph(
                            title: "Freezer Temperature (°C)",
                            yname: "Temperature (°C)",
                            xname: "Time",
                            data: FridgesDataGraph[fridgeid]![2],
                            color: Colors.orange),
                        SizedBox(
                          width: 100,
                        ),
                        FridgeGraph(
                            title: "Freezer Current (A)",
                            yname: "Current (A)",
                            xname: "Time",
                            data: FridgesDataGraph[fridgeid]![3],
                            color: Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
