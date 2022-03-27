import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/save_todo_group_repository.dart';
import 'package:todo_list/src/modules/todos_groups/domain/use_cases/save_todo_group_use_case.dart';

class SaveTodosGroupRepositoryMock extends Mock
    implements SaveTodoGroupRepository {}

void main() {
  SaveTodosGroupUseCaseTest()._call();
}

class SaveTodosGroupUseCaseTest {
  late final SaveTodoGroupRepository _saveTodoGroupRepository;
  late final SaveTodoGroupUseCase _saveTodoGroupUseCase;

  SaveTodosGroupUseCaseTest() {
    _saveTodoGroupRepository = SaveTodosGroupRepositoryMock();
    _saveTodoGroupUseCase = SaveTodoGroupUseCaseImpl(
      _saveTodoGroupRepository,
    );
  }

  void runTests() {
    group('SaveTodosGroupUseCaseTest', () {
      _call();
    });
  }

  void _call() {
    setUpAll(() {
      registerFallbackValue(
        TodoGroup(
          id: '1',
          title: '',
          subtitle: '',
          createdAt: DateTime.now(),
        ),
      );
    });
    test('Deve retornar um grupo de a fazeres com id setado', () async {
      when(() => _saveTodoGroupRepository(any())).thenAnswer(
        (_) async => Right(
          TodoGroup(
            id: '1',
            title: '',
            subtitle: '',
            createdAt: DateTime.now(),
          ),
        ),
      );

      final result = await _saveTodoGroupUseCase(
        TodoGroup(
          id: '',
          title: 'title',
          subtitle: 'subtitle',
          createdAt: DateTime.now(),
        ),
      );

      final fold = result.fold(id, id);
      final group = result.getOrElse(() => throw Exception());

      expect(result.isRight(), isTrue);
      expect(fold, isA<TodoGroup>());
      expect(group.id, '1');
    });
    test('Deve retornar um erro', () async {
      when(() => _saveTodoGroupRepository(any())).thenAnswer(
        (_) async => Left(
          SaveTodoGroupError(
            message: 'Não foi possível salvar o grupo de a fazeres',
            sourceClass: runtimeType.toString(),
          ),
        ),
      );

      final result = await _saveTodoGroupUseCase(
        TodoGroup(
          id: '',
          title: 'title',
          subtitle: 'subtitle',
          createdAt: DateTime.now(),
        ),
      );

      final fold = result.fold(id, id);

      expect(result.isLeft(), isTrue);
      expect(fold, isA<SaveTodoGroupError>());
      expect((fold as SaveTodoGroupError).message,
          'Não foi possível salvar o grupo de a fazeres');
    });
  }
}
