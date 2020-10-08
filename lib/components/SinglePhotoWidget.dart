import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:unsplash_test_project/entity/PhotoModel.dart';
import 'package:unsplash_test_project/unsplash/plugin/impl/UnsplashPlugin.dart';
import 'dart:convert';

import 'package:unsplash_test_project/unsplash/util/ResponseConverter.dart';

class SinglePhotoWidget extends StatelessWidget {
  final String _photoId;
  final UnsplashPlugin _unsplashPlugin;
  final Function closeFunction;

  const SinglePhotoWidget(
      this._photoId, this._unsplashPlugin, this.closeFunction);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSinglePhoto(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return createSinglePageWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<Response> getSinglePhoto() {
    return _unsplashPlugin.getSinglePhotoById(_photoId);
  }

  Widget createSinglePageWidget(Response response) {
    var responseItem = jsonDecode(response.body);
    PhotoModel photoModel = ResponseConverter.convertToPhotoModel(responseItem);
    return Container(
      color: Colors.black,
      child: Center(
        child: Stack(
          children: [
            CachedNetworkImage(
              placeholder: (context, url) => Container(
                child: Stack(
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
              imageUrl: photoModel.photoUrl,
            ),
            InkWell(
              onTap: closeFunction,
              child: Container(
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(80, 80, 80, 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
