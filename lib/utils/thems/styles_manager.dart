import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return GoogleFonts.urbanist(
    color: color,
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
  );
}

// regular style
TextStyle getRegularStyle({double fontSize = 16, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.regular, color);
}

// medium style
TextStyle getMediumStyle({double fontSize = 16, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.medium, color);
}

// medium style
TextStyle getLightStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.light, color);
}

// bold style
TextStyle getBoldStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.bold, color);
}

// semibold style
TextStyle getSemiBoldStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.semiBold, color);
}

TextStyle getSemiBoldUnderlineStyle({
  double fontSize = 14,
  required Color color,
}) {
  return GoogleFonts.urbanist(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeightManager.semiBold,
      decoration: TextDecoration.underline);
}

TextStyle getRegularUnderlineStyle({
  double fontSize = 14,
  required Color color,
}) {
  return GoogleFonts.urbanist(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeightManager.regular,
      decoration: TextDecoration.underline,
      decorationColor: color);
}

// bold style
TextStyle getExtraBoldStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.extraBold, color);
}
