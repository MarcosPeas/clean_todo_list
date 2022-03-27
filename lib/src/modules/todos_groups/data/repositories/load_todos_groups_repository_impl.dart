import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/load_todos_groups_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/load_todos_groups_repository.dart';

class LoadTodosGroupsRepositoryImpl implements LoadTodosGroupsRepository {
  final LoadTodosGroupsDataSource _loadTodosGroupsDataSource;

  LoadTodosGroupsRepositoryImpl(this._loadTodosGroupsDataSource);

  @override
  Future<Either<TodosGroupError, List<TodoGroup>>> call(
    int count,
    int offset,
  ) async {
    try {
      final result = await _loadTodosGroupsDataSource(count, offset);
      return Right(result);
    } on TodosGroupError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        LoadTodosGroupsError(
          message: 'Não foi possível carregar os grupos de a fazeres',
          sourceClass: runtimeType.toString(),
        ),
      );
    }
  }
}
