import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/save_todos_groups_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';

class SaveTodosGroupDatasourceImpl implements SaveTodosGroupsDatasource {
  final FirebaseFirestore _firestore;

  SaveTodosGroupDatasourceImpl(this._firestore);

  @override
  Future<TodoGroupDto> call(TodoGroupDto todoGroupDto) async {
    try {
      await _firestore
          .collection('groups')
          .doc(todoGroupDto.id)
          .set(todoGroupDto.toMap());
      return todoGroupDto;
    } catch (e) {
      throw SaveTodoGroupError(
        message: 'Não foi possível salvar o grupo de a fazeres',
        sourceClass: runtimeType.toString(),
      );
    }
  }
}
