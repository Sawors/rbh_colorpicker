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

  Color getContrastColor(Color source) {
    HSVColor hsv = HSVColor.fromColor(source);
    double luminance =
        (0.299 * source.red + 0.587 * source.green + 0.114 * source.blue) / 255;
    double valueOffset = 0;
    double v = luminance > .6 ? 0 + valueOffset : 1 - valueOffset;
    double sat = 0;
    double hue = HSVColor.fromColor(Color.fromARGB(
            1, 255 - source.red, 255 - source.green, 255 - source.blue))
        .hue;
    return HSVColor.fromAHSV(hsv.alpha, hue, sat, v).toColor();
  }

  @override
  Widget build(BuildContext context) {
    String hex = "#${color.color.value.toRadixString(16).substring(2)}";
    Widget nameText = Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      child: RichText(
          overflow: TextOverflow.clip,
          text: TextSpan(
            text: color.name,
            style: Theme.of(context).textTheme.titleMedium,
          )),
    );
    Widget name = color.link != null && color.link.toString().isNotEmpty
        ? getLauncher(color, nameText, getUrlOpenAction(color))
        : nameText;
    List<Widget> desc = [
      name,
      Tooltip(
        message: "Code copié !",
        triggerMode: TooltipTriggerMode.tap,
        child: getLauncher(
            color,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  text: "Hex : $hex",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ), () {
          Clipboard.setData(ClipboardData(text: hex));
        }, message: "Cliquez pour copier le code"),
      ),
      Text("Correspondance : ${(matchPercentage * 100).toStringAsFixed(1)}%")
    ];
    List<Widget> stack = [
      Container(
        color: color.color,
      )
    ];

    bool refBehaviour = color.reference != null && color.reference!.isNotEmpty;
    if (refBehaviour) {
      stack.add(FittedBox(
        fit: BoxFit.fitWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(color.reference ?? "",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: getContrastColor(color.color).withOpacity(0.85),
                  fontWeight: FontWeight.w400)),
        ),
      ));
    }
    Widget baseWid = SizedBox.square(
      dimension: 80,
      child: Stack(alignment: AlignmentDirectional.center, children: stack),
    );
    Widget refWid = refBehaviour
        ? getLauncher(color, baseWid, () {
            Clipboard.setData(ClipboardData(text: color.reference ?? ""));
          }, message: "Cliquez pour copier la référence")
        : baseWid;
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
                child: refWid,
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
