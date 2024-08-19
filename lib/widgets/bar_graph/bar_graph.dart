import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tracky/widgets/bar_graph/bar_data.dart';

class BarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const BarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
    });

  @override
  Widget build(BuildContext context) {
    BarData barData=BarData(
      sunAmount:sunAmount ,
      monAmount:monAmount,
      tueAmount:tueAmount ,
      wedAmount: wedAmount,
      thuAmount:thuAmount ,
      friAmount:friAmount ,
      satAmount:satAmount  );

      barData.initBar();



    return  BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: const FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: getTitles))
      ),
      barGroups: barData.barData.map((e) =>BarChartGroupData(
        x: e.x,
        barRods:[
          BarChartRodData(
            toY: e.y,
            color: Colors.black,
            width: 25,
            borderRadius: BorderRadius.circular(5),
            backDrawRodData: BackgroundBarChartRodData(color: Colors.white70,show: true,toY: maxY)
            ),
          
        ], 
        ) ).toList(),
      ));
  }
}
Widget getTitles(double value,TitleMeta meta){
  const style=TextStyle(
    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13
  );
  Widget text;
  switch(value.toInt()){
    case 0: 
         text=const Text('Sun',style: style,);
         break;
    case 1:
        text= const Text('Mon',style: style,);
        break;
    case 2: 
        text=const Text('Tue',style: style,);
        break;
    case 3: 
        text=const Text('Wed',style: style,);
        break;
    case 4: 
       text=const Text('Thu',style: style,);
       break;
    case 5: 
       text=const Text('Fri',style: style,);
       break;
    case 6: 
       text=const Text('Sat',style: style,);
       break;
    default:
       text=const Text('',style: style,);
       break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}