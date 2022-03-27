import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/remove_todos_group_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/remove_todo_groups_repository.dart';

class RemoveTodosGroupRepositoryImpl implements RemoveTodoGroupsRepository {
  final RemoveTodosGroupDataSource _removeTodosGroupDataSource;

  RemoveTodosGroupRepositoryImpl(this._removeTodosGroupDataSource);

  @override
  Future<Either<TodosGroupError, void>> call(String groupId) async {
    try {
      await _removeTodosGroupDataSource(groupId);
      return const Right(null);
    } on RemoveTodoGroupsError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        RemoveTodoGroupsError(
          message: 'Não foi possível remover o grupo de a fazeres',
          sourceClass: runtimeType.toString(),
        ),
      );
    }
  }
}
