import 'package:flutter_test/flutter_test.dart';

import 'src/modules/todos_groups/data/repositories/load_todos_groups_repository_impl_test.dart';
import 'src/modules/todos_groups/data/repositories/remove_todos_group_repository_impl_test.dart';
import 'src/modules/todos_groups/data/repositories/save_todos_group_repository_impl_test.dart';
import 'src/modules/todos_groups/data/repositories/update_todos_group_repository_impl_test.dart';
import 'src/modules/todos_groups/domain/repositories/load_todos_groups_repository_test.dart';
import 'src/modules/todos_groups/domain/repositories/remove_todos_group_repository_test.dart';
import 'src/modules/todos_groups/domain/repositories/save_todos_group_repository_test.dart';
import 'src/modules/todos_groups/domain/repositories/update_todos_group_repository_test.dart';
import 'src/modules/todos_groups/domain/use_cases/load_todos_groups_use_case_test.dart';
import 'src/modules/todos_groups/domain/use_cases/remove_todos_group_use_case_test.dart';
import 'src/modules/todos_groups/domain/use_cases/save_todos_group_use_case_test.dart';
import 'src/modules/todos_groups/domain/use_cases/update_todos_group_use_case_test.dart';

void main() {
  group('todos_groups', () {
    group('repositories', () {
      LoadTodosGroupsRepositoryTest().runTests();
      RemoveTodosGroupRepositoryTest().runTests();
      SaveTodosGroupRepositoryTest().runTests();
      UpdateTodosGroupRepositoryTest().runTests();
    });
    group('use_cases', () {
      LoadTodosGroupsUseCaseTest().runTests();
      RemoveTodosGroupUseCaseTest().runTests();
      SaveTodosGroupUseCaseTest().runTests();
      UpdateTodosGroupUseCaseTest().runTests();
    });
    group('repositories implementations', () {
      SaveTodosGroupRepositoryImplTest().runTests();
      RemoveTodosGroupRepositoryImplTest().runTests();
      LoadTodosGroupsRepositoryImplTest().runTests();
      UpdateTodosGroupRepositoryImplTest().runTests();
    });
  });
}
