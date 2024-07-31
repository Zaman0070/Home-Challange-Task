// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'due_model.dart';

class TaskModel {
  final String? id;
  final String? creator_id;
  final String? created_at;
  final String? assignee_id;
  final String? assigner_id;
  final int? comment_count;
  final bool? is_completed;
  final String? content;
  final String? description;
  final List<String>? labels;
  final int? order;
  final int? priority;
  final String? project_id;
  final String? section_id;
  final String? parent_id;
  final String? url;
  final DueModel? due;

  TaskModel({
    this.id,
    this.creator_id,
    this.created_at,
    this.assignee_id,
    this.assigner_id,
    this.comment_count,
    this.is_completed,
    this.content,
    this.description,
    this.labels,
    this.order,
    this.priority,
    this.parent_id,
    this.section_id,
    this.project_id,
    this.url,
    this.due,
  });

  TaskModel copyWith({
    String? id,
    String? creator_id,
    String? created_at,
    String? assignee_id,
    String? assigner_id,
    int? comment_count,
    bool? is_completed,
    String? content,
    String? description,
    List<String>? labels,
    int? order,
    int? priority,
    String? project_id,
    String? section_id,
    String? parent_id,
    String? url,
    DueModel? due,
  }) {
    return TaskModel(
      id: id ?? this.id,
      creator_id: creator_id ?? this.creator_id,
      created_at: created_at ?? this.created_at,
      assignee_id: assignee_id ?? this.assignee_id,
      assigner_id: assigner_id ?? this.assigner_id,
      comment_count: comment_count ?? this.comment_count,
      is_completed: is_completed ?? this.is_completed,
      content: content ?? this.content,
      description: description ?? this.description,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      project_id: project_id ?? this.project_id,
      section_id: section_id ?? this.section_id,
      parent_id: parent_id ?? this.parent_id,
      url: url ?? this.url,
      due: due ?? this.due,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator_id': creator_id,
      'created_at': created_at,
      'assignee_id': assignee_id,
      'assigner_id': assigner_id,
      'comment_count': comment_count,
      'is_completed': is_completed,
      'content': content,
      'description': description,
      'labels': labels,
      'order': order,
      'priority': priority,
      'project_id': project_id,
      'section_id': section_id,
      'parent_id': parent_id,
      'url': url,
      'due': due?.toMap(),
    };
  }

  FormData toFormData() {
    final Map<String, dynamic> data = toMap();
    final formData = FormData.fromMap({
      'id': data['id'],
      'creator_id': data['creator_id'],
      'created_at': data['created_at'],
      'assignee_id': data['assignee_id'],
      'assigner_id': data['assigner_id'],
      'comment_count': data['comment_count'],
      'is_completed': data['is_completed'],
      'content': data['content'],
      'description': data['description'],
      'labels': data['labels'],
      'order': data['order'],
      'priority': data['priority'],
      'project_id': data['project_id'],
      'section_id': data['section_id'],
      'parent_id': data['parent_id'],
      'url': data['url'],
      'due': data['due'],
    });
    return formData;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String?,
      creator_id: map['creator_id'] as String?,
      created_at: map['created_at'] as String?,
      assignee_id: map['assignee_id'] as String?,
      assigner_id: map['assigner_id'] as String?,
      comment_count: map['comment_count'] as int?,
      is_completed: map['is_completed'] as bool?,
      content: map['content'] as String?,
      description: map['description'] as String?,
      labels: map['labels'] != null ? List<String>.from(map['labels']) : null,
      order: map['order'] as int?,
      priority: map['priority'] as int?,
      project_id: map['project_id'] as String?,
      section_id: map['section_id'] as String?,
      parent_id: map['parent_id'] as String?,
      url: map['url'] as String?,
      due: map['due'] != null
          ? DueModel.fromMap(map['due'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, creator_id: $creator_id, created_at: $created_at, assignee_id: $assignee_id, assigner_id: $assigner_id, comment_count: $comment_count, is_completed: $is_completed, content: $content, description: $description, labels: $labels, order: $order, priority: $priority, project_id: $project_id, section_id: $section_id, parent_id: $parent_id, url: $url, due: $due)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.creator_id == creator_id &&
        other.created_at == created_at &&
        other.assignee_id == assignee_id &&
        other.assigner_id == assigner_id &&
        other.comment_count == comment_count &&
        other.is_completed == is_completed &&
        other.content == content &&
        other.description == description &&
        listEquals(other.labels, labels) &&
        other.order == order &&
        other.priority == priority &&
        other.project_id == project_id &&
        other.section_id == section_id &&
        other.parent_id == parent_id &&
        other.url == url &&
        other.due == due;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        creator_id.hashCode ^
        created_at.hashCode ^
        assignee_id.hashCode ^
        assigner_id.hashCode ^
        comment_count.hashCode ^
        is_completed.hashCode ^
        content.hashCode ^
        description.hashCode ^
        labels.hashCode ^
        order.hashCode ^
        priority.hashCode ^
        project_id.hashCode ^
        section_id.hashCode ^
        parent_id.hashCode ^
        url.hashCode ^
        due.hashCode;
  }
}
