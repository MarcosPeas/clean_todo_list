import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/load_todos_groups_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';

class LoadTodosGroupsDatasourceImpl implements LoadTodosGroupsDataSource {
  final FirebaseFirestore firestore;

  LoadTodosGroupsDatasourceImpl(this.firestore);

  @override
  Future<List<TodoGroupDto>> call(int count, int offset) async {
    try {
      final result = await firestore.collection('groups').get();
      return result.docChanges.map((e) {
        final data = e.doc.data()!;
        data['created_at'] = (e.doc['created_at'] as Timestamp).toDate();
        return TodoGroupDto.fromMap(data);
      }).toList();
    } catch (e) {
      throw LoadTodosGroupsError(
        message: 'Não foi possível carregar os grupos de a fazeres',
        sourceClass: runtimeType.toString(),
      );
    }
  }
}
