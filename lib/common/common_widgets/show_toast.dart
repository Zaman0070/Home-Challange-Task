import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: getRegularStyle(fontSize: 12.spMin, color: Colors.white),
    ),
  ));
}

void showToast(
    {required String msg,
    Color? textColor,
    Color? backgroundColor,
    bool long = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? Colors.white,
    textColor: textColor ?? Colors.black,
    fontSize: 12.spMin,
  );
}
