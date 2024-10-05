import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rbh_colorpicker/libraries/lfb_colorlib.dart';
import 'package:rbh_colorpicker/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ColorCard extends StatelessWidget {
  const ColorCard(
      {super.key, required this.color, required this.matchPercentage});

  final LeFrancBourgeoisColor color;
  final double matchPercentage;

  @override
  Widget build(BuildContext context) {
    String hex = "#${color.color.value.toRadixString(16).substring(2)}";
    List<Widget> desc = [
      RichText(
        overflow: TextOverflow.clip,
        text: TextSpan(
            text: color.name,
            style: Theme.of(context).textTheme.titleMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(color.getLink());
              }),
      ),
      RichText(
        overflow: TextOverflow.clip,
        text: TextSpan(
            text: "Hex : $hex",
            style: Theme.of(context).textTheme.bodyMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Clipboard.setData(ClipboardData(text: hex));
              }),
      ),
      Text("Correspondance : ${(matchPercentage * 100).toStringAsFixed(1)}%")
    ];
    if (matchPercentage < ColorStore.of(context).minimumMatchPercentage) {
      desc.add(Text(
        "Attention : Correspondance trop basse",
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.deepOrangeAccent),
      ));
    }
    return SizedBox(
      width: 250,
      height: 120,
      child: Card(
        child: Row(
          children: [
            Card(
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox.square(
                  dimension: 100,
                  child: Container(
                    color: color.color,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: desc,
              ),
            )
          ],
        ),
      ),
    );
  }
}
