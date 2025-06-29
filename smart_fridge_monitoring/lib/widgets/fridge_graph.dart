import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FridgeGraph extends StatelessWidget {

  final String title;
  final String yname;
  final String xname;
  final List<FlSpot> data;
  final Color color;
  const FridgeGraph({super.key, required this.title, required this.yname, required this.xname, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
                width: 800,
                height: 400,
                child: data.isEmpty
                    ? Center(child: Text("No data available"))
                    : LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              axisNameWidget: Text(
                                yname, // Change for other graphs
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              axisNameSize: 25, // Adjust space for label
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              axisNameWidget: Text(
                                xname, // Change for other graphs
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              axisNameSize: 25, // Adjust space for label
                              sideTitles: SideTitles(
                                showTitles: false,
                                reservedSize: 40,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: data,
                              isCurved: false,
                              color: color,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}