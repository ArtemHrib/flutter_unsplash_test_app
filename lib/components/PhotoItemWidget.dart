import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_test_project/entity/PhotoModel.dart';

class PhotoItemWidget extends StatelessWidget {
  final PhotoModel _photoModel;
  final Function onClickFunction;

  const PhotoItemWidget(this._photoModel, this.onClickFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 70, right: 70, bottom: 30),
      child: Stack(
        children: [
          InkWell(
            onTap: photoClicked,
            child: Center(
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
                imageUrl: _photoModel.photoUrl,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            color: Color.fromRGBO(80, 80, 80, 0.5),
            child: Text(
              _photoModel.authorName,
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void photoClicked() {
    onClickFunction(_photoModel.id);
  }
}
