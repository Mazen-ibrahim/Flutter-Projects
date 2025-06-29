import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_fridge_monitoring/data/graph.dart';
import 'package:smart_fridge_monitoring/widgets/fridge_card.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final CollectionReference fridgesRef =
      FirebaseFirestore.instance.collection('fridges');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
          stream: fridgesRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Fridge Data Available"));
            }

            final fridges = snapshot.data!.docs;

            return LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  itemCount: fridges.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 800 &&
                            constraints.maxHeight > 800
                        ? 2
                        : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final data = fridges[index].data() as Map<String, dynamic>;
                    final fridgeId = fridges[index].id;

                    List<FlSpot> cabinTempData = [];
                    List<FlSpot> cabinCurrentData = [];
                    List<FlSpot> freezerTempData = [];
                    List<FlSpot> freezerCurrentData = [];

                    if (!FridgesDataGraph.containsKey(fridgeId) &&
                        !FridgesIndex.containsKey(fridgeId)) {
                      FridgesDataGraph[fridgeId] = [
                        cabinTempData,
                        cabinCurrentData,
                        freezerTempData,
                        freezerCurrentData
                      ];
                      FridgesIndex[fridgeId] = 0;
                    }

                    return FridgeCard(fridgeId: fridgeId, data: data);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
