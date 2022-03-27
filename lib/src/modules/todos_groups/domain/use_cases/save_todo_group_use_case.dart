import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/save_todo_group_repository.dart';

abstract class SaveTodoGroupUseCase {
  Future<Either<TodosGroupError, TodoGroup>> call(TodoGroup todoGroup);
}

class SaveTodoGroupUseCaseImpl implements SaveTodoGroupUseCase {
  final SaveTodoGroupRepository _repository;

  SaveTodoGroupUseCaseImpl(this._repository);

  @override
  Future<Either<TodosGroupError, TodoGroup>> call(TodoGroup todoGroup) {
    return _repository(todoGroup);
  }
}
