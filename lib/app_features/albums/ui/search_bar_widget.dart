import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movie_app/common_widgets/app_text.dart';
import 'package:my_movie_app/constants/string_constants.dart';


class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String, {bool isSubmitted}) onSearchChanged;
  final RxList<String> recentSearches;

  SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearchChanged,
    required this.recentSearches,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            // Filter live but don't add to recent
            onSearchChanged(value, isSubmitted: false);
          },
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              // Add to recent and filter
              onSearchChanged(value, isSubmitted: true);
            }
          },
          decoration: InputDecoration(
            hintText: StringConstants.searchAlbumsHint,
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
        ),
        Obx(() {
          if (recentSearches.isEmpty) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: recentSearches.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final search = recentSearches[index];
                  return ActionChip(
                    label: AppText(
                      text: search,
                      appTextOptions: const AppTextOptions(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      controller.text = search;
                      onSearchChanged(search, isSubmitted: true);
                    },
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }
}
