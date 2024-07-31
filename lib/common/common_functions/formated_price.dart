import 'package:intl/intl.dart';

String formatPrice({required double price}) {
  final NumberFormat numberFormat = NumberFormat.currency(symbol: '');
  // String text = priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
  // double value = price / 100;
  String formatted = numberFormat.format(price);
  return formatted;
}
