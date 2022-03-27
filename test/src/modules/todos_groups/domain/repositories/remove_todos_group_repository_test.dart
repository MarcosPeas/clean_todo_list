import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/remove_todo_groups_repository.dart';

class RemoveTodosGroupRepositoryMock extends Mock
    implements RemoveTodoGroupsRepository {}

void main() {
  RemoveTodosGroupRepositoryTest()._call();
}

class RemoveTodosGroupRepositoryTest {
  late final RemoveTodoGroupsRepository _repository;

  RemoveTodosGroupRepositoryTest() {
    _repository = RemoveTodosGroupRepositoryMock();
  }

  void runTests(){
    group('RemoveTodosGroupRepositoryTest', (){
      _call();
    });
  }

  void _call() {
    test('Deve retornar nulo', () async {
      when(() => _repository(any())).thenAnswer((_) async => const Right(null));

      final result = await _repository('1');

      expect(result.isRight(), isTrue);
    });

    test('Deve retornar um erro', () async {
      when(() => _repository(any())).thenAnswer(
        (_) async => Left(
          RemoveTodoGroupsError(
            message: 'Não foi possível remover o grupo de a fazeres',
            sourceClass: runtimeType.toString(),
          ),
        ),
      );

      final result = await _repository('1');
      dynamic fold;
      result.fold((l) => fold = l, id);

      expect(result.isLeft(), isTrue);
      expect(fold, isA<RemoveTodoGroupsError>());
      expect((fold as RemoveTodoGroupsError).message, 'Não foi possível remover o grupo de a fazeres');
    });
  }
}
