import 'package:flutter/material.dart';

class NoOptionDialog extends StatefulWidget {
  final String title, subtitle, buttonText;
  final Function()? onPress;

  const NoOptionDialog(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      this.onPress})
      : super(key: key);

  @override
  State<NoOptionDialog> createState() => _NoOptionDialogState();
}

class _NoOptionDialogState extends State<NoOptionDialog> {
  @override
  Widget build(BuildContext context) {
    return dialogContent(context);
  }

  Widget dialogContent(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Text("${widget.title}", textAlign: TextAlign.center),
      content: Text("${widget.subtitle}", textAlign: TextAlign.center),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: widget.onPress,
            child: Card(
              color: Colors.green[200],
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(14),
                child: Text("${widget.buttonText}"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
