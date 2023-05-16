import 'package:flutter/material.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/screen/form/form_notifier.dart';
import 'package:pendaki_champion/screen/form/form_screen.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  final MSpecies mSpecies;

  const FormPage({Key? key, required this.mSpecies}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormNotifier(),
      child: FormScreen(
        mSpecies: widget.mSpecies,
      ),
    );
  }
}
