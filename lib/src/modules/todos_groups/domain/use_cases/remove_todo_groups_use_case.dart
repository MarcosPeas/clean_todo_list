import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/remove_todo_groups_repository.dart';

abstract class RemoveTodoGroupsUseCase {
  Future<Either<TodosGroupError, void>> call(String groupId);
}

class RemoveTodoGroupUseCaseImpl implements RemoveTodoGroupsUseCase {
  final RemoveTodoGroupsRepository _repository;

  RemoveTodoGroupUseCaseImpl(this._repository);

  @override
  Future<Either<TodosGroupError, void>> call(String groupId) {
    return _repository(groupId);
  }
}
