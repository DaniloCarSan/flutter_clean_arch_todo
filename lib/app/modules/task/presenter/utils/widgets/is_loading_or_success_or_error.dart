
import 'package:flutter/material.dart';

enum IsLoadingOrSuccessOrErrorEnums{loading,success,error}

class IsLoadingOrSuccessOrError extends StatelessWidget {

  final IsLoadingOrSuccessOrErrorEnums isLoadingOrSuccessOrError;
  final Widget?  loading;
  final Widget success;
  final Widget error;

  const IsLoadingOrSuccessOrError({Key? key, required this.isLoadingOrSuccessOrError, this.loading, required this.success, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    switch (isLoadingOrSuccessOrError)
    {
      case IsLoadingOrSuccessOrErrorEnums.loading:
        return loading ?? loadingWidget();
      case IsLoadingOrSuccessOrErrorEnums.success:
        return success;
      case IsLoadingOrSuccessOrErrorEnums.error:
      default:
        return error;
    }
  }

  Widget loadingWidget()=> const Center(
    child: CircularProgressIndicator(),
  );

}