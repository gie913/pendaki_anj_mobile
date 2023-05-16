import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:pendaki_champion/screen/home/home_notifier.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pendaki_champion/manager/text_manager.dart';

class Item extends StatelessWidget {
  final MSpecies mSpecies;

  const Item({Key? key, required this.mSpecies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                leading: Card(
                  elevation: 3,
                  child: Hero(
                    tag: "${mSpecies.inaName?.toTitleCase() ?? "-"}",
                    child: SizedBox(
                      width: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${mSpecies.imageUrl}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
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
                ),
                onTap: () {
                  HomeNotifier().navigateForm(context, mSpecies);
                },
                title: Text("${mSpecies.inaName?.toTitleCase() ?? "-"}"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start
                  ,
                  children: [
                    Text("${mSpecies.latinName?.capitalize() ?? "-"}", style: TextStyle(fontStyle: FontStyle.italic)),
                    Text("${mSpecies.mBioFamilyName?.toTitleCase() ?? "-"}"),
                  ],
                ),
                trailing: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: InkWell(
                      onTap: () {
                        HomeNotifier().navigateDetail(context, mSpecies);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.info,
                          color: Colors.green,
                          size: 35,
                        ),
                      ),
                  ),
                )),
          ),
        ),
    );
  }
}
