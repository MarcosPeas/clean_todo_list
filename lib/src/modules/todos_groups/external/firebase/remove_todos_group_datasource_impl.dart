import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/remove_todos_group_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';

class RemoveTodosGroupDatasourceImpl implements RemoveTodosGroupDataSource {
  final FirebaseFirestore firestore;

  RemoveTodosGroupDatasourceImpl(this.firestore);

  @override
  Future<void> call(String groupId) async {
    try {
      await firestore.collection('groups').doc(groupId).delete();
    } catch (e) {
      throw RemoveTodoGroupsError(
        message: 'Não foi possível remover o gropo de a fazeres',
        sourceClass: runtimeType.toString(),
      );
    }
  }
}
