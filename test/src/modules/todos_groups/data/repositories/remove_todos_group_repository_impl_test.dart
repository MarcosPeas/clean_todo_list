import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/remove_todos_group_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/remove_todos_group_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/remove_todo_groups_repository.dart';

class RemoveTodosGroupDatasourceImpl extends Mock
    implements RemoveTodosGroupDataSource {}

void main() {
  RemoveTodosGroupRepositoryImplTest()._call();
}

class RemoveTodosGroupRepositoryImplTest {
  late final RemoveTodosGroupDataSource _removeTodosGroupDataSource;
  late final RemoveTodoGroupsRepository _removeTodoGroupsRepository;

  RemoveTodosGroupRepositoryImplTest() {
    _removeTodosGroupDataSource = RemoveTodosGroupDatasourceImpl();
    _removeTodoGroupsRepository = RemoveTodosGroupRepositoryImpl(
      _removeTodosGroupDataSource,
    );
  }

  void runTests() {
    group('RemoveTodosGroupRepositoryImplTest', () {
      _call();
    });
  }

  void _call() {
    test('Deve retornar Right<null>', () async {
      when(() => _removeTodosGroupDataSource(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await _removeTodoGroupsRepository('1');

      expect(result.isRight(), isTrue);
    });

    test('Deve retornar um RemoveTodoGroupsError', () async {
      when(() => _removeTodosGroupDataSource(any())).thenThrow(
        RemoveTodoGroupsError(
          message: 'Não foi possível remover o grupo de a fazeres',
          sourceClass: runtimeType.toString(),
        ),
      );

      final result = await _removeTodoGroupsRepository('1');
      dynamic fold;
      result.fold((l) => fold = l, id);

      expect(result.isLeft(), isTrue);
      expect(fold, isA<RemoveTodoGroupsError>());
      expect((fold as RemoveTodoGroupsError).message,
          'Não foi possível remover o grupo de a fazeres');
    });

    test('Deve retornar um RemoveTodoGroupsError a partir de um exception',
        () async {
      when(() => _removeTodosGroupDataSource(any())).thenThrow(Exception());

      final result = await _removeTodoGroupsRepository('1');
      dynamic fold;
      result.fold((l) => fold = l, id);

      expect(result.isLeft(), isTrue);
      expect(fold, isA<RemoveTodoGroupsError>());
      expect((fold as RemoveTodoGroupsError).message,
          'Não foi possível remover o grupo de a fazeres');
    });
  }
}
