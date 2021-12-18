import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wizn_system/main.dart';
import 'package:wizn_system/model/model.dart';
import 'package:wizn_system/screens/screen2.dart';

class Screen1 extends StatefulWidget {
  int? fetchDataFromApi;

  Screen1(this.fetchDataFromApi);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'WiZN Systems',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: (fetchDataFromApi != 1)
              ? Provider.of<ModelList>(context).FetchData()
              : Provider.of<ModelList>(context, listen: false)
                  .fetchDataFromDb(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<ModelList>(
                  builder: (ctx, ModelList, ch) => ListView.separated(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 2.h, bottom: 2.h),
                      itemBuilder: (ctx, index) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                )),
                            elevation: 5,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return Screen2(ModelList.allItems[index].id);
                                }));
                              },
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    ModelList.allItems[index].thumbnailUrl),
                                radius: 20.r,
                              ),
                              title: Text(
                                ModelList.allItems[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ),
                      separatorBuilder: (ctx, index) => SizedBox(
                            height: 10.h,
                          ),
                      itemCount: ModelList.allItems.length),
                ),
        ));
  }
}
