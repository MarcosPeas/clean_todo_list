import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/update_todos_group_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/update_todos_group_repository.dart';

class UpdateTodosGroupRepositoryImpl implements UpdateTodosGroupsRepository {
  final UpdateTodosGroupDatasource _updateTodosGroupDatasource;

  UpdateTodosGroupRepositoryImpl(this._updateTodosGroupDatasource);

  @override
  Future<Either<TodosGroupError, TodoGroup>> call(TodoGroup todoGroup) async {
    try {
      final result = await _updateTodosGroupDatasource(
        TodoGroupDto.fromEntity(todoGroup),
      );
      return Right(result);
    } on TodosGroupError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        UpdateTodoGroupsError(
          message: 'Não foi possível atualizar o grupo de a fazeres',
          sourceClass: runtimeType.toString(),
        ),
      );
    }
  }
}
