
import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/presenter/pages/task/task_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $ChildRouteTaskPage = ChildRoute(Modular.initialRoute, child: (_, args) => const TaskPage());

class TaskPage extends StatefulWidget {
  
  const TaskPage({Key? key }) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends ModularState<TaskPage, TaskStore> {

  @override
  void initState() {
    super.initState();
    store.list(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body:Observer(
        builder: (_){

          if(store.tasks.isEmpty)
          {
            return const Center(
              child: Text('No tasks to list !'),
            );
          }

          return body();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> addTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget body(){
    return RefreshIndicator(
      onRefresh: ()=> store.list(context),
      child: ListView.separated(
        itemCount: store.tasks.length,
        itemBuilder: (context, index){

          TaskEntity taskEntity = store.tasks.elementAt(index);

          taskEntity.setIndex(index);

          return Container(
            color: taskEntity.isDone ? Colors.green[100] : null,
            child: ListTile(
              title: Text(taskEntity.description),
              leading: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: ()=>editTask(context, taskEntity),
              ),
              trailing: Checkbox(
                value: taskEntity.isDone, 
                onChanged: (v)=> store.setToggleDoneTask(context, taskEntity)
              ),
              onLongPress: ()=>store.remove(context,taskEntity),
            ),
          );

        },
        separatorBuilder: (_,__)=> const Divider(height: 0,),
      ), 
    );
  }

  void addTask(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add task'),
          content: TextField(
            maxLines: 5,
            minLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder()
            ),
            onChanged:store.setDescription,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                  onPressed: ()=>Modular.to.pop(),
                ),
                Observer(
                  builder: (_)=>TextButton(
                    child: const Text(
                      'Confirm',
                    ),
                    onPressed: store.isValid ? ()=>store.add(context) : null,
                  ),
                )
              ],
            )
          ],
        );
      }
    );
  }

  void editTask(BuildContext context,TaskEntity taskEntity) async {

    TextEditingController editingController = TextEditingController(text: taskEntity.description);

    store.setDescription(taskEntity.description);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add task'),
          content: TextField(
            controller: editingController,
            maxLines: 5,
            minLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder()
            ),
            onChanged:store.setDescription,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red
                    ),
                ),
                  onPressed: ()=>Modular.to.pop(),
                ),
                Observer(
                  builder: (_)=>TextButton(
                    child: const Text(
                      'Confirm',
                    ),
                    onPressed: store.isValid ? ()=>store.update(context, taskEntity) : null,
                  ),
                )
              ],
            )
          ],
        );
      }
    );
  }
}