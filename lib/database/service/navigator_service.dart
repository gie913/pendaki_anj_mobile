import 'package:flutter/material.dart';

class NavigatorService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(
    String routeName, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacement(
    String routeName, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil(
    String routeName,
    String removeRootName, {
    dynamic arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(removeRootName),
        arguments: arguments);
  }

  bool pop() {
    navigatorKey.currentState!.pop();
    return true;
  }

  void popUntil(
    String routeName, {
    dynamic arguments,
  }) {
    navigatorKey.currentState!.popUntil((route) {
      return route.settings.name == routeName;
    });
  }

  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  Future<bool> onWillPopForm(BuildContext context) async {
    return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: Text('Keluar Form'),
                    content: Text(
                      'Anda belum menyimpan data, \nApakah Anda ingin keluar dari form ?',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(14),
                                    child: Text("Ya",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(14),
                                    child: Text("Tidak",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ])) ??
        false;
  }
}
