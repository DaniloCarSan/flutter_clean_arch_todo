// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on TaskStoreBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: 'TaskStoreBase.isValid'))
      .value;

  final _$loadingOrSuccessOrErrorAtom =
      Atom(name: 'TaskStoreBase.loadingOrSuccessOrError');

  @override
  IsLoadingOrSuccessOrErrorEnums get loadingOrSuccessOrError {
    _$loadingOrSuccessOrErrorAtom.reportRead();
    return super.loadingOrSuccessOrError;
  }

  @override
  set loadingOrSuccessOrError(IsLoadingOrSuccessOrErrorEnums value) {
    _$loadingOrSuccessOrErrorAtom
        .reportWrite(value, super.loadingOrSuccessOrError, () {
      super.loadingOrSuccessOrError = value;
    });
  }

  final _$tasksAtom = Atom(name: 'TaskStoreBase.tasks');

  @override
  ObservableList<TaskEntity> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TaskEntity> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$descriptionAtom = Atom(name: 'TaskStoreBase.description');

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$TaskStoreBaseActionController =
      ActionController(name: 'TaskStoreBase');

  @override
  void setIsLoading(IsLoadingOrSuccessOrErrorEnums code) {
    final _$actionInfo = _$TaskStoreBaseActionController.startAction(
        name: 'TaskStoreBase.setIsLoading');
    try {
      return super.setIsLoading(code);
    } finally {
      _$TaskStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingOrSuccessOrError: ${loadingOrSuccessOrError},
tasks: ${tasks},
description: ${description},
isValid: ${isValid}
    ''';
  }
}
