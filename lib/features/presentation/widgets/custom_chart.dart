import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomChart extends StatefulWidget {
  const CustomChart({super.key, required this.result});

  final Map<String, double> result;

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  int touchedIndex = -1;

  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: BarChart(
        mainBarData(widget.result),
        swapAnimationDuration: animDuration,
      ),
    );
  }

  BarChartData mainBarData(Map<String, double> result) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black,
          tooltipMargin: 1,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String namePlace;
            final namePlaceInt = group.x.toInt();
            if (namePlaceInt >= namePlaceList.length) {
              throw Error();
            }
            namePlace = namePlaceList[namePlaceInt];

            return BarTooltipItem(
              '$namePlace\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 15,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(result),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = GoogleFonts.poppins(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String title;
    final titleInt = value.toInt();
    if (titleInt >= titleList.length) {
      title = '';
    } else {
      title = titleList[titleInt];
    }
    Widget text = Text(title, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: text,
    );
  }

  List<BarChartGroupData> showingGroups(Map<String, double> result) {
    final List<double?> values = result.values.toList();

    return List.generate(values.length, (i) {
      final value = values[i] != null ? values[i]!.toStringAsFixed(0) : '0';
      // final value = values[i] != null ? values[i]!.toStringAsFixed(0) : '0.0';

      return makeGroupData(
        i,
        double.parse(value),
        isTouched: i == touchedIndex,
      );
    });
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 24,
    List<int> showTooltips = const [],
  }) {
    barColor ??= AppColors.primaryBlue;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? AppColors.darkBlue : barColor,
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.black, width: 2)
              : const BorderSide(color: Colors.black, width: 2),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 30,
            color: AppColors.softBlue,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}

final List<String> titleList = [
  'BN',
  'KA',
  'MX',
  'SK',
  'LB',
  'KR',
  'BR',
  'JB',
  'UK',
];

final List<String> namePlaceList = [
  'Baiturrahman',
  'Kuta Alam',
  'Meuraxa',
  'Syiah Kuala',
  'Lueng Bata',
  'Kuta Raja',
  'Banda Raya',
  'Jaya Baru',
  'Ulee Kareng',
];
