import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_bloc.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_state.dart';
import 'package:keysoctest/features/iTunes/presentation/widgets/build_search_result_list.dart';
import 'package:keysoctest/features/iTunes/presentation/widgets/build_search_text_field.dart';
import 'package:keysoctest/util/dialogs/error_dialog.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();
  List<TrackEntity> displayList = [];
  List<TrackEntity> cacheList = [];
  int currentPage = 0;
  final int itemsPerPage = 10;
  String sortBy = 'trackName';

  void _loadMoreItems() {
    setState(() {
      int nextPage = currentPage + 1;
      int startIndex = currentPage * itemsPerPage;
      int endIndex = nextPage * itemsPerPage;
      if (endIndex > cacheList.length) {
        endIndex = cacheList.length;
      }
      displayList.addAll(cacheList.sublist(startIndex, endIndex));
      currentPage = nextPage;
    });
  }

  void _searchInCache(String query) {
    final lowerQuery = query.toLowerCase();
    final filteredList = cacheList.where((track) {
      return track.trackName!.toLowerCase().contains(lowerQuery) || track.collectionName!.toLowerCase().contains(lowerQuery);
    }).toList();

    filteredList.sort((a, b) {
      if (sortBy == 'trackName') {
        return a.trackName!.toLowerCase().compareTo(b.trackName!.toLowerCase());
      }
      return a.collectionName!.toLowerCase().compareTo(b.collectionName!.toLowerCase());
    });

    setState(() {
      displayList = filteredList.take(itemsPerPage).toList();
      currentPage = 1;
    });
  }

  void _toggleSort() {
    setState(() {
      sortBy = sortBy == 'trackName' ? 'collectionName' : 'trackName';
      _searchInCache(_searchController.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItunesBloc, ItunesState>(
      listener: (context, state) {
        if (state is ItunesStateFailed) {
          showErrorDialog(context, state.message);
        }
        if (state is ItunesStateSearchSuccessful) {
          cacheList = state.data ?? [];
          displayList = cacheList.take(itemsPerPage).toList();
          currentPage = 1;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Search for Music',
              style: TextStyle(color: Colors.amber[400], fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    buildSearchTextField(context, state, _searchController, _debounce, _searchInCache, displayList),
                    const SizedBox(width: 8.0),
                    IconButton(
                        icon: Icon(
                          size: 40,
                          sortBy == 'trackName' ? Icons.switch_right : Icons.switch_left,
                          color: Colors.amber[400],
                        ),
                        onPressed: displayList.isEmpty ? null : _toggleSort)
                  ],
                ),
                const SizedBox(height: 20.0),
                buildSearchResultList(context, state, displayList, cacheList, _loadMoreItems)
              ],
            ),
          ),
        );
      },
    );
  }
}
