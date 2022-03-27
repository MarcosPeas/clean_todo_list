import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/load_todos_groups_repository.dart';

abstract class LoadTodosGroupsUseCase {
  Future<Either<TodosGroupError, List<TodoGroup>>> call(int count, int offset);
}

class LoadTodosGroupsUseCaseImpl implements LoadTodosGroupsUseCase {
  final LoadTodosGroupsRepository _repository;

  LoadTodosGroupsUseCaseImpl(this._repository);

  @override
  Future<Either<TodosGroupError, List<TodoGroup>>> call(
    int count,
    int offset,
  ) async {
    return await _repository(count, offset);
  }
}
