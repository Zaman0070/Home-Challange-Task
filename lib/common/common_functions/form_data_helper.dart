import 'package:dio/dio.dart';

abstract class MapConvertible {
  Map<String, dynamic> toMap();
}

Future<FormData> toFormData<T extends MapConvertible>(T model) async {
  Map<String, dynamic> dataMap = model.toMap();

  FormData formData = FormData();
  for (var entry in dataMap.entries) {
    final key = entry.key;
    final value = entry.value;
    formData.fields.add(MapEntry(key, value.toString()));
  }

  return formData;
}
