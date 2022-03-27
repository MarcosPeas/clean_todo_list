import 'package:todo_list/src/modules/todos_groups/data/dto/todo_group_dto.dart';

abstract class UpdateTodosGroupDatasource {
  Future<TodoGroupDto> call(TodoGroupDto todoGroupDto);
}
