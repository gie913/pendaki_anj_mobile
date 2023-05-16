import 'package:flutter/material.dart';
import 'package:pendaki_champion/screen/home/home_notifier.dart';
import 'package:pendaki_champion/widget/item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchFauna = TextEditingController();

  @override
  void initState() {
    context.read<HomeNotifier>().onInitHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<HomeNotifier>(builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              widget.title,
              style: TextStyle(fontFamily: "BTTTRIAL"),
            ),
            // actions: [
            //   Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //       child: InkWell(
            //         onTap: () {
            //           notifier.navigateToList(context);
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.only(right: 10),
            //           child: Row(
            //             children: [
            //               Icon(
            //                 Icons.list_alt_rounded,
            //                 size: 30,
            //                 color: Colors.black,
            //               ),
            //               SizedBox(width: 4),
            //               Text("My Discovery")
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
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
                    : notifier.listFauna.isNotEmpty
                        ? Flexible(
                            child: ListView.builder(
                              itemCount: notifier.listFaunaResult.length,
                              itemBuilder: (context, index) {
                                return Item(
                                  mSpecies: notifier.listFaunaResult[index],
                                );
                              },
                            ),
                          )
                        : Flexible(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Image.asset("assets/orangutan.png"),
                                    Text("There is no Species",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                          )
              ],
            ),
          ),
        );
      }),
    );
  }
}
