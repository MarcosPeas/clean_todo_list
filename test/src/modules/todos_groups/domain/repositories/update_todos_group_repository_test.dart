import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/update_todos_group_repository.dart';

class UpdateTodosGroupRepositoryMock extends Mock
    implements UpdateTodosGroupsRepository {}

void main() {
  UpdateTodosGroupRepositoryTest().runTests();
}

class UpdateTodosGroupRepositoryTest {
  late final UpdateTodosGroupsRepository _updateTodosGroupsRepository;

  UpdateTodosGroupRepositoryTest() {
    _updateTodosGroupsRepository = UpdateTodosGroupRepositoryMock();
  }

  void runTests() {
    group('UpdateTodosGroupRepositoryTest', () {
      _call();
    });
  }

  void _call() {
    setUpAll(() {
      registerFallbackValue(
        TodoGroup(
          id: '2',
          title: '',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );
    });
    test('Deve retornar um grupo de a fazeres com título alterado', () async {
      when(() => _updateTodosGroupsRepository(any())).thenAnswer(
        (_) async => Right(
          TodoGroup(
            id: '2',
            title: 'title2',
            subtitle: '',
            createdAt: DateTime.now(),
          ),
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
    test('Deve retornar um erro', () async {
      when(() => _updateTodosGroupsRepository(any())).thenAnswer(
        (_) async => Left(
          UpdateTodoGroupsError(
            message: 'Não foi possível atualizar o grupo de a fazeres',
            sourceClass: runtimeType.toString(),
          ),
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
  }
}
