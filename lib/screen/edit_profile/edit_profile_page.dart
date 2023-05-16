import 'package:flutter/material.dart';
import 'package:pendaki_champion/model/profile.dart';
import 'package:pendaki_champion/screen/edit_profile/edit_profile_form_screen.dart';
import 'package:provider/provider.dart';

import 'edit_profile_notifier.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileNotifier(),
      child: EditProfileFormScreen(profile: widget.profile),
    );
  }
}
