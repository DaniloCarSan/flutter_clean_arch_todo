abstract class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class TaskCreateFailure extends Failure {
  TaskCreateFailure(String message) : super(message);
}

class TaskUpdateFailure extends Failure {
  TaskUpdateFailure(String message) : super(message);
}

