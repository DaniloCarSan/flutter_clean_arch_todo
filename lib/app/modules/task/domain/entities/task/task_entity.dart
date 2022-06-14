import 'package:cleanarch/app/modules/task/domain/entities/task/task_entity_fileds.dart';

class TaskEntity {
  
  int? index;
  int? code;
  String description;
  String done;

  TaskEntity({
    this.index,
    this.code, 
    required this.description, 
    required this.done
  });

  TaskEntity.fromJson(Map<String,dynamic> map):
    code=map[TaskEntityFields.code],
    description=map[TaskEntityFields.description],
    done=map[TaskEntityFields.done]
  ;

  Map<String,dynamic>toJson()=>{
    TaskEntityFields.code: code,
    TaskEntityFields.description: description,
    TaskEntityFields.done: done
  };

  Map<String,dynamic>toJsonAddTask()=>{
    TaskEntityFields.description: description,
    TaskEntityFields.done: done
  };

  Map<String,dynamic>toJsonEditTask()=>{
    TaskEntityFields.description: description,
    TaskEntityFields.done: done
  };

  bool get isDone => TaskEntityFields.doneYes == done;

  String get isDoneLabel => TaskEntityFields.doneLabes[done]!;

  void setIndex(int index){
    this.index = index;
  }

  void setCode(int code) {
    this.code = code;
  }

  void toggleDonetask() {
    done = isDone ? TaskEntityFields.doneNo : TaskEntityFields.doneYes;
  }

  void setDescription(String description){
    this.description = description;
  }

}