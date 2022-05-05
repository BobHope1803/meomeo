//Use for text cannot copy
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customText(
    {String? title,
      int? maxLines,
      double? fontSize,
      fontWeight,
      Color? color,
      textAlign,
      double? minFontSize,
      double? maxFontSize,
      TextOverflow? overflow,
      Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: AutoSizeText(
      "$title",
      textAlign: textAlign,
      minFontSize: minFontSize ?? 1,
      maxFontSize: maxFontSize ?? 30,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.montserrat(
        decoration: TextDecoration.none,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: overflow ?? TextOverflow.ellipsis,
    ),
  );
}