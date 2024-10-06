import 'dart:convert';
import 'dart:io';

import 'package:delta_e/delta_e.dart';
import 'package:flutter/material.dart';

enum DistanceComputeMethod { hsvWeighted, rgb, hsv, deltaE }

class ColorLib {
  static const String emptyName = "EMPTY LIBRARY";

  ColorLib(this.displayName) {
    author = "Unknown";
  }

  ColorLib.fromJson(String jsonData) {
    dynamic decoded = jsonDecode(jsonData);
    if (decoded is Map<String, dynamic>) {
      displayName = decoded["name"]?.toString() ?? "Unknown Library";
      source = Uri.tryParse(decoded["source"]?.toString() ?? "");
      author = decoded["author"]?.toString() ?? "Unknown";
      dynamic jsonIndex = decoded["index"];
      if (jsonIndex == null) {
        return;
      }
      if (jsonIndex is List<dynamic>) {
        for (dynamic e in jsonIndex) {
          if (e is Map<String, dynamic>) {
            if (e.containsKey("hex")) {
              String hex = e["hex"].toString();
              String hexSmall = hex.replaceAll("#", "");
              hexSmall =
                  hexSmall.length == 6 ? hexSmall : hexSmall.substring(1);
              String name = e["name"]?.toString() ?? hexSmall.toUpperCase();
              String url = e["url"]?.toString() ?? "";
              int parsed = int.parse("ff$hexSmall", radix: 16);
              index.add(IndexedColor(name, Color(parsed), Uri.tryParse(url)));
            }
          }
        }
      }
    }
  }

  ColorLib.empty() {
    displayName = emptyName;
    author = "Unknown";
  }

  late final String displayName;
  late final Uri? source;
  late final String author;
  List<IndexedColor> index = [];

  double distance(Color c1, Color c2,
      {DistanceComputeMethod computeMethod = DistanceComputeMethod.deltaE}) {
    double dx = 1;
    double dy = 1;
    double dz = 1;
    double xWeight = 1;
    double yWeight = 1;
    double zWeight = 1;
    switch (computeMethod) {
      case DistanceComputeMethod.hsvWeighted:
        HSVColor hC1 = HSVColor.fromColor(c1);
        HSVColor hC2 = HSVColor.fromColor(c2);
        dx = (hC1.hue - hC2.hue) / 360;
        dy = hC1.saturation - hC2.saturation;
        dz = hC1.value - hC2.value;
        xWeight = 4;
        yWeight = 2;
        zWeight = 2;
      case DistanceComputeMethod.rgb:
        dx = (c1.red - c2.red).toDouble();
        dy = (c1.green - c2.green).toDouble();
        dz = (c1.blue - c2.blue).toDouble();
      case DistanceComputeMethod.hsv:
        HSVColor hC1 = HSVColor.fromColor(c1);
        HSVColor hC2 = HSVColor.fromColor(c2);
        dx = (hC1.hue - hC2.hue) / 360;
        dy = hC1.saturation - hC2.saturation;
        dz = hC1.value - hC2.value;
      case DistanceComputeMethod.deltaE:
        return deltaE00(
            LabColor.fromRGBValue(c1.value), LabColor.fromRGBValue(c2.value));
    }
    // int dx = c1.red - c2.red;
    // int dy = c1.green - c2.green;
    // int dz = c1.blue - c2.blue;
    return (dx * dx * xWeight) + (dy * dy * yWeight) + (dz * dz * zWeight);
  }

  // Color, match percentage
  List<(IndexedColor, double)> getClosest(Color color, {int amount = 5}) {
    List<(IndexedColor, double)> closest = [];
    if (index.isEmpty) {
      return closest;
    }
    for (IndexedColor col in index) {
      closest.add((col, distance(col.color, color)));
    }
    closest.sort((c1, c2) => Comparable.compare(c1.$2, c2.$2));
    double maxDistance = closest[closest.length - 1].$2;
    return closest.map((e) => (e.$1, 1 - (e.$2 / maxDistance))).toList();
  }
}

class IndexedColor {
  final String name;
  final Color color;
  final Uri? link;

  IndexedColor(this.name, this.color, this.link);
}

class ColorLibReference {
  final String name;
  final File file;

  ColorLibReference(this.name, this.file);

  Future<ColorLib> load() {
    return file.readAsString().then((v) => ColorLib.fromJson(v));
  }
}
