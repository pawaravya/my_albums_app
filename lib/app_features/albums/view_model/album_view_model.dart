import 'package:get/get.dart';
import 'package:my_movie_app/api_manager/app_url.dart';
import 'package:my_movie_app/constants/string_constants.dart';
import '../models/album_list_model.dart';
import '../repository/album_repository.dart';

class AlbumViewModel extends GetxController {
  var isLoading = false.obs;
  var albumList = <Album>[].obs;
  var filteredList = <Album>[].obs;
  var recentSearches = <String>[].obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAlbumList();
  }

  Future<void> getAlbumList() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      var response = await AlbumRepository.getInstance()
          .getAlbumList(AppUrl.getAlbumsUrl);

      if (response != null && response is List) {
        List<Album> tempAlbumList =
            response.map((item) => Album.fromJson(item)).toList();
        albumList.assignAll(tempAlbumList);
        filteredList.assignAll(tempAlbumList);
      } else {
        albumList.clear();
        filteredList.clear();
        errorMessage.value = StringConstants.noAlbumsFound;
      }
    } catch (e) {
      albumList.clear();
      filteredList.clear();
      errorMessage.value = StringConstants.failedToFetchAlbums;
    } finally {
      isLoading.value = false;
    }
  }

  void searchAlbums(String query, {bool isSubmitted = false}) {
    if (isSubmitted && query.isNotEmpty) {
      // Only add to recent on search button press
      if (!recentSearches.contains(query)) {
        recentSearches.insert(0, query);
        if (recentSearches.length > 5) recentSearches.removeLast();
      }
    }

    if (query.isEmpty) {
      filteredList.assignAll(albumList);
    } else {
      var results = albumList
          .where((album) =>
              (album.title ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredList.assignAll(results);
    }
  }
}
