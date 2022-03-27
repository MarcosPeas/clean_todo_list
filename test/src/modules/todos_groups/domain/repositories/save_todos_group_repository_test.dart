import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/save_todo_group_repository.dart';

class SaveTodosGroupRepositoryMock extends Mock
    implements SaveTodoGroupRepository {}

void main() {
  SaveTodosGroupRepositoryTest()._call();
}

class SaveTodosGroupRepositoryTest {
  late final SaveTodoGroupRepository _repository;

  SaveTodosGroupRepositoryTest() {
    _repository = SaveTodosGroupRepositoryMock();
  }

  void runTests(){
    group('SaveTodosGroupRepositoryTest', (){
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
      when(() => _repository(any())).thenAnswer(
        (_) async => Right(
          TodoGroup(
            id: '1',
            title: '',
            subtitle: '',
            createdAt: DateTime.now(),
          ),
        ),
      );

      final result = await _repository(
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
      when(() => _repository(any())).thenAnswer(
        (_) async => Left(
          SaveTodoGroupError(
            message: 'Não foi possível salvar o grupo de a fazeres',
            sourceClass: runtimeType.toString(),
          ),
        ),
      );

      final result = await _repository(
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
      expect((fold as SaveTodoGroupError).message, 'Não foi possível salvar o grupo de a fazeres');      
    });
  }
}
