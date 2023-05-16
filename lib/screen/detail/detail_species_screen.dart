import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pendaki_champion/manager/text_manager.dart';
import 'package:pendaki_champion/model/m_species.dart';
import 'package:shimmer/shimmer.dart';

class DetailMSpeciesScreen extends StatefulWidget {
  final MSpecies mSpecies;

  const DetailMSpeciesScreen({Key? key, required this.mSpecies})
      : super(key: key);

  @override
  State<DetailMSpeciesScreen> createState() => _DetailMSpeciesScreenState();
}

class _DetailMSpeciesScreenState extends State<DetailMSpeciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("${widget.mSpecies.inaName?.toTitleCase() ?? ""}",
            style: TextStyle(fontFamily: "BTTTRIAL")),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: "${widget.mSpecies.engName ?? ""}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            height: 280,
                            imageUrl: "${widget.mSpecies.imageUrl}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => SizedBox(
                              width: 200.0,
                              height: 100.0,
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
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Indonesian Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.inaName?.toTitleCase() ?? "-"}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "English Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.engName?.toTitleCase() ?? "-"}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Latin Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.latinName?.capitalize() ?? "-"}",
                                  textAlign: TextAlign.left,
                                    style: TextStyle(fontStyle: FontStyle.italic)
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Family",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.mBioFamilyName?.toTitleCase() ?? "-"}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Class Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.mBioClassName?.toTitleCase() ?? "-"}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Habitus Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.mHabitusName?.toTitleCase() ?? "-"}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NCBI Code",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.ncbiCode}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gov Rule PP",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.govRulePp}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gov Rule Permenlhk106",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.govRulePermenlhk106}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "IUCN",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.mSpecies.iucn ?? "-"}",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
