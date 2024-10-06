import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rbh_colorpicker/colorlib.dart';
import 'package:url_launcher/url_launcher.dart';

class ColorCard extends StatelessWidget {
  const ColorCard(
      {super.key, required this.color, required this.matchPercentage});

  final IndexedColor color;
  final double matchPercentage;

  Widget getLauncher(IndexedColor color, Widget child, Function() action,
      {String message = "Cliquez pour visiter le site"}) {
    return Tooltip(
      waitDuration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(4),
      preferBelow: true,
      message: message,
      child: InkWell(
          borderRadius: BorderRadius.circular(4), onTap: action, child: child),
    );
  }

  Function() getUrlOpenAction(IndexedColor color) {
    if (color.link == null) {
      return () {};
    }
    return () {
      Uri? link = color.link;
      if (link != null) {
        launchUrl(link);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    String hex = "#${color.color.value.toRadixString(16).substring(2)}";
    List<Widget> desc = [
      getLauncher(
          color,
          RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                text: color.name,
                style: Theme.of(context).textTheme.titleMedium,
              )),
          getUrlOpenAction(color)),
      Tooltip(
        message: "Code copié !",
        triggerMode: TooltipTriggerMode.tap,
        child: getLauncher(
            color,
            RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                text: "Hex : $hex",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ), () {
          Clipboard.setData(ClipboardData(text: hex));
        }, message: "Cliquez pour copier le code"),
      ),
      Text("Correspondance : ${(matchPercentage * 100).toStringAsFixed(1)}%")
    ];
    // if (matchPercentage < ColorStore.of(context).minimumMatchPercentage) {
    //   desc.add(Text(
    //     "Attention : Correspondance trop basse",
    //     style: Theme.of(context)
    //         .textTheme
    //         .bodySmall
    //         ?.copyWith(color: Colors.deepOrangeAccent),
    //   ));
    // }
    return SizedBox(
      width: 250,
      height: 100,
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Card(
              elevation: 2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: getLauncher(
                      color,
                      SizedBox.square(
                        dimension: 80,
                        child: Container(
                          color: color.color,
                        ),
                      ),
                      getUrlOpenAction(color))),
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
