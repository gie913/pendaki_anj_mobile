import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pendaki_champion/base/palette.dart';
import 'package:pendaki_champion/base/strings.dart';
import 'package:pendaki_champion/manager/text_manager.dart';
import 'package:pendaki_champion/model/area_group.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/screen/form/form_notifier.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  final MSpecies mSpecies;

  const FormScreen({Key? key, required this.mSpecies}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  void initState() {
    context.read<FormNotifier>().onInit(widget.mSpecies);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          backgroundColor: Colors.green[100],
          appBar: AppBar(
            elevation: 0,
            title: Text("${widget.mSpecies.inaName?.toTitleCase() ?? ""}",
                style: TextStyle(fontFamily: "BTTTRIAL")),
          ),
          body: SingleChildScrollView(
            child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Form Discovery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Text("ID: ${notifier.tDiscovery.id ?? ""}",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Indonesian Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${notifier.tDiscovery.inaName?.toTitleCase() ?? ""}"),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "English Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${notifier.tDiscovery.engName?.toTitleCase() ?? ""}"),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Latin Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${notifier.tDiscovery.latinName?.capitalize() ?? ""}", style: TextStyle(fontStyle: FontStyle.italic),),
                              ],
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date Found",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      theme: DatePickerTheme(
                                          headerColor: Palette.primaryColorProd,
                                          backgroundColor: Colors.white,
                                          doneStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      onChanged: (date) {
                                    notifier.onChangeDate(date);
                                  }, onConfirm: (date) {
                                    notifier.onChangeDate(date);
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Text(
                                  '${notifier.selectedDate ?? "Choose date"}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GPS Coordinate",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            notifier.loading
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                    height: 20,
                                    width: 20,
                                  )
                                : notifier.position != null
                                    ? Row(
                                        children: [
                                          Text("Found "),
                                          Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.green,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text("Not Found "),
                                          InkWell(
                                            onTap: () {
                                              notifier.getLocation();
                                            },
                                            child: Icon(
                                              Icons.update,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: Text("Description",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: notifier.description,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.multiline,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText: "Description"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 100,
                                child: Text("Area Group",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Flexible(
                              child: DropdownButton<AreaGroup>(
                                value: notifier.areaGroup,
                                onChanged: (AreaGroup? value) {
                                  notifier.onChangeAreaGroup(value!);
                                },
                                items: notifier.listAreaGroup
                                    .map<DropdownMenuItem<AreaGroup>>(
                                        (AreaGroup value) =>
                                            DropdownMenuItem<AreaGroup>(
                                              value: value,
                                              child: Text("${value.listData}"),
                                            ))
                                    .toList(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                ),
                                iconSize: 42,
                                underline: SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                child: Text("Area",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: notifier.area,
                                  textInputAction: TextInputAction.newline,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.multiline,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration:
                                      const InputDecoration(hintText: "Area"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Distance (Meter)",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Flexible(
                              child: Container(
                                width: 170,
                                child: TextFormField(
                                  autocorrect: false,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: notifier.distance,
                                  textInputAction: TextInputAction.next,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration:
                                      const InputDecoration(hintText: "Meter"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Strings.cannotBeEmpty;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Disovery",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: InkWell(
                                        onTap: () {
                                          notifier.decrement(1);
                                        },
                                        child: Card(
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: TextFormField(
                                        autocorrect: false,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: notifier.totalCount,
                                        textInputAction: TextInputAction.next,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: const InputDecoration(
                                            hintText: "Jumlah"),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Cannot be Empty";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: InkWell(
                                        onTap: () {
                                          notifier.increment(1);
                                        },
                                        child: Card(
                                          color: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    notifier.pathPhoto.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: notifier.pathPhoto.length == 1
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.file(
                                              File("${notifier.pathPhoto[0]}"),
                                              height: 200,
                                              width: 200,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: InkWell(
                                              onTap: () {
                                                notifier.onPressDeleteImage(
                                                    notifier.pathPhoto[0]);
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(Icons.delete,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : CarouselSlider(
                                    options: CarouselOptions(),
                                    items: notifier.pathPhoto.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.file(
                                                      File("${i}"),
                                                      height: 200,
                                                      width: 200,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        notifier
                                                            .onPressDeleteImage(
                                                                i);
                                                      },
                                                      child: Card(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                          )
                        : Container(
                            height: 10,
                          ),
                    const SizedBox(height: 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            notifier.getCamera(context);
                          },
                          child: Card(
                            color: Colors.blue[800],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "Photo",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            notifier.getGallery(context);
                          },
                          child: Card(
                            color: Colors.blue[500],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            notifier.onPressSave();
                          },
                          child: Card(
                            color: Colors.green,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
