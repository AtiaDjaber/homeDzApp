import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_dz/controllers/home_controller.dart';
import 'package:home_dz/models/category.dart';
import 'package:home_dz/models/post.dart';
import 'package:home_dz/models/section.dart';
import 'package:home_dz/service/HelperService.dart';
import 'package:home_dz/views/detail_view.dart';
import 'package:home_dz/views/favorite_view.dart';
import 'package:shimmer/shimmer.dart';

import 'AddPostView.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Ecommerce"),
            actions: [
              InkWell(
                  onTap: () {
                    Get.to(() => FavoriteView());
                  },
                  child: Icon(Icons.favorite, color: Colors.red))
            ],
          ),
          body: Container(
            color: Colors.grey.shade50,
            child: Column(
              children: [
                GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (_) => _.loading_categories
                        ? SizedBox(
                            height: 50,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _.listCategories.length,
                              itemBuilder: (context, index) {
                                return buildCategories(
                                    index, _.listCategories[index], context);
                              },
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            ],
                          )),
                GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (_) => SizedBox(
                          height: 50,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _.listSections.length,
                            itemBuilder: (context, index) {
                              return buildSections(
                                  index, _.listSections[index], context);
                            },
                          ),
                        )),
                Expanded(
                  child: GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (_) => NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        // if (!_.secend_loading_post &&
                        //     scrollInfo.metrics.pixels ==
                        //         scrollInfo.metrics.maxScrollExtent) {
                        //   _.loadMore();
                        // }
                        return true;
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          if (controller.loading_posts) ...[
                            for (var i = 0; i < _.lisPosts.length; i++) ...[
                              buildPosts(i, _.lisPosts[i], context),
                            ]
                          ] else ...[
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade50,
                              enabled: true,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(4),
                                shrinkWrap: true,
                                itemCount: 6,
                                itemBuilder: (_, __) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              height: 8.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.0),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 100),
                                                SizedBox(
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 100),
                                                SizedBox(
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                          Container(
                            height: controller.secend_loading_post ? 50.0 : 0,
                            color: Colors.transparent,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("جميع الحقوق محفوظة  ©")],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  DateTime now = DateTime.now();

  final heplerService = Get.find<HelperService>();
  Widget buildPosts(int index, Post post, context) {
    final difference = now.difference(post.createdAt!);
    var ago = timeago
        .format(now.subtract(difference), locale: "en_short")
        .replaceAll("m", " دقيقة ")
        .replaceAll("h", " ساعة ")
        .replaceAll("d", " يوم ")
        .replaceAll("mo", " شهر ");

    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 4),
      child: InkWell(
          onTap: () {
            heplerService.post = post;
            Get.to(() => DetailView());
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 4.0, right: 4, top: 2, bottom: 2),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 105,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade50,
                            offset: const Offset(0.2, 0.2),
                            blurRadius: 10)
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      color: Colors.grey.shade100,
                      height: 90,
                      width: 90,
                      child: CachedNetworkImage(
                        imageUrl: post.photo!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade50,
                                  offset: const Offset(0.2, 0.2),
                                  blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => SizedBox(
                          height: 90,
                          width: 90,
                          child: Shimmer.fromColors(
                              enabled: true,
                              child: const SizedBox(height: 90, width: 90),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade50),
                        ),
                        errorWidget: (context, url, error) => Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Icon(Icons.error_outline,
                                  color: Colors.white, size: 35),
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        post.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 105,
                      top: 30,
                      child: Row(
                        children: <Widget>[
                          Text(
                            post.user!.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.person_outline,
                            color: Colors.black54,
                            size: 22,
                          ),
                        ],
                      )),
                  Positioned(
                      right: 105,
                      top: 60,
                      child: Row(
                        children: <Widget>[
                          Text(
                            post.location!.name ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.black45,
                            size: 22,
                          ),
                        ],
                      )),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.75,
                      top: 60,
                      child: Row(
                        children: <Widget>[
                          Text(
                            ago,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                          const Icon(Icons.timer,
                              color: Colors.black45, size: 20),
                        ],
                      )),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.75,
                      top: 30,
                      child: Row(
                        children: <Widget>[
                          Text(
                            post.price.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.chat_outlined,
                              color: Colors.black45, size: 22),
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }

  Widget buildCategories(int index, Category category, context) {
    return InkWell(
      onTap: () {
        controller.selectCategorie(index);
        // Get.to(() => AddPostView());
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
                color: controller.postFilter.categoryId == category.id
                    ? Colors.blue
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1, color: Colors.blue.shade300.withOpacity(0.4)),
              ),
              child: Center(
                  child: Text(
                category.name ?? "",
                style: TextStyle(
                    color: controller.postFilter.categoryId == category.id
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 17,
                    fontWeight: controller.postFilter.categoryId == category.id
                        ? FontWeight.bold
                        : FontWeight.w500),
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
                color: controller.postFilter.sectionId == section.id
                    ? Colors.blue
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1, color: Colors.blue.shade300.withOpacity(0.4)),
              ),
              child: Center(
                  child: Text(
                section.name ?? "",
                style: TextStyle(
                    color: controller.postFilter.sectionId == section.id
                        ? Colors.white
                        : Colors.black54,
                    fontSize: 17,
                    fontWeight: controller.postFilter.sectionId == section.id
                        ? FontWeight.bold
                        : FontWeight.w500),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
