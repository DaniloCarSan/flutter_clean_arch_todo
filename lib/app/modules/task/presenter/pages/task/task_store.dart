import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity.dart';
import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity_fileds.dart';
import 'package:cleanarch/app/modules/task/domain/errors/erros.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/add_task_use_case.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/edit_task_use_case.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/list_task_use_case.dart';
import 'package:cleanarch/app/modules/task/domain/usecases/remove_task_use_case.dart';
import 'package:cleanarch/app/modules/task/presenter/utils/widgets/is_loading_or_success_or_error.dart';
import 'package:cleanarch/app/modules/task/presenter/utils/widgets/show_loadind.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'task_store.g.dart';

final $BindTaskStore = Bind.lazySingleton((i) => TaskStore(i(),i(),i(),i()));

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {

  final AddTaskUseCase addTaskUseCase;
  final ListTaskUseCase listTaskUseCase;
  final EditTaskUseCase editTaskUseCase;
  final RemoveTaskUseCase removeTaskUseCase;

  TaskStoreBase(this.addTaskUseCase, this.listTaskUseCase, this.editTaskUseCase, this.removeTaskUseCase);

  @observable
  IsLoadingOrSuccessOrErrorEnums loadingOrSuccessOrError = IsLoadingOrSuccessOrErrorEnums.loading;

  @action
  void setIsLoading(IsLoadingOrSuccessOrErrorEnums code) {
    loadingOrSuccessOrError = code;
  }

  @observable
  ObservableList<TaskEntity> tasks = ObservableList<TaskEntity>().asObservable();

  @computed
  bool get isValid => description != null && description != '';

  @observable
  String? description;

  void setDescription(String? description){
    this.description = description;
  }

  void setToggleDoneTask(BuildContext context,TaskEntity taskEntity) async {

    taskEntity.toggleDonetask();

    dartz.Either<TaskUpdateFailure,TaskEntity> result = await editTaskUseCase(taskEntity);

    result.fold(
      (failure)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message),backgroundColor: Colors.red,)),
      (taskEntity){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text( taskEntity.isDone ?'Task done with success !': 'Task undo with success !'),backgroundColor: Colors.green,));
        list(context);
      }
    );

  }

  Future<void> list(BuildContext context) async {

    tasks.clear();

    setIsLoading(IsLoadingOrSuccessOrErrorEnums.loading);

    List<TaskEntity> taskEntities = await listTaskUseCase();

    setIsLoading(IsLoadingOrSuccessOrErrorEnums.success);

    tasks.addAll(taskEntities);

  }

  Future<void> add(BuildContext context) async {

    showLoadingIndicator(context);

    dartz.Either<TaskCreateFailure,TaskEntity> result = await addTaskUseCase(
      TaskEntity(
        description: description!,
        done: TaskEntityFields.doneNo
      )
    );

    hiddenLoadingIndicator(context);

    result.fold(
      (failure)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message),backgroundColor: Colors.red,)), 
      (taskEntity) {
        Modular.to.pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task create with success !'),backgroundColor: Colors.green,));
        list(context);
      }
    );

  }

  Future<void> update(BuildContext context, TaskEntity taskEntity) async {
    
    showLoadingIndicator(context);

    taskEntity.setDescription(description!);

    dartz.Either<TaskUpdateFailure,TaskEntity> result = await editTaskUseCase(
      taskEntity
    );

    hiddenLoadingIndicator(context);

    result.fold(
      (failure)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message),backgroundColor: Colors.red,)), 
      (taskEntity) {
        Modular.to.pop();
        list(context);
      }
    );
    
  }

  Future<void> remove(BuildContext context, TaskEntity taskEntity) async {

    showLoadingIndicator(context);

    dartz.Either<TaskUpdateFailure,TaskEntity> result = await removeTaskUseCase(
      taskEntity
    );

    hiddenLoadingIndicator(context);

    result.fold(
      (failure)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message),backgroundColor: Colors.red,)),
      (taskEntity){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task removed with success !'),backgroundColor: Colors.green,));
        list(context);
      }
    );

  }

}