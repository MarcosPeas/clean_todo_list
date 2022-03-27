import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/domain/errors/todos_groups_errors.dart';
import 'package:todo_list/src/modules/todos_groups/domain/repository/load_todos_groups_repository.dart';

class LoadTodosGroupsRepositoryMock extends Mock
    implements LoadTodosGroupsRepository {}

void main() {
  LoadTodosGroupsRepositoryTest()._call();
}

class LoadTodosGroupsRepositoryTest {
  late final LoadTodosGroupsRepository _loadTodosGroupsRepository;

  LoadTodosGroupsRepositoryTest() {
    _loadTodosGroupsRepository = LoadTodosGroupsRepositoryMock();
  }

  void runTests(){
    group('LoadTodosGroupsRepositoryTest', (){
      _call();
    });
  }

  void _call() {
    test('Espera-se que retorne uma list de grupos de a fazeres', () async {
      when(() => _loadTodosGroupsRepository.call(any(), any()))
          .thenAnswer((realInvocation) async => Right([
                TodoGroup(
                  id: '1',
                  title: 'learn',
                  subtitle: 'learn',
                  createdAt: DateTime.now(),
                ),
              ]));
      final result = await _loadTodosGroupsRepository(10, 0);
      final listGroups = result.getOrElse(() => throw UnimplementedError());
      expect(result.isRight(), isTrue);
      expect(listGroups, isNotEmpty);
    });
    test('Espera-se que retorne um erro', () async {
      when(() => _loadTodosGroupsRepository.call(any(), any()))
          .thenAnswer((realInvocation) async => Left(
                LoadTodosGroupsError(
                  message: 'Error ao buscar grupos',
                  sourceClass: runtimeType.toString(),
                ),
              ));
      final result = await _loadTodosGroupsRepository(10, 0);
      final fold = result.fold(id, id);
      expect(result.isLeft(), isTrue);
      expect(fold, isA<LoadTodosGroupsError>());
    });
  }
}
