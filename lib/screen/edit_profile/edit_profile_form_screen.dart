import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pendaki_champion/base/strings.dart';
import 'package:pendaki_champion/model/profile.dart';
import 'package:pendaki_champion/screen/edit_profile/edit_profile_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileFormScreen extends StatefulWidget {
  final Profile profile;

  const EditProfileFormScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfileFormScreen> createState() => _EditProfileFormScreenState();
}

class _EditProfileFormScreenState extends State<EditProfileFormScreen> {

  @override
  void initState() {
    context.read<EditProfileNotifier>().onInitEditProfile(widget.profile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Edit Profile",
            style: TextStyle(fontFamily: "BTTTRIAL"),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: notifier.formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    height: 100,
                                    width: 100,
                                    imageUrl:
                                        "${notifier.imageUrl}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => SizedBox(
                                      width: 70.0,
                                      height: 70.0,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.red,
                                        highlightColor: Colors.yellow,
                                        child: SizedBox(
                                          width: 70,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset("assets/photo-disp.png"),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: InkWell(
                                    onTap: () {
                                      notifier.getCamera(context);
                                    },
                                    child: Card(
                                      color: Colors.blueAccent[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Icon(Icons.camera_alt_rounded),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: InkWell(
                                    onTap: () {
                                      notifier.getImageGallery(context);
                                    },
                                    child: Card(
                                      color: Colors.blue[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Icon(Icons.image),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller: notifier.name,
                                    autocorrect: false,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return Strings.cannotBeEmpty;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller: notifier.email,
                                    autocorrect: false,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return Strings.cannotBeEmpty;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Flexible(
                                  child: TextFormField(
                                    controller: notifier.phone,
                                    autocorrect: false,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return Strings.cannotBeEmpty;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: InkWell(
                      onTap: () {
                        notifier.onSaveChangeProfile();
                      },
                      child: Card(
                        color: Colors.green[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "Save",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
