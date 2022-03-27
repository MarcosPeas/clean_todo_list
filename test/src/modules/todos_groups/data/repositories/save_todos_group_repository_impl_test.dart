import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/save_todos_groups_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/save_todos_group_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/save_todo_group_repository.dart';
import 'package:uuid/uuid.dart';

class SaveTodosGroupsDatasourceMock extends Mock
    implements SaveTodosGroupsDatasource {}

void main() {
  SaveTodosGroupRepositoryImplTest()._call();
}

class SaveTodosGroupRepositoryImplTest {
  late final SaveTodosGroupsDatasource _saveTodosGroupsDatasource;
  late final SaveTodoGroupRepository _saveTodosGroupRepositoryImpl;

  SaveTodosGroupRepositoryImplTest() {
    _saveTodosGroupsDatasource = SaveTodosGroupsDatasourceMock();
    _saveTodosGroupRepositoryImpl = SaveTodosGroupRepositoryImpl(
      uuid: const Uuid(),
      saveTodosGroupsDatasource: _saveTodosGroupsDatasource,
    );
  }

  void runTests() {
    group('SaveTodosGroupRepositoryImplTest', () {
      _call();
    });
  }

  void _call() {
    setUpAll(() {
      registerFallbackValue(
        TodoGroupDto(
          id: '1',
          title: '',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );
    });
    test('Deve retornar uma todoGroupDto', () async {
      when(() => _saveTodosGroupsDatasource(any())).thenAnswer(
        (_) async {
          return TodoGroupDto(
            id: '1',
            title: '',
            subtitle: '',
            createdAt: DateTime.now(),
          );
        },
      );

      final result = await _saveTodosGroupRepositoryImpl(
        TodoGroupDto(
          id: '1',
          title: '',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );

      final todoGroup = result.getOrElse(() => throw Exception());

      expect(result, isA<Right<dynamic, TodoGroup>>());
      expect(todoGroup.id, '1');
    });

    test('Deve retornar uma SaveTodosGroupError', () async {
      when(() => _saveTodosGroupsDatasource(any())).thenAnswer((_) {
        throw SaveTodoGroupError(
          message: 'Não foi possivel salvar o grupo de a fazeres',
          sourceClass: runtimeType.toString(),
        );
      });

      final result = await _saveTodosGroupRepositoryImpl(
        TodoGroupDto(
          id: '1',
          title: '',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );
      expect(result.isLeft(), isTrue);
      expect(result.fold(id, id), isA<SaveTodoGroupError>());
      expect((result.fold(id, id) as SaveTodoGroupError).message,
          'Não foi possivel salvar o grupo de a fazeres');
    });

    test('Deve retornar uma SaveTodosGroupError', () async {
      when(() => _saveTodosGroupsDatasource(any())).thenThrow(Exception());

      final result = await _saveTodosGroupRepositoryImpl(
        TodoGroupDto(
          id: '1',
          title: '',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );
      expect(result.isLeft(), isTrue);
      expect(result.fold(id, id), isA<SaveTodoGroupError>());
      expect((result.fold(id, id) as SaveTodoGroupError).message,
          'Não foi possível salvar o grupo de a fazeres');
    });
  }
}
