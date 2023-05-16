import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pendaki_champion/manager/value_manager.dart';
import 'package:pendaki_champion/screen/discovery/discovery_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  TextEditingController searchFauna = TextEditingController();

  @override
  void initState() {
    context.read<DiscoveryNotifier>().onInitDiscovery(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoveryNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            widget.title,
            style: TextStyle(fontFamily: "BTTTRIAL"),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextField(
                      onChanged: (value) {
                        notifier.onChangeSearch(value);
                      },
                      controller: searchFauna,
                      decoration: const InputDecoration(
                          hintText: "Search", border: InputBorder.none),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        searchFauna.clear();
                        notifier.onChangeSearch("");
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Discovery"),
                        Text("${notifier.listTDiscovery.length}")
                      ],
                    ),
                  )
                ),
              ),
              notifier.isLoading
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.red,
                            highlightColor: Colors.yellow,
                            child: Text(
                              'Loading data..',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : notifier.listTDiscovery.isNotEmpty
                      ? Flexible(
                          child: ListView.builder(
                            itemCount: notifier.listTDiscoveryResult.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Hero(
                                        tag: "${notifier.listTDiscovery[index].image}",
                                        child: SizedBox(
                                          width: 70,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6),
                                            child: Image.file(
                                              File(
                                                  "${notifier.listTDiscovery[index].image}"),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, url, error) =>
                                                  Image.asset("assets/photo-disp.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        notifier.gotoDetailDiscovery(
                                            context,
                                            notifier
                                                .listTDiscoveryResult[index]);
                                      },
                                      title: Text(
                                        "${notifier.listTDiscoveryResult[index].inaName?.toUpperCase()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${notifier.listTDiscoveryResult[index].code}"),
                                          Divider(),
                                          Text(
                                              "Total Found: ${notifier.listTDiscoveryResult[index].totalFound}"),
                                          Text(
                                              "Date Found: ${notifier.listTDiscoveryResult[index].dateFound}"),
                                          Divider(),
                                          Text(
                                              "Date Created: ${ValueManager.dateFormatted(notifier.listTDiscoveryResult[index].createdAt!)}")
                                        ],
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          notifier.deleteDiscovery(
                                              notifier
                                                  .listTDiscoveryResult[index]);
                                        },
                                        child: Card(
                                          elevation: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.delete,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Flexible(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/orangutan.png", height: 100),
                                  Text(
                                    "There is no Discovery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              notifier.doUploadDiscovery();
            },
            label: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  child: child,
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(Icons.cloud_upload_outlined),
                  ),
                  Text("Upload Data")
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
