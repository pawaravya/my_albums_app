import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_movie_app/app_features/albums/ui/album_shimmer_item.dart';
import 'package:my_movie_app/app_features/albums/ui/search_bar_widget.dart';
import 'package:my_movie_app/common_widgets/app_text.dart';
import 'package:my_movie_app/common_widgets/base_screen.dart';
import 'package:my_movie_app/constants/string_constants.dart';
import '../view_model/album_view_model.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  final AlbumViewModel _albumViewModel = Get.put(AlbumViewModel());
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAlbumList();
  }

  Future<void> fetchAlbumList() async {
    await _albumViewModel.getAlbumList();
  }

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    final shouldExit =
        await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: AppText(
              text: StringConstants.exitAppTitle,
              appTextOptions: const AppTextOptions(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            content: AppText(
              text: StringConstants.exitAppMessage,
              appTextOptions: const AppTextOptions(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: AppText(
                  text: StringConstants.no,
                  appTextOptions: const AppTextOptions(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                child: AppText(
                  text: StringConstants.yes,
                  appTextOptions: const AppTextOptions(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;

    return shouldExit;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onBackPressed: () => showExitConfirmationDialog(context),
      screen: Obx(() {
        if (_albumViewModel.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) => const AlbumShimmerItem(),
            ),
          );
        }

        if (_albumViewModel.albumList.isEmpty) {
          return Center(
            child: AppText(
              text: StringConstants.noAlbumsFound,
              appTextOptions: const AppTextOptions(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onSearchChanged: _albumViewModel.searchAlbums,
              recentSearches: _albumViewModel.recentSearches,
            ),
            Expanded(
              child: Obx(() {
                if (_albumViewModel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_albumViewModel.filteredList.isEmpty) {
                  return Center(
                    child: AppText(
                      text: StringConstants.noAlbumsFound,
                      appTextOptions: const AppTextOptions(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _albumViewModel.filteredList.length,
                  itemBuilder: (context, index) {
                    final album = _albumViewModel.filteredList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: album.thumbnailUrl ?? "",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        title: AppText(
                          text: album.title ?? "",
                          appTextOptions: const AppTextOptions(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: AppText(
                          text:
                              "${StringConstants.albumIdLabel} ${album.albumId}",
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
