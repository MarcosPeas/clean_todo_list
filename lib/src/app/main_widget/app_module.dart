import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/modules/todos_groups/todos_groups_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds {
    return [];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ModuleRoute('/', module: TodosGroupsModule()),
    ];
  }
}
