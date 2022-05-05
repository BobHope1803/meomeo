import 'dart:ui';

colorHexa(String hexColor, {double opacity = 1}) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16)).withOpacity(opacity);
}

Color colorLogo = colorHexa("f03660");