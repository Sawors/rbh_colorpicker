import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rbh_colorpicker/color_selector.dart';
import 'package:rbh_colorpicker/colorlib.dart';

import 'color_card.dart';

void main() {
  runApp(const MyApp());
}

class ColorStore extends InheritedWidget {
  ColorStore(
      {super.key,
      required this.color,
      required this.onColorChange,
      required super.child});

  final Color color;
  final double minimumMatchPercentage = 0.85;
  final void Function(Color newColor) onColorChange;

  @override
  bool updateShouldNotify(ColorStore oldWidget) => color != oldWidget.color;

  static ColorStore? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorStore>();
  }

  static ColorStore of(BuildContext context) {
    final ColorStore? result = maybeOf(context);
    assert(result != null, 'No ColorPicker found in context');
    return result!;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sélecteur De Couleurs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Directory getLocalLibraryDir() {
    const String identifier = "rbh-colorpicker";
    if (Platform.isLinux || Platform.isMacOS) {
      return Directory(
          "${Platform.environment['HOME']}/.local/share/$identifier/libraries");
    } else if (Platform.isWindows) {
      return Directory(
          "${Platform.environment['UserProfile']}\\$identifier\\libraries");
    }

    throw PlatformException(code: "1", message: "Platform unsupported");
  }

  Color color = Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));

  List<ColorLibReference> availableLibs = [];

  late Future<ColorLib> libFetch;

  Future<List<ColorLibReference>> loadColorLibs() async {
    final Directory localLibDir = getLocalLibraryDir();
    if (!await localLibDir.exists()) {
      await localLibDir.create(recursive: true);
    }
    return localLibDir
        .list()
        .map((f) {
          if (f.statSync().type == FileSystemEntityType.file &&
              f.path.endsWith(".json")) {
            try {
              Map<String, dynamic> content =
                  jsonDecode((f as File).readAsStringSync());
              String name = content["name"] ?? "Unknown Library";
              return ColorLibReference(name, f);
            } on Exception {
              // ignore failed library
            }
          }
          return ColorLibReference("", File(""));
        })
        .where((t) => t.name.isNotEmpty)
        .toList();
  }

  List<ColorLibReference> loadColorLibsSync() {
    final Directory localLibDir = getLocalLibraryDir();
    if (!localLibDir.existsSync()) {
      localLibDir.createSync(recursive: true);
    }
    List<ColorLibReference> refs = [];
    for (FileSystemEntity f in localLibDir.listSync()) {
      if (f.statSync().type == FileSystemEntityType.file &&
          f.path.endsWith(".json")) {
        try {
          Map<String, dynamic> content =
              jsonDecode((f as File).readAsStringSync());
          String name = content["name"] ?? "Unknown Library";
          refs.add(ColorLibReference(name, f));
        } on Exception {
          // ignore failed library
        }
      }
    }
    return refs;
  }

  @override
  void initState() {
    super.initState();
    availableLibs = loadColorLibsSync();
    libFetch = availableLibs.isNotEmpty
        ? availableLibs.first.load()
        : Future.value(ColorLib(""));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return FutureBuilder(
      future: libFetch,
      builder: (BuildContext context, AsyncSnapshot<ColorLib> snapshot) {
        ColorLib? colorLib = snapshot.hasData ? snapshot.data : null;

        Widget content = snapshot.hasData && colorLib != null
            ? ColorStore(
                color: color,
                onColorChange: (Color newColor) {
                  setState(() {
                    color = newColor;
                  });
                },
                child: Builder(builder: (context) {
                  ColorStore store = ColorStore.of(context);
                  List<(IndexedColor, double)> closest =
                      colorLib.getClosest(color, amount: 12);
                  int splitIndex = max(
                      0,
                      closest.indexWhere(
                          (e) => e.$2 < store.minimumMatchPercentage));
                  List<(IndexedColor, double)> valid =
                      closest.sublist(0, splitIndex);
                  List<(IndexedColor, double)> other =
                      closest.sublist(splitIndex);
                  TextStyle? interTitleStyle =
                      Theme.of(context).textTheme.headlineSmall;

                  Widget bestMatchWidget = valid.isNotEmpty
                      ? Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Column(
                                children: [
                                  Text(
                                    "Meilleures Correspondances",
                                    style: interTitleStyle,
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: GridView.extent(
                                          maxCrossAxisExtent: 400,
                                          childAspectRatio: 3,
                                          children: valid
                                              .map((t) => ColorCard(
                                                  color: t.$1,
                                                  matchPercentage: t.$2))
                                              .toList(),
                                        )
                                        // ListView.builder(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       vertical: 10, horizontal: 100),
                                        //   itemCount: valid.length,
                                        //   itemBuilder: (BuildContext context, int index) {
                                        //     return ColorCard(
                                        //       color: valid[index].$1,
                                        //       matchPercentage: valid[index].$2,
                                        //     );
                                        //   },
                                        // ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              children: [
                                Text(
                                  "Meilleures Correspondances",
                                  style: interTitleStyle,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "Aucune correspondance suffisante n'a été trouvée.",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                  const double maxWidth = 1920;
                  return Center(
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    child: SizedBox(
                      width: maxWidth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                width: maxWidth / 3,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Container(
                                          padding: const EdgeInsets.all(6),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                    "Bibliothèque de Couleurs : "),
                                              ),
                                              Expanded(
                                                child: DropdownMenu(
                                                    menuHeight: 300,
                                                    initialSelection:
                                                        availableLibs.isNotEmpty
                                                            ? availableLibs
                                                                .first.file
                                                            : null,
                                                    onSelected: (f) {
                                                      if (f == null) {
                                                        return;
                                                      }
                                                      setState(() {
                                                        libFetch = f
                                                            .readAsString()
                                                            .then((v) =>
                                                                ColorLib
                                                                    .fromJson(
                                                                        v));
                                                      });
                                                    },
                                                    dropdownMenuEntries:
                                                        availableLibs
                                                            .map((r) =>
                                                                DropdownMenuEntry(
                                                                    value:
                                                                        r.file,
                                                                    label:
                                                                        r.name))
                                                            .toList(
                                                                growable:
                                                                    false)),
                                              ),
                                              IconButton(
                                                  tooltip:
                                                      "Recharger les bibliothèques disponibles",
                                                  onPressed: () {
                                                    setState(() {
                                                      availableLibs =
                                                          loadColorLibsSync();
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.refresh_rounded))
                                            ],
                                          )),
                                    ),
                                    Expanded(child: ColorSelector()),
                                    Expanded(child: Container())
                                  ],
                                )),
                            Expanded(
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                  bestMatchWidget,
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Autres Correspondances",
                                              style: interTitleStyle,
                                            ),
                                            Expanded(
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: GridView.extent(
                                                    maxCrossAxisExtent: 400,
                                                    childAspectRatio: 3,
                                                    children: other
                                                        .map((t) => ColorCard(
                                                            color: t.$1,
                                                            matchPercentage:
                                                                t.$2))
                                                        .toList(),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chargement des bibliothèques de couleur...",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              );
        return Scaffold(
            appBar: AppBar(
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
            ),
            body: content);
      },
    );
  }
}
