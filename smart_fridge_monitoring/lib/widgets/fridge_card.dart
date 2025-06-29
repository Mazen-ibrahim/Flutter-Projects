import 'package:flutter/material.dart';
import 'package:smart_fridge_monitoring/data/dtb.dart';
import 'package:smart_fridge_monitoring/data/graph.dart';
import 'package:smart_fridge_monitoring/data/users.dart';
import 'package:smart_fridge_monitoring/widgets/fridge_details.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FridgeCard extends StatelessWidget {
  final String fridgeId;
  final Map<String, dynamic> data;

  const FridgeCard({super.key, required this.fridgeId, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FridgePage(fridgeid: fridgeId),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildColumn("Cabin", "cabinTemp", "cabinCurrent", Colors.lightBlueAccent),
                  _buildColumn("Freezer", "freezerTemp", "freezerCurrent", Colors.lightBlueAccent),
                ],
              ),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({
    required String data,
    required String unit,
    required double minvalue,
    required double maxvalue,
  }) {
    return SizedBox(
      height: 205,
      width: 205,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: minvalue,
            maximum: maxvalue,
            ranges: <GaugeRange>[
              GaugeRange(startValue: minvalue, endValue: maxvalue - minvalue, color: Colors.blue),
              GaugeRange(startValue: maxvalue - minvalue, endValue: maxvalue, color: Colors.red),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(value: double.parse(data)),
            ],
            annotations: [
              GaugeAnnotation(
                widget: SizedBox(
                  height: 20,
                  child: Text(
                    "$data $unit",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                angle: 90,
                positionFactor: 0.5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(String title, String tempKey, String currentKey, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 30),
        const Text("Temperature", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        _buildIndicator(
          data: "${data[tempKey]}",
          unit: "°C",
          minvalue: tempKey.contains("cabin") ? data['mincabintemp'].toDouble() : data['minfreezertemp'].toDouble(),
          maxvalue: tempKey.contains("cabin") ? data['maxcabintemp'].toDouble() : data['maxfreezertemp'].toDouble(),
        ),
        const Text("Current Draw", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        _buildIndicator(
          data: "${data[currentKey]}",
          unit: "A",
          minvalue: tempKey.contains("cabin") ? data['mincabincurrent'].toDouble() : data['minfreezercurrent'].toDouble(),
          maxvalue: tempKey.contains("cabin") ? data['maxcabincurrent'].toDouble(): data['maxfreezercurrent'].toDouble(),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(isAdmin)
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          iconSize: 50,
        ),
        const SizedBox(width: 30),
        if(isAdmin)
        IconButton(
          onPressed: () {
            DataBase.deleteFridge(fridgeId);
            FridgesDataGraph.remove(fridgeId);
            FridgesIndex.remove(fridgeId);
          },
          icon: const Icon(Icons.delete),
          iconSize: 50,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Fridge ID: $fridgeId",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
        ),
        Text(
          "Status: ${data['status']}",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: data['status'].toString().toLowerCase() == "active" ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
