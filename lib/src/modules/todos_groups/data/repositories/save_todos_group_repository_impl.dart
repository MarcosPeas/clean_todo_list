import 'package:dartz/dartz.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/save_todos_groups_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/save_todo_group_repository.dart';
import 'package:uuid/uuid.dart';

class SaveTodosGroupRepositoryImpl implements SaveTodoGroupRepository {
  final SaveTodosGroupsDatasource saveTodosGroupsDatasource;
  final Uuid uuid;

  SaveTodosGroupRepositoryImpl({
    required this.saveTodosGroupsDatasource,
    required this.uuid,
  });

  @override
  Future<Either<TodosGroupError, TodoGroup>> call(TodoGroup todoGroup) async {
    try {
      final result = await saveTodosGroupsDatasource(
        TodoGroupDto.fromEntity(todoGroup).copyWith(id: uuid.v1()),
      );
      return Right(result);
    } on SaveTodoGroupError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        SaveTodoGroupError(
          sourceClass: runtimeType.toString(),
          message: 'Não foi possível salvar o grupo de a fazeres',
        ),
      );
    }
  }
}
