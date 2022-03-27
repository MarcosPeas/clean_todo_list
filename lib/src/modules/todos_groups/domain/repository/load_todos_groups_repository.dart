import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';

abstract class LoadTodosGroupsRepository {
  Future<Either<TodosGroupError, List<TodoGroup>>> call(int count, int offset);
}
