import 'package:rx_notifier/rx_notifier.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/load_todos_groups_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/remove_todo_groups_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/save_todo_group_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/update_todos_group_use_case.dart';

class TodoGroupsController {
  final SaveTodoGroupUseCase saveTodoGroupUseCase;
  final UpdateTodosGroupUseCase updateTodosGroupUseCase;
  final LoadTodosGroupsUseCase loadTodosGroupsUseCase;
  final RemoveTodoGroupsUseCase removeTodoGroupsUseCase;

  final groups = RxList<TodoGroup>();

  TodoGroupsController({
    required this.saveTodoGroupUseCase,
    required this.updateTodosGroupUseCase,
    required this.loadTodosGroupsUseCase,
    required this.removeTodoGroupsUseCase,
  });

  void loadTodosGroups() async {
    final either = await loadTodosGroupsUseCase(0, 10);
    either.fold((l) {
      print(l.message);
      print(l.sourceClass);
      throw l;
    }, (r) {
      groups.addAll(r);
    });
  }

  void addTodoGroup({required String title, required String subtitle}) async {
    TodoGroup todoGroup = TodoGroup(
      id: '',
      title: title,
      subtitle: subtitle,
      createdAt: DateTime.now(),
    );
    final either = await saveTodoGroupUseCase(todoGroup);
    either.fold((l) {
      print(l.message);
      print(l.sourceClass);
      throw l;
    }, (r) {
      groups.add(r);
    });
  }

  void updateTodosGroup({
    required int indexGroup,
    required String title,
    required String subtitle,
  }) async {
    final currentGroup = groups[indexGroup];
    final updatedGroup = TodoGroup(
      id: currentGroup.id,
      title: title,
      subtitle: subtitle,
      createdAt: currentGroup.createdAt,
    );
    final either = await updateTodosGroupUseCase(updatedGroup);
    either.fold((l) {
      print(l.message);
      print(l.sourceClass);
    }, (r) {
      groups[indexGroup] = updatedGroup;
    });
  }

  void removeTodoGroup(TodoGroup todoGroup) async {
    final either = await removeTodoGroupsUseCase(todoGroup.id!);
    either.fold((l) {
      print(l.message);
      print(l.sourceClass);
      throw l;
    }, (r) {
      groups.removeWhere((group) => group.id == todoGroup.id);
    });
  }
}
