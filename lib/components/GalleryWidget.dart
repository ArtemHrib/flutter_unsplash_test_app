import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:unsplash_test_project/entity/PhotoModel.dart';
import 'package:unsplash_test_project/unsplash/plugin/impl/UnsplashPlugin.dart';
import 'package:unsplash_test_project/unsplash/util/ResponseConverter.dart';

import 'PhotoItemWidget.dart';

class GalleryWidget extends StatefulWidget {
  final UnsplashPlugin _unsplashPlugin;
  final Function onClickFunction;

  GalleryWidget(this._unsplashPlugin, this.onClickFunction);

  @override
  State<GalleryWidget> createState() =>
      _GalleryWidgetState(_unsplashPlugin, onClickFunction);
}

class _GalleryWidgetState extends State<GalleryWidget> {
  Function onClickFunction;
  ScrollController scrollController;
  UnsplashPlugin unsplashPlugin;
  int photoPageIndex = 1;
  bool isUpdating = false;
  int builtPage = 0;
  List<Widget> photoModelPage = [];

  _GalleryWidgetState(this.unsplashPlugin, this.onClickFunction);

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController()..addListener(_scrollListener);
    unsplashPlugin
        .getPhotoList(page: photoPageIndex, perPage: 10)
        .then(updatePhotoPage);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && !isUpdating) {
      isUpdating = true;
      _scrollListener();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Container(
          color: Colors.black,
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              return photoModelPage[index];
            },
            itemCount: photoModelPage.length,
          ),
        ),
      ),
    );
  }

  void _scrollListener() async {
    if (scrollController.position.extentAfter == 0) {
      photoPageIndex += 1;
      Response response =
          await unsplashPlugin.getPhotoList(page: photoPageIndex, perPage: 10);
      isUpdating = false;
      updatePhotoPage(response);
    }
  }

  void updatePhotoPage(Response response) {
    List<PhotoModel> photoModelList =
        ResponseConverter.convertToPhotoModelList(response.body);
    Widget photoModelContainer = buildPhotoModelContainer(photoModelList);
    photoModelPage.add(photoModelContainer);
    setState(() {});
  }

  Widget buildPhotoModelContainer(List photoModelList) {
    var container = Container(
      child: Column(
        children: [
          for (int i = 0; i < photoModelList.length; i++)
            PhotoItemWidget(photoModelList[i], onClickFunction)
        ],
      ),
    );
    return container;
  }
}