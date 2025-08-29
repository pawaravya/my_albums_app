class AppUrl {
  static final String _BASEURL = "https://jsonplaceholder.typicode.com";

  static String _getEndpointUrlWithBaseUrl(String endpoint) {
    return _BASEURL + "/$endpoint";
  }

  static String getAlbumsUrl = _getEndpointUrlWithBaseUrl("photos");
}
