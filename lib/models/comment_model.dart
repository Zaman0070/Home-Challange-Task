// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  final String? id;
  final String? content;
  final String? posted_at;
  final String? project_id;
  final String? task_id;
  CommentModel({
    this.id,
    this.content,
    this.posted_at,
    this.project_id,
    this.task_id,
  });

  CommentModel copyWith({
    String? id,
    String? content,
    String? posted_at,
    String? project_id,
    String? task_id,
  }) {
    return CommentModel(
      id: id ?? this.id,
      content: content ?? this.content,
      posted_at: posted_at ?? this.posted_at,
      project_id: project_id ?? this.project_id,
      task_id: task_id ?? this.task_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'posted_at': posted_at,
      'project_id': project_id,
      'task_id': task_id,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] != null ? map['id'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      posted_at: map['posted_at'] != null ? map['posted_at'] as String : null,
      project_id: map['project_id'] != null ? map['project_id'] as String : null,
      task_id: map['task_id'] != null ? map['task_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentModel(id: $id, content: $content, posted_at: $posted_at, project_id: $project_id, task_id: $task_id)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.content == content &&
      other.posted_at == posted_at &&
      other.project_id == project_id &&
      other.task_id == task_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      content.hashCode ^
      posted_at.hashCode ^
      project_id.hashCode ^
      task_id.hashCode;
  }
}
