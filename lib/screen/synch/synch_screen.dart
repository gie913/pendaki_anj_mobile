import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/synch/synch_notifier.dart';
import 'package:provider/provider.dart';

class SynchScreen extends StatefulWidget {
  @override
  _SynchScreenState createState() => _SynchScreenState();
}

class _SynchScreenState extends State<SynchScreen> {
  var lastSync;

  @override
  void initState() {
    context.read<SynchNotifier>().doGetSpecies(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<SynchNotifier>(builder: (context, synch, child) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Column(
                    children: [
                      Text("Get Data Species.."),
                      Text("Please Wait"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
