import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:todo_list/src/modules/todos_groups/domain/entities/todo_group.dart';
import 'package:todo_list/src/modules/todos_groups/presentation/controller/todo_groups_controller.dart';

class TodoGroupsPage extends StatefulWidget {
  const TodoGroupsPage({Key? key}) : super(key: key);

  @override
  State<TodoGroupsPage> createState() => _TodoGroupsPageState();
}

class _TodoGroupsPageState
    extends ModularState<TodoGroupsPage, TodoGroupsController> {
  final _titleTextController = TextEditingController();
  final _subtitleTextController = TextEditingController();

  @override
  void initState() {
    controller.loadTodosGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupo de tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodosGroupDialog();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: _buildTodoGroupsList(),
    );
  }

  Widget _buildTodoGroupsList() {
    return RxBuilder(
      builder: (_) {
        return ListView.builder(
          itemCount: controller.groups.length,
          itemBuilder: (_, index) {
            final todoGroup = controller.groups[index];
            return /*Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: ClipOval(
                      child: Container(
                        color: Colors.blueGrey.withAlpha(100),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(todoGroup.title),
                      Text(todoGroup.subtitle),
                    ],
                  ),
                  Column(
                    children: [
                      Text(todoGroup.createdAt.toString()),
                    ],
                  ),
                ],
              ),*/
               ListTile(
                title: Text('${todoGroup.title}: ${todoGroup.createdAt.toString()}'),
                subtitle: Text(todoGroup.subtitle),
                trailing: _showPopupMenu(indexGroup: index, todoGroup: todoGroup),
            );
          },
        );
      },
    );
  }

  Widget _showPopupMenu({required indexGroup, required TodoGroup todoGroup}) {
    return PopupMenuButton(
      tooltip: 'Opções',
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(width: 16),
              Text('Atualizar grupo de tarefas'),
            ],
          ),
          onTap: () {
            Future<void>.delayed(const Duration(), () {
              _showUpdateTodosGroupDialog(
                indexGroup: indexGroup,
                todoGroup: todoGroup,
              );
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 16),
              Text('Remover grupo de tarefas'),
            ],
          ),
          onTap: () {
            Future<void>.delayed(const Duration(), () {
              _showDeleteTodosGroupDialog(todoGroup);
            });
          },
        ),
      ],
    );
  }

  Future<void> _showAddTodosGroupDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Criar grupo de tarefas'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: _titleTextController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _subtitleTextController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    label: Text('Descrição'),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                Navigator.of(context).pop();
                controller.addTodoGroup(
                  title: _titleTextController.text,
                  subtitle: _subtitleTextController.text,
                );
                _titleTextController.clear();
                _subtitleTextController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showUpdateTodosGroupDialog({
    required int indexGroup,
    required TodoGroup todoGroup,
  }) async {
    _titleTextController.text = todoGroup.title;
    _subtitleTextController.text = todoGroup.subtitle;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar grupo de tarefas'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: _titleTextController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _subtitleTextController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    isDense: true,
                    label: Text('Descrição'),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                Navigator.of(context).pop();
                controller.updateTodosGroup(
                  indexGroup: indexGroup,
                  title: _titleTextController.text,
                  subtitle: _subtitleTextController.text,
                );
                _titleTextController.clear();
                _subtitleTextController.clear();
              },
            ),
          ],
        );
      },
    );

    _titleTextController.clear();
    _subtitleTextController.clear();
  }

  Future<void> _showDeleteTodosGroupDialog(TodoGroup todoGroup) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Deseja remover: ${todoGroup.title}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Remover'),
              onPressed: () {
                Navigator.of(context).pop();
                controller.removeTodoGroup(todoGroup);
              },
            ),
          ],
        );
      },
    );
  }
}
