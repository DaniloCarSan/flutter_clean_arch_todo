import 'package:flutter/material.dart';

final List<GlobalKey> showLoadingIndicatorkeys = [];

  GlobalKey showLoadingIndicator(BuildContext context,{String? message}){

  var key = GlobalKey();

  showLoadingIndicatorkeys.add(key);

  if(showLoadingIndicatorkeys.length==1)
  {
    showDialog<void>(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return WillPopScope(
            key: key,
            onWillPop: () async => false,
            child: AlertDialog(
              content: message != null ?  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ): const LinearProgressIndicator(),
            ),
          );
        },
    );
  }

  return key;
}


hiddenLoadingIndicator(BuildContext context){
  if(showLoadingIndicatorkeys.length==1)
  {
    Navigator.pop(context);
    showLoadingIndicatorkeys.remove(showLoadingIndicatorkeys.last);
  }
  else
  {
    showLoadingIndicatorkeys.remove(showLoadingIndicatorkeys.last);
  }
}
