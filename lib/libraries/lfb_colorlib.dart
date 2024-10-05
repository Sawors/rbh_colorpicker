import 'package:delta_e/delta_e.dart';
import 'package:flutter/material.dart';
import 'package:rbh_colorpicker/libraries/colorlib.dart';

enum LeFrancBourgeoisColor {
  blancDeTitaneZinc(
      name: "Blanc de Titane Zinc", color: Color.fromARGB(255, 242, 242, 235)),
  blancDArgentImit(
      name: "Blanc d'Argent (Imit.)",
      color: Color.fromARGB(255, 240, 241, 232)),
  blancDeTitane(
      name: "Blanc de Titane", color: Color.fromARGB(255, 241, 241, 236)),
  blancDeZinc(name: "Blanc de Zinc", color: Color.fromARGB(255, 240, 241, 232)),
  jauneDeNaples(
      name: "Jaune de Naples", color: Color.fromARGB(255, 247, 190, 119)),
  jauneDeNaplesClair(
      name: "Jaune de Naples Clair", color: Color.fromARGB(255, 251, 225, 155)),
  jaunePoterie(
      name: "Jaune Poterie", color: Color.fromARGB(255, 249, 189, 113)),
  jauneDeNaplesFonce(
      name: "Jaune de Naples Foncé", color: Color.fromARGB(255, 235, 162, 70)),
  orangeTransparent(
      name: "Orange Transparent", color: Color.fromARGB(255, 233, 91, 13)),
  jauneDeCadmiumCitron(
      name: "Jaune de Cadmium Citron", color: Color.fromARGB(255, 255, 226, 0)),
  jauneJaponaisClair(
      name: "Jaune Japonais Clair", color: Color.fromARGB(255, 255, 216, 0)),
  jauneDeCadmium(
      name: "Jaune de Cadmium", color: Color.fromARGB(255, 246, 166, 0)),
  jauneJaponaisCitron(
      name: "Jaune Japonais Citron", color: Color.fromARGB(255, 255, 233, 0)),
  jauneTransparent(
      name: "Jaune Transparent", color: Color.fromARGB(255, 253, 229, 0)),
  jauneLefranc(name: "Jaune Lefranc", color: Color.fromARGB(255, 249, 230, 33)),
  jauneSoufre(name: "Jaune Soufre", color: Color.fromARGB(255, 219, 213, 64)),
  jauneOrangeSansCadmium(
      name: "Jaune Orange Sans Cadmium",
      color: Color.fromARGB(255, 236, 104, 52)),
  jauneSansCadmium(
      name: "Jaune Sans Cadmium", color: Color.fromARGB(255, 246, 166, 0)),
  stilDeGrainJaune(
      name: "Stil de Grain Jaune", color: Color.fromARGB(255, 245, 163, 0)),
  jauneDeCadmiumOrange(
      name: "Jaune de Cadmium Orange",
      color: Color.fromARGB(255, 236, 104, 52)),
  jauneFonceSansCadmium(
      name: "Jaune Foncé Sans Cadmium",
      color: Color.fromARGB(255, 239, 132, 0)),
  orangeJaponais(
      name: "Orange Japonais", color: Color.fromARGB(255, 244, 154, 0)),
  jauneSahara(name: "Jaune Sahara", color: Color.fromARGB(255, 245, 159, 0)),
  jauneIndienImit(
      name: "Jaune Indien (Imit.)", color: Color.fromARGB(255, 242, 177, 0)),
  jauneJaponaisFonce(
      name: "Jaune Japonais Foncé", color: Color.fromARGB(255, 255, 207, 0)),
  jauneClairSansCadmium(
      name: "Jaune Clair Sans Cadmium",
      color: Color.fromARGB(255, 253, 196, 0)),
  laqueCarmineeFixe(
      name: "Laque Carminée Fixe", color: Color.fromARGB(255, 180, 29, 40)),
  rougeLefranc(name: "Rouge Lefranc", color: Color.fromARGB(255, 223, 30, 32)),
  rougeDeChine(name: "Rouge De Chine", color: Color.fromARGB(255, 222, 53, 59)),
  carminDAlizarine(
      name: "Carmin d'Alizarine", color: Color.fromARGB(255, 176, 30, 34)),
  laqueDeGaranceCramoisie(
      name: "Laque de Garance Cramoisie",
      color: Color.fromARGB(255, 178, 27, 41)),
  rougeRubis(name: "Rouge Rubis", color: Color.fromARGB(255, 198, 24, 44)),
  rougeDeQuinacridone(
      name: "Rouge de Quinacridone", color: Color.fromARGB(255, 225, 36, 44)),
  rougeFonceSansCadmium(
      name: "Rouge Foncé Sans Cadmium",
      color: Color.fromARGB(255, 166, 47, 51)),
  rougeVifTransparent(
      name: "Rouge Vif Transparent", color: Color.fromARGB(255, 202, 36, 36)),
  rougeDeCadmiumMoyen(
      name: "Rouge de Cadmium Moyen", color: Color.fromARGB(255, 209, 44, 46)),
  rougeMoyenSansCadmium(
      name: "Rouge Moyen Sans Cadmium",
      color: Color.fromARGB(255, 209, 44, 46)),
  rougeClairSansCadmium(
      name: "Rouge Clair Sans Cadmium",
      color: Color.fromARGB(255, 229, 54, 40)),
  rougeVermillon(
      name: "Rouge Vermillon", color: Color.fromARGB(255, 228, 44, 27)),
  rougeDeCadmiumClair(
      name: "Rouge de Cadmium Clair", color: Color.fromARGB(255, 229, 54, 40)),
  violetOutremer(
      name: "Violet Outremer", color: Color.fromARGB(255, 84, 47, 136)),
  violetMineralClair(
      name: "Violet Minéral Clair", color: Color.fromARGB(255, 117, 39, 118)),
  laquePourpre(name: "Laque Pourpre", color: Color.fromARGB(255, 100, 39, 52)),
  laqueDeGaranceRose(
      name: "Laque de Garance Rose", color: Color.fromARGB(255, 214, 51, 61)),
  violetDeDioxazine(
      name: "Violet de Dioxazine", color: Color.fromARGB(255, 68, 29, 96)),
  mauveBleute(name: "Mauve Bleuté", color: Color.fromARGB(255, 96, 44, 121)),
  violetDeCobalt(
      name: "Violet de Cobalt", color: Color.fromARGB(255, 153, 73, 149)),
  magenta(name: "Magenta", color: Color.fromARGB(255, 167, 26, 121)),
  rougeGrenat(name: "Rouge Grenat", color: Color.fromARGB(255, 144, 26, 46)),
  violetPermanent(
      name: "Violet Permanent", color: Color.fromARGB(255, 167, 25, 57)),
  rosePoterie(name: "Rose Poterie", color: Color.fromARGB(255, 239, 135, 125)),
  bleuDeCeruleumImit(
      name: "Bleu de Céruléum (Imit.)", color: Color.fromARGB(255, 8, 87, 163)),
  bleuSaphir(name: "Bleu Saphir", color: Color.fromARGB(255, 0, 72, 116)),
  cobaltTurquoiseClair(
      name: "Cobalt Turquoise Clair", color: Color.fromARGB(255, 0, 164, 173)),
  bleuDeCobaltTurquoise(
      name: "Bleu de Cobalt Turquoise",
      color: Color.fromARGB(255, 0, 101, 134)),
  bleuOcean(name: "Bleu Océan", color: Color.fromARGB(255, 0, 142, 209)),
  bleuEspace(name: "Bleu Espace", color: Color.fromARGB(255, 0, 141, 205)),
  bleuDeCeruleum(
      name: "Bleu de Céruléum", color: Color.fromARGB(255, 0, 114, 186)),
  indigo(name: "Indigo", color: Color.fromARGB(255, 40, 45, 68)),
  bleuHoggar(name: "Bleu Hoggar", color: Color.fromARGB(255, 55, 36, 110)),
  bleuHortensia(
      name: "Bleu Hortensia", color: Color.fromARGB(255, 47, 30, 100)),
  bleuDeCobaltImit(
      name: "Bleu de Cobalt (Imit.)", color: Color.fromARGB(255, 36, 64, 146)),
  bleuRex(name: "Bleu Rex", color: Color.fromARGB(255, 99, 141, 200)),
  bleuDeCobaltLefranc(
      name: "Bleu de Cobalt Lefranc", color: Color.fromARGB(255, 59, 39, 131)),
  bleuOutremerNuanceVerte(
      name: "Bleu Outremer (Nuance Verte)",
      color: Color.fromARGB(255, 61, 38, 131)),
  bleuDeCobalt(name: "Bleu de Cobalt", color: Color.fromARGB(255, 50, 76, 155)),
  bleuOutremerFonce(
      name: "Bleu Outremer Foncé", color: Color.fromARGB(255, 65, 38, 130)),
  bleuIndien(name: "Bleu Indien", color: Color.fromARGB(255, 62, 36, 112)),
  bleuDePrusse(name: "Bleu de Prusse", color: Color.fromARGB(255, 40, 25, 84)),
  vertEmeraude(name: "Vert Emeraude", color: Color.fromARGB(255, 0, 108, 84)),
  vertArmorPhtalo(
      name: "Vert Armor Phtalo", color: Color.fromARGB(255, 0, 94, 64)),
  vertJaponaisClair(
      name: "Vert Japonais Clair", color: Color.fromARGB(255, 0, 136, 127)),
  vertAnglaisN5(
      name: "Vert Anglais N° 5", color: Color.fromARGB(255, 195, 209, 29)),
  terreVerte(name: "Terre Verte", color: Color.fromARGB(255, 129, 165, 120)),
  stilDeGrainVert(
      name: "Stil de Grain Vert", color: Color.fromARGB(255, 178, 140, 19)),
  vertDeVessiePermanent(
      name: "Vert de Vessie Permanent",
      color: Color.fromARGB(255, 91, 112, 37)),
  vertDePrusse(name: "Vert de Prusse", color: Color.fromARGB(255, 27, 59, 34)),
  vertOxydeDeChrome(
      name: "Vert Oxyde de Chrome", color: Color.fromARGB(255, 78, 102, 77)),
  vertAnglaisN1(
      name: "Vert Anglais N° 1", color: Color.fromARGB(255, 52, 83, 72)),
  vertAnglaisN2(
      name: "Vert Anglais N° 2", color: Color.fromARGB(255, 0, 108, 57)),
  vertClairSansCadmium(
      name: "Vert Clair Sans Cadmium",
      color: Color.fromARGB(255, 125, 179, 56)),
  vertJaponaisMoyen(
      name: "Vert Japonais Moyen", color: Color.fromARGB(255, 0, 109, 68)),
  vertJaponaisFonce(
      name: "Vert Japonais Foncé", color: Color.fromARGB(255, 0, 87, 61)),
  vertVeroneseImit(
      name: "Vert Véronèse (Imit.)", color: Color.fromARGB(255, 0, 134, 98)),
  vertArmor(name: "Vert Armor", color: Color.fromARGB(255, 0, 69, 64)),
  vertOlive(name: "Vert Olive", color: Color.fromARGB(255, 54, 44, 31)),
  terreDOmbreNaturelle(
      name: "Terre d'Ombre Naturelle", color: Color.fromARGB(255, 100, 78, 60)),
  terreDOmbreNaturelleTransparente(
      name: "Terre d'Ombre Naturelle Transparente",
      color: Color.fromARGB(255, 82, 60, 51)),
  brunTransparent(
      name: "Brun Transparent", color: Color.fromARGB(255, 91, 42, 41)),
  brunVanDyck(name: "Brun Van Dyck", color: Color.fromARGB(255, 72, 45, 46)),
  brunDeMars(name: "Brun de Mars", color: Color.fromARGB(255, 97, 55, 54)),
  terreDeSienneBruleeTransparente(
      name: "Terre de Sienne Brulée Transparente",
      color: Color.fromARGB(255, 159, 58, 49)),
  ocreRougeTransparente(
      name: "Ocre Rouge Transparente", color: Color.fromARGB(255, 99, 38, 30)),
  rougeDeMars(name: "Rouge de Mars", color: Color.fromARGB(255, 133, 63, 54)),
  ocreDeChair(name: "Ocre de Chair", color: Color.fromARGB(255, 155, 73, 55)),
  terreDeSienneNaturelle(
      name: "Terre de Sienne Naturelle",
      color: Color.fromARGB(255, 178, 107, 46)),
  ocreJauneTransparent(
      name: "Ocre Jaune Transparent", color: Color.fromARGB(255, 217, 132, 34)),
  ocreDOr(name: "Ocre d'Or", color: Color.fromARGB(255, 174, 119, 57)),
  ocreJauneClair(
      name: "Ocre Jaune Clair", color: Color.fromARGB(255, 192, 133, 59)),
  ocreJaune(name: "Ocre Jaune", color: Color.fromARGB(255, 163, 120, 62)),
  rougeDeVenise(
      name: "Rouge de Venise", color: Color.fromARGB(255, 187, 69, 38)),
  rougeIndien(name: "Rouge Indien", color: Color.fromARGB(255, 130, 63, 59)),
  terreDeSienneBrulee(
      name: "Terre de Sienne Brulée", color: Color.fromARGB(255, 120, 59, 49)),
  caputMortuum(name: "Caput Mortuum", color: Color.fromARGB(255, 109, 66, 67)),
  terreDOmbreBrulee(
      name: "Terre d'Ombre Brulée", color: Color.fromARGB(255, 81, 54, 52)),
  noirDePerylene(
      name: "Noir de Pérylène", color: Color.fromARGB(255, 50, 51, 43)),
  noirDIvoire(name: "Noir d'Ivoire", color: Color.fromARGB(255, 36, 32, 33)),
  noirDeMars(name: "Noir de Mars", color: Color.fromARGB(255, 59, 56, 58)),
  grisFusain(name: "Gris Fusain", color: Color.fromARGB(255, 59, 58, 61)),
  terreDeCassel(
      name: "Terre de Cassel", color: Color.fromARGB(255, 35, 30, 35)),
  grisDePayne(name: "Gris de Payne", color: Color.fromARGB(255, 56, 58, 69)),
  grisJaune(name: "Gris Jaune", color: Color.fromARGB(255, 149, 139, 123)),
  noirDeLampe(name: "Noir de Lampe", color: Color.fromARGB(255, 45, 41, 43)),
  orRenaissance(
      name: "Or Renaissance", color: Color.fromARGB(255, 201, 140, 91)),
  or(name: "Or", color: Color.fromARGB(255, 221, 184, 120)),
  cuivre(name: "Cuivre", color: Color.fromARGB(255, 194, 99, 71)),
  argent(name: "Argent", color: Color.fromARGB(255, 163, 163, 164)),
  blancIridescent(
      name: "Blanc Iridescent", color: Color.fromARGB(255, 225, 222, 213)),
  bronze(name: "Bronze", color: Color.fromARGB(255, 134, 107, 79)),
  ;

  const LeFrancBourgeoisColor({required this.name, required this.color});

  final Color color;
  final String name;

  Uri getLink() {
    String nameCleaned = name
        .toLowerCase()
        .replaceAll(" ", "-")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(".", "");
    const String lfr =
        "https://www.lefrancbourgeois.com/fr/produit/peinture-a-lhuile-extra-fine/?attribute_pa_lb_colour_name=";
    String safe = Uri.encodeComponent(nameCleaned);
    return Uri.parse(lfr + safe);
  }
}

enum DistanceComputeMethod { HSVWeighted, RGB, HSV, DeltaE }

class LeFrancBourgeoisColorLib extends ColorLib {
  @override
  List<LeFrancBourgeoisColor> get index => LeFrancBourgeoisColor.values;

  @override
  String get displayName => "LeFrancBourgeois";

  double distance(Color c1, Color c2,
      {DistanceComputeMethod computeMethod = DistanceComputeMethod.DeltaE}) {
    double dx = 1;
    double dy = 1;
    double dz = 1;
    double xWeight = 1;
    double yWeight = 1;
    double zWeight = 1;
    switch (computeMethod) {
      case DistanceComputeMethod.HSVWeighted:
        HSVColor hC1 = HSVColor.fromColor(c1);
        HSVColor hC2 = HSVColor.fromColor(c2);
        dx = (hC1.hue - hC2.hue) / 360;
        dy = hC1.saturation - hC2.saturation;
        dz = hC1.value - hC2.value;
        xWeight = 4;
        yWeight = 2;
        zWeight = 2;
      case DistanceComputeMethod.RGB:
        dx = (c1.red - c2.red).toDouble();
        dy = (c1.green - c2.green).toDouble();
        dz = (c1.blue - c2.blue).toDouble();
      case DistanceComputeMethod.HSV:
        HSVColor hC1 = HSVColor.fromColor(c1);
        HSVColor hC2 = HSVColor.fromColor(c2);
        dx = (hC1.hue - hC2.hue) / 360;
        dy = hC1.saturation - hC2.saturation;
        dz = hC1.value - hC2.value;
      case DistanceComputeMethod.DeltaE:
        return deltaE00(
            LabColor.fromRGBValue(c1.value), LabColor.fromRGBValue(c2.value));
    }
    // int dx = c1.red - c2.red;
    // int dy = c1.green - c2.green;
    // int dz = c1.blue - c2.blue;
    return (dx * dx * xWeight) + (dy * dy * yWeight) + (dz * dz * zWeight);
  }

  @override
  // Color, match percentage
  List<(LeFrancBourgeoisColor, double)> getClosest(Color color,
      {int amount = 5}) {
    List<(LeFrancBourgeoisColor, double)> closest = [];
    for (LeFrancBourgeoisColor col in index) {
      closest.add((col, distance(col.color, color)));
    }
    closest.sort((c1, c2) => Comparable.compare(c1.$2, c2.$2));
    double maxDistance = closest[closest.length - 1].$2;
    return closest.map((e) => (e.$1, 1 - (e.$2 / maxDistance))).toList();
  }
}
