import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/update_todos_group_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';

class UpdateTodosGroupDatasourceImpl implements UpdateTodosGroupDatasource {
  final FirebaseFirestore firestore;

  UpdateTodosGroupDatasourceImpl(this.firestore);

  @override
  Future<TodoGroupDto> call(TodoGroupDto todoGroupDto) async {
    try {
      await firestore
          .collection('groups')
          .doc(todoGroupDto.id)
          .update(todoGroupDto.toMap());
      return todoGroupDto;
    } catch (e) {
      throw UpdateTodoGroupsError(
        message: 'Não foi possível atualizar o grupo de a fazeres',
        sourceClass: runtimeType.toString(),
      );
    }
  }
}
