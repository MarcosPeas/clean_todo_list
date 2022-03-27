import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/load_todos_groups_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/remove_todos_group_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/save_todos_group_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/update_todos_group_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/load_todos_groups_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/remove_todo_groups_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/save_todo_group_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/update_todos_group_use_case.dart';
import 'package:todo_list/src/modules/todos_groups/external/firebase/load_todos_groups_datasource_impl.dart';
import 'package:todo_list/src/modules/todos_groups/external/firebase/remove_todos_group_datasource_impl.dart';
import 'package:todo_list/src/modules/todos_groups/external/firebase/save_todos_group_datasource_impl.dart';
import 'package:todo_list/src/modules/todos_groups/external/firebase/update_todos_group_datasource_impl.dart';
import 'package:todo_list/src/modules/todos_groups/presentation/controller/todo_groups_controller.dart';
import 'package:todo_list/src/modules/todos_groups/presentation/page/todo_groups_page.dart';
import 'package:uuid/uuid.dart';

class TodosGroupsModule extends Module {
  @override
  List<Bind> get binds {
    return [
      Bind(
        (i) => TodoGroupsController(
          saveTodoGroupUseCase: SaveTodoGroupUseCaseImpl(
            SaveTodosGroupRepositoryImpl(
              uuid: const Uuid(),
              saveTodosGroupsDatasource: SaveTodosGroupDatasourceImpl(
                FirebaseFirestore.instance,
              ),
            ),
          ),
          updateTodosGroupUseCase: UpdateTodosGroupUseCaseImpl(
            UpdateTodosGroupRepositoryImpl(
              UpdateTodosGroupDatasourceImpl(
                FirebaseFirestore.instance,
              ),
            ),
          ),
          loadTodosGroupsUseCase: LoadTodosGroupsUseCaseImpl(
            LoadTodosGroupsRepositoryImpl(
              LoadTodosGroupsDatasourceImpl(
                FirebaseFirestore.instance,
              ),
            ),
          ),
          removeTodoGroupsUseCase: RemoveTodoGroupUseCaseImpl(
            RemoveTodosGroupRepositoryImpl(
              RemoveTodosGroupDatasourceImpl(
                FirebaseFirestore.instance,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute('/', child: (_, __) => const TodoGroupsPage()),
    ];
  }
}
