import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerDialogs {
  static void showErrorDialog(BuildContext context, String message) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text("Atenção!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Atenção!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Center(
            child: Platform.isIOS ? _iosLoading() : _androidLoading(context),
          ),
        ),
      ),
    );
  }

  static _iosLoading() {
    return CupertinoActivityIndicator(
      animating: true, //animating,
    );
  }

  static _androidLoading(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  static void showMessageDialog(BuildContext context, String message,
      Function onPressed, bool hasCancel) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text("Atenção!"),
          content: Text(message),
          actions: hasCancel
              ? <Widget>[
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: onPressed == null
                        ? () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        : onPressed,
                  )
                ]
              : <Widget>[
                  TextButton(
                    child: Text("Ok"),
                    onPressed: onPressed == null
                        ? () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        : onPressed,
                  )
                ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Atenção!"),
          content: Text(message),
          actions: hasCancel
              ? <Widget>[
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text("Ok"),
                    onPressed: onPressed == null
                        ? () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        : onPressed,
                  )
                ]
              : <Widget>[
                  TextButton(
                    child: Text("Ok"),
                    onPressed: onPressed == null
                        ? () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        : onPressed,
                  )
                ],
        ),
      );
    }
  }
}
