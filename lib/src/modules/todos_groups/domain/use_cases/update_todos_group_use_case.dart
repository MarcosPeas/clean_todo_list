import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/update_todos_group_repository.dart';

abstract class UpdateTodosGroupUseCase {
  Future<Either<TodosGroupError, TodoGroup>> call(TodoGroup todoGroup);
}

class UpdateTodosGroupUseCaseImpl implements UpdateTodosGroupUseCase {
  final UpdateTodosGroupsRepository _repository;

  UpdateTodosGroupUseCaseImpl(this._repository);

  @override
  Future<Either<TodosGroupError, TodoGroup>> call(TodoGroup todoGroup) {
    return _repository(todoGroup);
  }
}
