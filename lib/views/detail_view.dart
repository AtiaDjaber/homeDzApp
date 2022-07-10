import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:home_dz/controllers/detail_controller.dart';
import 'package:home_dz/models/comment.dart';
import 'package:home_dz/models/image.dart' as imageModel;
import 'package:home_dz/models/post.dart';
import 'package:home_dz/service/HelperService.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailView extends StatelessWidget {
  final controller = Get.put(DetailController());
  final helperService = Get.find<HelperService>();
  DateTime now = DateTime.now();

  Widget imagesDesc(Post post, context) {
    return
        // InteractiveViewer(
        //     maxScale: 2,
        //     minScale: 1,
        //     boundaryMargin: EdgeInsets.all(1.0),
        //     child:
        SizedBox(
      height: 280.0,
      width: Get.width,
      child: CarouselSlider(
        items: [
          CachedNetworkImage(
            imageUrl: post.photo!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade50,
                      offset: const Offset(0.2, 0.2),
                      blurRadius: 10)
                ],
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
            placeholder: (context, url) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SpinKitDoubleBounce(color: Colors.blue, size: 50)
              ],
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          for (var i = 0; i < post.images!.length; i++) ...[
            CachedNetworkImage(
              imageUrl: post.images![i].url!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(0.2, 0.2),
                        blurRadius: 10)
                  ],
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
              placeholder: (context, url) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitDoubleBounce(color: Colors.blue, size: 50)
                ],
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          ]
        ],
        options: CarouselOptions(
          height: 300,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,

          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  String idOld = "0";
  var ago = "1 h";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.blue[500]),
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        height: (MediaQuery.of(context).size.height / 2) - 50,
                      ),
                      // Obx(
                      //   () => Stack(
                      //     alignment: Alignment.bottomCenter,
                      //     children: <Widget>[
                      //       Hero(
                      //         tag: "1",
                      //         child: Container(
                      //           height: 300,
                      //           decoration: BoxDecoration(
                      //               color: Colors.grey[300],
                      //               image: DecorationImage(
                      //                   image: NetworkImage(
                      //                       "https://sooqyemen.com/files/image/upload/" +
                      //                           ctrDetail.mainPhoto.value),
                      //                   fit: BoxFit.fill)),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Column(
                        children: [
                          imagesDesc(helperService.post!, context),
                        ],
                      ),

                      Positioned(
                          top: 20,
                          left: 20,
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      Positioned(
                        top: 20,
                        right: 20,
                        height: 40,
                        width: 40,
                        child: GetBuilder<DetailController>(
                          builder: (_) => InkWell(
                            onTap: () async {
                              if (!controller.isFav) {
                                controller.addFav(helperService.post!.id!);
                              } else {
                                controller.deleteFav(helperService.post!.id!);
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: controller.isLoadingFav
                                  ? CircularProgressIndicator(color: Colors.red)
                                  : controller.isFav
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 80,
                          right: 20,
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: () async {
                              // Get.to(ChatFriends(
                              //     userId, post.iduser, post.name, post.title));
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                child: const Icon(Icons.chat_rounded,
                                    color: Colors.white)),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0, left: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    helperService.post!.price.toString(),
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.message,
                                      color: Colors.black45),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    helperService.post!.user!.name!.length > 25
                                        ? helperService.post!.user!.name!
                                            .substring(0, 24)
                                        : helperService.post!.user!.name!,
                                    overflow: TextOverflow.fade,
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.person,
                                      color: Colors.black45),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14, left: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    helperService.post!.location!.name ?? "",
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.pin_drop,
                                      color: Colors.black45),
                                ],
                              ),
                              Row(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      ago
                                          .replaceAll("h", "ساعة")
                                          .replaceAll("d", "يوم")
                                          .replaceAll("mo", "شهر"),
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.timer, color: Colors.black45),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 8),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        helperService.post!.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 14),
                        textAlign: TextAlign.right,
                        maxLines: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        child: Text(
                          helperService.post!.description ?? "",
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 15),
                          textAlign: TextAlign.right,
                          maxLines: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  child: Text(" المزيد من اعلانات العضو : " +
                      helperService.post!.user!.name!),
                ),
              ),
              GetBuilder<DetailController>(
                builder: (_) {
                  return SizedBox(
                      height: 100,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: controller.listPostsByUser.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    child: CachedNetworkImage(
                                      imageUrl: controller
                                          .listPostsByUser[index].photo!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade50,
                                                offset: Offset(0.2, 0.2),
                                                blurRadius: 10)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: Shimmer.fromColors(
                                          enabled: true,
                                          child:
                                              Container(height: 90, width: 90),
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ));
                },
              ),
              const Divider(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                    child: Text(" المزيد من اعلانات  : " +
                        helperService.post!.section!.name!)),
              ),
              GetBuilder<DetailController>(
                builder: (_) {
                  return SizedBox(
                      height: 100,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: controller.listPostsBySection.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    helperService.post =
                                        controller.listPostsBySection[index];
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    child: CachedNetworkImage(
                                      imageUrl: controller
                                          .listPostsBySection[index].photo!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade50,
                                                offset: Offset(0.2, 0.2),
                                                blurRadius: 10)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: Shimmer.fromColors(
                                          enabled: true,
                                          child:
                                              Container(height: 90, width: 90),
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ));
                },
              ),
              const Divider(),
              GetBuilder<DetailController>(
                builder: (_) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 300,
                      child: Container(
                        color: Colors.grey[200],
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Text(
                                      "التعليقات" +
                                          " ( " +
                                          controller.countComments +
                                          " ) ",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  children: <Widget>[
                                    for (var i = 0;
                                        i < _.listComments.length;
                                        i++) ...[
                                      buildComments(
                                          i, _.listComments[i], context)
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.grey.shade50),
                )),
                child: TextField(
                  controller: controller.textCommentController,
                  maxLines: null,
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.multiline, // maxLines: null,
                  // minLines: null,
                  // expands: true,
                  decoration: InputDecoration(
                      hintText: " اضافة تعليق للمعلن هنا",
                      prefixIcon: const Icon(Icons.comment),
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
              GetBuilder<DetailController>(
                builder: (_) => !controller.addCommentLoading
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: MaterialButton(
                          onPressed: () {
                            controller.addComment();
                          },
                          child: Text(
                            'إرسال التعليق',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Colors.blue,
                          elevation: 4,
                          minWidth: 300,
                          height: 45,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        child: SpinKitDoubleBounce(
                          size: 40,
                          color: Colors.blue,
                        )),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            sharePost(idOld);
          },
          child: const Icon(Icons.share),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  Widget buildComments(int position, Comment comment, BuildContext context) {
    final difference = now.difference(comment.createdAt!);
    var ago = timeago
        .format(now.subtract(difference), locale: "en_short")
        .replaceAll("m", " دقيقة ")
        .replaceAll("h", " ساعة ")
        .replaceAll("d", " يوم ")
        .replaceAll("mo", " شهر ");

    return Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.grey, size: 20),
                        const SizedBox(width: 2),
                        Text(
                          comment.user!.name ?? "",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.timer, color: Colors.grey, size: 20),
                          const SizedBox(width: 2),
                          Text(ago),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   endIndent: 30,
              //   indent: 30,
              //   color: Colors.blue[100],
              // ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  child: Text(comment.text ?? "", maxLines: 4),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> sharePost(String idPost) async {
    // String url = "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    Share.share("https://sooqyemen.com/11" + idPost);

    // var url = "https://sooqyemen.com/11" + ctrDetail.idPost.value.toString();
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Container(
//     child: Directionality(
//       textDirection: TextDirection.rtl,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//                 border:
//                     Border.all(color: Colors.white, width: 2),
//                 color: Colors.purple[100],
//                 shape: BoxShape.circle),
//             child: Icon(
//               Icons.chat,
//               color: Colors.purple,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//                 border:
//                     Border.all(color: Colors.white, width: 2),
//                 color: Colors.green[100],
//                 shape: BoxShape.circle),
//             child: Icon(
//               Icons.call,
//               color: Colors.green,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 2),
//               color: Colors.red[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               MdiIcons.flag,
//               color: Colors.red,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 2),
//               color: Colors.blue[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               MdiIcons.facebook,
//               color: Colors.blue,
//             ),
//           ),
//           Container(
//             height: 40,
//             width: 40,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white, width: 2),
//               color: Colors.green[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               MdiIcons.whatsapp,
//               color: Colors.green,
//             ),
//           ),
//           InkWell(
//               onTap: () async {
//                 // _delete(8);

//                 ctrDetail.makePhoneCall(ctrDetail.number);
//               },
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 padding: EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   border:
//                       Border.all(color: Colors.white, width: 2),
//                   color: Colors.blue[100],
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   MdiIcons.twitter,
//                   color: Colors.blue,
//                 ),
//               ))
//         ],
//       ),
//     ),
//   ),
// ),
// Directionality(
//   textDirection: TextDirection.rtl,
//   child: Padding(
//     padding: const EdgeInsets.only(left: 12.0, right: 12),
//     child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.person,
//                 color: Colors.black54,
//                 size: 20,
//               ),
//               Text(ctrDetail.user_name.value),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.chat,
//                 color: Colors.black54,
//                 size: 20,
//               ),
//               Text(ctrDetail.replayCount.value + " "),
//             ],
//           )
//         ]),
//   ),
// ),
// SizedBox(
//   height: 4,
// ),
// Directionality(
//   textDirection: TextDirection.rtl,
//   child: Padding(
//     padding: const EdgeInsets.only(right: 12.0, left: 12),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: <Widget>[
//             Icon(
//               Icons.pin_drop,
//               color: Colors.black54,
//               size: 20,
//             ),
//             Text(
//               ctrDetail.locationName.value,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                   fontSize: 12, color: Colors.black54),
//             ),
//           ],
//         ),
//         Row(
//           children: <Widget>[
//             Icon(
//               Icons.timer,
//               color: Colors.black54,
//               size: 20,
//             ),
//             Text(
//               ctrDetail.timeAgo.value,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                   fontSize: 12, color: Colors.black54),
//             ),
//           ],
//         )
//       ],
//     ),
// ),
// ),
