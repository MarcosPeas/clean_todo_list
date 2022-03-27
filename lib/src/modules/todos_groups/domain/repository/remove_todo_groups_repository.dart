import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';

abstract class RemoveTodoGroupsRepository {
  Future<Either<TodosGroupError, void>> call(String groupId);
}
