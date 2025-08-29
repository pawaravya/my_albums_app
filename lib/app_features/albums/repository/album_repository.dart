import '../../../api_manager/network_api_services.dart';

class AlbumRepository {
  AlbumRepository._internal();
  static final AlbumRepository _instance = AlbumRepository._internal();
  static AlbumRepository getInstance() => _instance;
  Future<dynamic> getAlbumList(String url) async {
    return await NetworkApiServices.getInstance().generateGetApiResponse(url);
  }
}
