import 'dart:convert';

import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';

class TodoGroupDto extends TodoGroup {
  TodoGroupDto({
    required String? id,
    required String title,
    required String subtitle,
    required DateTime createdAt,
  }) : super(id: id, title: title, subtitle: subtitle, createdAt: createdAt);

  TodoGroupDto.fromEntity(TodoGroup todoGroup)
      : super(
          id: todoGroup.id,
          title: todoGroup.title,
          subtitle: todoGroup.subtitle,
          createdAt: todoGroup.createdAt,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'created_at': createdAt,
    };
  }

  static TodoGroupDto fromMap(Map<String, dynamic> map) {
    return TodoGroupDto(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      createdAt: map['created_at'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  static TodoGroupDto fromJson(String json) => fromMap(jsonDecode(json));

  TodoGroupDto copyWith(
      {String? id, String? title, String? subtitle, DateTime? createdAt}) {
    return TodoGroupDto(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
