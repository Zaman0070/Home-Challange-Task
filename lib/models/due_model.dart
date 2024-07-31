// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DueModel {
  final String? date;
  final bool? is_recurring;
  final String? datetime;
  final String? string;
  final String? timezone;
  DueModel({
    this.date,
    this.is_recurring,
    this.datetime,
    this.string,
    this.timezone,
  });

  DueModel copyWith({
    String? date,
    bool? is_recurring,
    String? datetime,
    String? string,
    String? timezone,
  }) {
    return DueModel(
      date: date ?? this.date,
      is_recurring: is_recurring ?? this.is_recurring,
      datetime: datetime ?? this.datetime,
      string: string ?? this.string,
      timezone: timezone ?? this.timezone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'is_recurring': is_recurring,
      'datetime': datetime,
      'string': string,
      'timezone': timezone,
    };
  }

  factory DueModel.fromMap(Map<String, dynamic> map) {
    return DueModel(
      date: map['date'] != null ? map['date'] as String : null,
      is_recurring: map['is_recurring'] != null ? map['is_recurring'] as bool : null,
      datetime: map['datetime'] != null ? map['datetime'] as String : null,
      string: map['string'] != null ? map['string'] as String : null,
      timezone: map['timezone'] != null ? map['timezone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DueModel.fromJson(String source) => DueModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DueModel(date: $date, is_recurring: $is_recurring, datetime: $datetime, string: $string, timezone: $timezone)';
  }

  @override
  bool operator ==(covariant DueModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      other.is_recurring == is_recurring &&
      other.datetime == datetime &&
      other.string == string &&
      other.timezone == timezone;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      is_recurring.hashCode ^
      datetime.hashCode ^
      string.hashCode ^
      timezone.hashCode;
  }
}
