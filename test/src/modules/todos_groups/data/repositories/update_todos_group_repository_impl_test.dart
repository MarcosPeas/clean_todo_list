import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/update_todos_group_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/update_todos_group_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/update_todos_group_repository.dart';

class UpdateTodosGroupDataSourceMock extends Mock
    implements UpdateTodosGroupDatasource {}

void main() {
  UpdateTodosGroupRepositoryImplTest()._call();
}

class UpdateTodosGroupRepositoryImplTest {
  late final UpdateTodosGroupDatasource _updateTodosGroupDatasource;
  late final UpdateTodosGroupsRepository _updateTodosGroupsRepository;

  UpdateTodosGroupRepositoryImplTest() {
    _updateTodosGroupDatasource = UpdateTodosGroupDataSourceMock();
    _updateTodosGroupsRepository = UpdateTodosGroupRepositoryImpl(
      _updateTodosGroupDatasource,
    );
  }

  void runTests() {
    group('UpdateTodosGroupRepositoryImplTest', () {
      _call();
    });
  }

  void _call() {
    setUpAll(() {
      registerFallbackValue(
        TodoGroupDto(
          id: '2',
          title: 'title2',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );
    });
    test('Deve retornar um grupo de a fazeres com título alterado', () async {
      when(() => _updateTodosGroupDatasource(any())).thenAnswer(
        (_) async => TodoGroupDto(
          id: '2',
          title: 'title2',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );

      final result = await _updateTodosGroupsRepository(
        TodoGroup(
          id: '2',
          title: 'title',
          subtitle: 'subtitle',
          createdAt: DateTime.now(),
        ),
      );

      final fold = result.fold(id, id);
      final group = result.getOrElse(() => throw Exception());

      expect(result.isRight(), isTrue);
      expect(fold, isA<TodoGroup>());
      expect(group.title, 'title2');
    });
    test('Deve retornar um UpdateTodoGroupsError', () async {
      when(() => _updateTodosGroupDatasource(any())).thenThrow(
        UpdateTodoGroupsError(
          message: 'Não foi possível atualizar o grupo de a fazeres',
          sourceClass: runtimeType.toString(),
        ),
      );

      final result = await _updateTodosGroupsRepository(
        TodoGroup(
          id: '',
          title: 'title',
          subtitle: 'subtitle',
          createdAt: DateTime.now(),
        ),
      );

      final fold = result.fold(id, id);

      expect(result.isLeft(), isTrue);
      expect(fold, isA<UpdateTodoGroupsError>());
      expect((fold as UpdateTodoGroupsError).message,
          'Não foi possível atualizar o grupo de a fazeres');
    });

    test('Deve retornar um UpdateTodoGroupsError a partir de uma Exception',
        () async {
      when(() => _updateTodosGroupDatasource(any())).thenThrow(Exception());

      final result = await _updateTodosGroupsRepository(
        TodoGroup(
          id: '',
          title: 'title',
          subtitle: 'subtitle',
          createdAt: DateTime.now(),
        ),
      );

      final fold = result.fold(id, id);

      expect(result.isLeft(), isTrue);
      expect(fold, isA<UpdateTodoGroupsError>());
      expect((fold as UpdateTodoGroupsError).message,
          'Não foi possível atualizar o grupo de a fazeres');
    });
  }
}
