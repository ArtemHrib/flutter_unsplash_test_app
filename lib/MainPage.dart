import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_test_project/unsplash/plugin/impl/UnsplashPlugin.dart';
import 'package:unsplash_test_project/constants/AppConstants.dart' as constants;

import 'components/GalleryWidget.dart';
import 'components/SinglePhotoWidget.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UnsplashPlugin unsplashPlugin;
  Map<String, Widget> pageMap;
  Widget currentPageWidget;

  _MainPageState() {
    unsplashPlugin = UnsplashPlugin('https://api.unsplash.com',
        'Client-ID lAxUOdWynedrmIrk2jiccEydVTV6n-5o0a8sUdbJsZI');
    pageMap = {
      constants.GALLERY_PAGE: GalleryWidget(unsplashPlugin, setSinglePhotoPage),
    };
    currentPageWidget = pageMap[constants.GALLERY_PAGE];
  }

  void setSinglePhotoPage(String photoId) {
    currentPageWidget = SinglePhotoWidget(photoId, unsplashPlugin, setGalleryPage);
    setState(() {});
  }

  void setGalleryPage() {
    currentPageWidget = pageMap[constants.GALLERY_PAGE];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: currentPageWidget,
      ),
    );
  }
}