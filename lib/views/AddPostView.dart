import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_dz/controllers/AddPostController.dart';
import 'package:home_dz/controllers/home_controller.dart';
import 'package:home_dz/models/category.dart';
import 'package:home_dz/models/section.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddPostView extends StatelessWidget {
  final controller = Get.put(AddPostController());
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Color(0xFFFCFAF8),
          body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   height: 50.0,
                    //   width: 190.0,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: AssetImage("assets/login.png"),
                    //           fit: BoxFit.fill,
                    //           alignment: Alignment.bottomCenter)),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "إضافة اعلان جديد",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<AddPostController>(
                      builder: (_) => SizedBox(
                        height: 50,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: homeCtr.listCategories.length,
                          itemBuilder: (context, index) {
                            return buildCategories(
                                index, homeCtr.listCategories[index], context);
                          },
                        ),
                      ),
                    ),
                    GetBuilder<AddPostController>(
                      builder: (_) => SizedBox(
                        height: 50,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _.sections.length,
                          itemBuilder: (context, index) {
                            return buildSections(
                                index, _.sections[index], context);
                          },
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 2.0, right: 2.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]!),
                                      )),
                                      child: TextField(
                                        controller: controller.titleController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "عنوان الاعلان",
                                            prefixIcon: Icon(Icons.title),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                    // Container(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: TextField(
                                    //     keyboardType:
                                    //         TextInputType.visiblePassword,
                                    //     controller:
                                    //         controller.contactController,
                                    //     decoration: InputDecoration(
                                    //         border: InputBorder.none,
                                    //         hintText: "رقم الهاتف",
                                    //         prefixIcon: Icon(Icons.call),
                                    //         hintStyle: TextStyle(
                                    //             color: Colors.grey[400])),
                                    //   ),
                                    // ),

                                    // GetBuilder<AddPostController>(
                                    //   init: AddPostController(),
                                    //   builder: (_) => Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.start,
                                    //     children: <Widget>[
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             right: 18.0),
                                    //         child: Container(
                                    //           height: 40,
                                    //           width: MediaQuery.of(context)
                                    //                   .size
                                    //                   .width -
                                    //               50,
                                    //           child: FutureBuilder(
                                    //             future: controller.getLocation(),
                                    //             builder: (BuildContext context,
                                    //                 AsyncSnapshot snapshot) {
                                    //               return snapshot.hasData
                                    //                   ? Container(
                                    //                       decoration:
                                    //                           BoxDecoration(
                                    //                         color: Colors.white,
                                    //                       ),
                                    //                       child:
                                    //                           DropdownButtonHideUnderline(
                                    //                         child: DropdownButton<
                                    //                             String>(
                                    //                           icon: Icon(
                                    //                             Icons.pin_drop,
                                    //                             color:
                                    //                                 Colors.grey,
                                    //                           ),
                                    //                           hint: Text(controller
                                    //                                   .dropDownValue ??
                                    //                               'اختر المحافظة'),
                                    //                           elevation: 0,
                                    //                           items: snapshot.data.map<
                                    //                               DropdownMenuItem<
                                    //                                   String>>((item) {
                                    //                             return DropdownMenuItem<
                                    //                                 String>(
                                    //                               key: Key(
                                    //                                   item["id"]),
                                    //                               value: item[
                                    //                                   "name"],
                                    //                               child: Text(item[
                                    //                                   "name"]),
                                    //                             );
                                    //                           }).toList(),
                                    //                           // value: controller
                                    //                           //     .dropDownValue,
                                    //                           onChanged: (value) {
                                    //                             controller
                                    //                                 .selectedLoaction(
                                    //                                     value);
                                    //                           },
                                    //                         ),
                                    //                       ),
                                    //                     )
                                    //                   : Container(
                                    //                       child: Center(
                                    //                         child: Text(
                                    //                             'Loading...'),
                                    //                       ),
                                    //                     );
                                    //             },
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]!))),
                                      child: TextField(
                                        maxLines: 5,
                                        controller:
                                            controller.descriptionController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "الوصف",
                                            prefixIcon: Icon(Icons.description),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        InkWell(
                                            onTap: () {
                                              controller.getFile();
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                ),
                                                width: 160,
                                                height: 45,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "تحميل الصور",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons.file_upload,
                                                        size: 30,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                )))
                                      ],
                                    ),
                                    // GetBuilder<AddPostController>(
                                    //   init: AddPostController(),
                                    //   builder: (v) => Wrap(
                                    //     alignment: WrapAlignment.center,
                                    //     children: <Widget>[
                                    //       if (v.files != null) ...[
                                    //         for (var i = 0;
                                    //             i < v.files.length;
                                    //             i++) ...[
                                    //           Padding(
                                    //             padding:
                                    //                 const EdgeInsets.all(8.0),
                                    //             child: Stack(children: <Widget>[
                                    //               v.files != null
                                    //                   ? Positioned(
                                    //                       right: -10,
                                    //                       top: -10,
                                    //                       child: IconButton(
                                    //                           icon: Icon(
                                    //                               Icons.cancel),
                                    //                           color: Colors.pink,
                                    //                           onPressed: () {
                                    //                             v.files
                                    //                                 .removeAt(i);
                                    //                           }))
                                    //                   : Text("")
                                    //             ]),
                                    //           ),
                                    //         ],
                                    //       ]
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GetBuilder<AddPostController>(
                                      init: AddPostController(),
                                      builder: (v) => Wrap(
                                        alignment: WrapAlignment.center,
                                        children: <Widget>[
                                          if (v.files != null) ...[
                                            for (var i = 0;
                                                i < v.files.length;
                                                i++) ...[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      color: Colors.grey[300],
                                                      width: 90,
                                                      height: 90,
                                                      child: v.files == null
                                                          ? Icon(
                                                              Icons.add,
                                                              size: 38,
                                                            )
                                                          : Image.file(
                                                              v.files[i],
                                                              fit: BoxFit.fill,
                                                            ),
                                                    ),
                                                    v.files != null
                                                        ? Positioned(
                                                            right: -10,
                                                            top: -10,
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.cancel),
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              onPressed: () {
                                                                controller
                                                                    .deleteImage(
                                                                        i);
                                                              },
                                                            ))
                                                        : Text("")
                                                  ],
                                                ),
                                              ),
                                            ]
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: MaterialButton(
                                  onPressed: () {
                                    controller.addPost();
                                  },
                                  child: Text(
                                    'إضافة الاعلان',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  color: Colors.blue,
                                  elevation: 4,
                                  minWidth: 300,
                                  height: 50,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     Navigator.pop(context);
                              //   },
                              //   child: Text(
                              //     " هل لديك حساب مسبقا ؟",
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.black54,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        if (controller.saving.value) ...[
                          Positioned(
                            // top:100,
                            // left: MediaQuery.of(context).size.width/2,

                            child: Center(
                              child: SpinKitCircle(
                                color: Colors.blue,
                                size: 100,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(icon: Icons.home, title: 'رئيسية'),
              TabItem(icon: Icons.notifications_active, title: 'إشعارات'),
              TabItem(icon: Icons.add, title: 'إضافة'),
              TabItem(icon: Icons.message, title: 'رسائل'),
              TabItem(icon: Icons.favorite, title: 'مفضلة'),
            ],

            height: 60,
            initialActiveIndex: 2, //optional, default as 0
            onTap: (int i) {
              // if (i == 0) {
              //   Get.off(HomeView());
              // }
              // if (i == 1) {
              //   Get.off(NotificationPage());
              // }
              // if (i == 2) {
              //   Get.off(AddPostView());
              // }
              // if (i == 3) {
              //   Get.off(FriendsPage());
              // }
              // if (i == 4) {
              //   Get.off(FavPage());
              // }
            },
          )
          //       isLoading: _saving,progressIndicator: CircularProgressIndicator()),
          ),
    );
  }

  // showAlert(String error_msg, context) async {
  //   if (error_msg.contains("valid email")) {
  //     error_msg = "يرجى ادخال بريد الاكتروني صحيح";
  //   }
  //   if (error_msg.contains("موجود")) {
  //     error_msg = "البريد الاكتروني موجود مسبقا  ";
  //   }
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromTop,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: false,
  //     descStyle: TextStyle(fontSize: 16),
  //     animationDuration: Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(2.0),
  //       side: BorderSide(
  //         color: Colors.blue,
  //       ),
  //     ),
  //     titleStyle: TextStyle(
  //         fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20),
  //   );
  //   Alert(
  //       context: context,
  //       style: alertStyle,
  //       title: "خطأ ",
  //       desc: error_msg,
  //       buttons: [
  //         DialogButton(
  //           color: Colors.blue,
  //           onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
  //           child: Text(
  //             "موافق",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]).show();
  // }

  Widget buildCategories(int index, Category category, context) {
    return InkWell(
      onTap: () {
        controller.selectCategorie(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              height: 40,
              // width: 100,
              decoration: BoxDecoration(
                color: controller.selectedCatgeory == index
                    ? Colors.blue
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1, color: Colors.blue.shade300.withOpacity(0.4)),
              ),
              child: Center(
                  child: Text(
                category.name ?? "",
                style: TextStyle(
                    color: controller.selectedCatgeory == index
                        ? Colors.white
                        : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSections(int index, Section section, context) {
    return InkWell(
      onTap: () {
        controller.selectSection(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
              height: 40,
              // width: 100,
              decoration: BoxDecoration(
                color: controller.selectedSection == index
                    ? Colors.blue
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1, color: Colors.blue.shade300.withOpacity(0.4)),
              ),
              child: Center(
                  child: Text(
                section.name ?? "",
                style: TextStyle(
                    color: controller.selectedSection == index
                        ? Colors.white
                        : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
