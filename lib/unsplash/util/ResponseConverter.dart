import 'dart:convert';

import 'package:unsplash_test_project/entity/PhotoModel.dart';
import 'package:unsplash_test_project/unsplash/constants/UnsplashConstants.dart'
    as constants;

class ResponseConverter {
  static List<PhotoModel> convertToPhotoModelList(String responseBody) {
    var itemList = jsonDecode(responseBody);
    return List.generate(itemList.length,
         (i) => convertToPhotoModel(itemList[i]));
  }

  static PhotoModel convertToPhotoModel(Map responseItem) {
    String id = responseItem[constants.RESPONSE_ID_PARAM];
    Map photoUrls = responseItem[constants.RESPONSE_PHOTO_URLS_PARAM];
    String photoUrl = photoUrls[constants.RESPONSE_RAW_IMG_PARAM];
    Map user = responseItem[constants.RESPONSE_USER_PARAM];
    String userName = user[constants.RESPONSE_USERNAME_PARAM];
    return PhotoModel(id, photoUrl, userName);
  }
}
