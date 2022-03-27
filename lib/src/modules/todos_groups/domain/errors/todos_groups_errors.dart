class TodosGroupError implements Exception {
  final String message;
  final String sourceClass;

  TodosGroupError({
    required this.message,
    required this.sourceClass,
  });
}

class SaveTodoGroupError extends TodosGroupError {
  SaveTodoGroupError({
    required String message,
    required String sourceClass,
  }) : super(message: message, sourceClass: sourceClass);
}

class LoadTodosGroupsError extends TodosGroupError {
  LoadTodosGroupsError({
    required String message,
    required String sourceClass,
  }) : super(message: message, sourceClass: sourceClass);
}

class UpdateTodoGroupsError extends TodosGroupError {
  UpdateTodoGroupsError({required String message, required String sourceClass})
      : super(message: message, sourceClass: sourceClass);
}

class RemoveTodoGroupsError extends TodosGroupError {
  RemoveTodoGroupsError({required String message, required String sourceClass})
      : super(message: message, sourceClass: sourceClass);
}
