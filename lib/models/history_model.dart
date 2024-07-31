// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HistoryModel {
  final String? id;
  final String? title;
  final int? time;
  HistoryModel({
    this.id,
    this.title,
    this.time,
  });

  HistoryModel copyWith({
    String? id,
    String? title,
    int? time,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'time': time,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      time: map['time'] != null ? map['time'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) => HistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HistoryModel(id: $id, title: $title, time: $time)';

  @override
  bool operator ==(covariant HistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.time == time;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ time.hashCode;
}
