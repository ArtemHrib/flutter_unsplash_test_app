import 'package:http/http.dart';
import 'package:unsplash_test_project/unsplash/constants/UnsplashConstants.dart'
    as constants;

class UnsplashPlugin {
  final String _url;
  final Map<String, String> _headers;

  UnsplashPlugin(this._url, _authorizationToken)
      : _headers = {constants.HEADER_AUTHORIZATION: _authorizationToken};

  Future<Response> getPhotoList({
    int page = 1,
    int perPage = 9,
    String orderBy = constants.ORDER_BY_LATEST,
  }) async {
    String requestUrl =
        '$_url/photos?page=$page&per_page=$perPage&order_by=$orderBy';
    Response response = await get(requestUrl, headers: _headers);
    return response;
  }

  Future<Response> getSinglePhotoById(String id) async {
    String requestUrl = '$_url/photos/$id';
    Response response = await get(requestUrl, headers: _headers);
    return response;
  }
}
