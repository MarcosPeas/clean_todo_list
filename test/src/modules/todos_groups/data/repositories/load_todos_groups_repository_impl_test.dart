import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/data/datasource/load_todos_groups_datasource.dart';
import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';
import 'package:todo_list/src/modules/todos_groups/data/repositories/load_todos_groups_repository_impl.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/load_todos_groups_repository.dart';

class LoadTodosGroupsDataSourceMock extends Mock
    implements LoadTodosGroupsDataSource {}

void main() {
  LoadTodosGroupsRepositoryImplTest()._call();
}

class LoadTodosGroupsRepositoryImplTest {
  late final LoadTodosGroupsDataSource _loadTodosGroupsDataSource;
  late final LoadTodosGroupsRepository _loadTodosGroupsRepository;

  LoadTodosGroupsRepositoryImplTest() {
    _loadTodosGroupsDataSource = LoadTodosGroupsDataSourceMock();
    _loadTodosGroupsRepository = LoadTodosGroupsRepositoryImpl(
      _loadTodosGroupsDataSource,
    );
  }

  void runTests() {
    group('LoadTodosGroupsRepositoryImplTest', () {
      _call();
    });
  }

  void _call() {
    test('Espera-se que retorne uma list de grupos de a fazeres', () async {
      when(() => _loadTodosGroupsDataSource.call(any(), any())).thenAnswer(
        (_) async {
          return [
            TodoGroupDto(
              id: '1',
              title: 'learn',
              subtitle: 'learn',
              createdAt: DateTime.now(),
            ),
          ];
        },
      );
      final result = await _loadTodosGroupsRepository(10, 0);
      final listGroups = result.getOrElse(() => throw UnimplementedError());
      expect(result.isRight(), isTrue);
      expect(listGroups, isNotEmpty);
    });
    test('Espera-se que retorne um LoadTodosGroupsError', () async {
      when(() => _loadTodosGroupsRepository.call(any(), any())).thenThrow(
        LoadTodosGroupsError(
          message: 'Não foi possível carregar os grupos de a fazeres',
          sourceClass: runtimeType.toString(),
        ),
      );
      final result = await _loadTodosGroupsRepository(10, 0);
      final fold = result.fold(id, id);
      expect(result.isLeft(), isTrue);
      expect(fold, isA<LoadTodosGroupsError>());
    });
    test(
        'Espera-se que retorne um LoadTodosGroupsError a partir de uma exception',
        () async {
      when(() => _loadTodosGroupsRepository.call(any(), any())).thenThrow(
        Exception(),
      );
      final result = await _loadTodosGroupsRepository(10, 0);
      final fold = result.fold(id, id);
      expect(result.isLeft(), isTrue);
      expect(fold, isA<LoadTodosGroupsError>());
      expect(
        (fold as LoadTodosGroupsError).message,
        'Não foi possível carregar os grupos de a fazeres',
      );
    });
  }
}
