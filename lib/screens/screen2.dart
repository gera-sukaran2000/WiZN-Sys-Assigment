import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wizn_system/model/model.dart';

class Screen2 extends StatefulWidget {
  int itemId;

  Screen2(this.itemId);

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    final itemObject = Provider.of<ModelList>(context, listen: false)
        .getsingleItem(widget.itemId);

    return Scaffold(
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
      body: Stack(
        children: [
          Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
              child: Container(
                height: 400.h,
                width: 300.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 200.h,
                      width: 280.w,
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Image(
                        image: NetworkImage(itemObject.url),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Text(itemObject.title,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter')),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  favorite = !favorite;
                                });
                              },
                              icon: Icon(
                                (favorite == false)
                                    ? Icons.star_border
                                    : Icons.star,
                                size: 25.sp,
                                color: Colors.red,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          IconButton(
                              onPressed: () {
                                Provider.of<ModelList>(context, listen: false)
                                    .removeItem(widget.itemId);
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 25.sp,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: IconButton(
                onPressed: () {
                  widget.itemId = widget.itemId + 1;
                  if (widget.itemId > 5000) {
                    widget.itemId = widget.itemId - 1;
                    return;
                  }
                  setState(() {});
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.sp,
                )),
            right: 5.w,
            top: 300.w,
          ),
          Positioned(
            child: IconButton(
                onPressed: () {
                  widget.itemId = widget.itemId - 1;
                  if (widget.itemId <= 0) {
                    widget.itemId = widget.itemId + 1;
                    return;
                  }
                  setState(() {});
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25.sp,
                )),
            left: 5.w,
            top: 330.w,
          ),
          // Positioned(
          //     top: 300.w,
          //     right: 40.w,
          //     child: )
        ],
      ),
    );
  }
}
