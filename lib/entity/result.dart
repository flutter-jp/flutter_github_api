class OauthResult<T> {
  int code;
  String message;
  T data;

  OauthResult({this.code, this.message, this.data});
}
