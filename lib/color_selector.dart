import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rbh_colorpicker/main.dart';

class ColorSelector extends StatefulWidget {
  ColorSelector({Key? key}) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color color;
  late ColorStore store;

  void changeColor(Color c) {
    store.onColorChange(c);
    setState(() {
      color = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    store = ColorStore.of(context);
    color = store.color;
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sélectionnez la Couleur",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: ColorPicker(
              pickerColor: color,
              onColorChanged: changeColor,
              enableAlpha: false,
              hexInputBar: true,
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue,
              colorPickerWidth: 250,
            ),
          )
        ],
      ),
    ));
  }
}
