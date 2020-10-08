class PhotoModel {
  final String _id;
  final String _photoUrl;
  final String _authorName;

  PhotoModel(this._id, this._photoUrl, this._authorName);

  String get authorName => _authorName;

  String get photoUrl => _photoUrl;

  String get id => _id;

  @override
  String toString() {
    return 'PhotoModel{_id: $_id, _photoUrl: $_photoUrl, _authorName: $_authorName}';
  }
}
