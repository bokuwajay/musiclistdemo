import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/iTunes_bloc.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/iTunes_event.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/iTunes_state.dart';
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
      return track.trackName!.toLowerCase().contains(lowerQuery) ||
          track.collectionName!.toLowerCase().contains(lowerQuery);
    }).toList();

    filteredList.sort(
      (a, b) {
        if (sortBy == 'trackName') {
          return a.trackName!
              .toLowerCase()
              .compareTo(b.trackName!.toLowerCase());
        }
        return a.collectionName!
            .toLowerCase()
            .compareTo(b.collectionName!.toLowerCase());
      },
    );

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
          backgroundColor: const Color(0xFF1f1545),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1f1545),
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search for Music',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xff302360),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            hintText: "e.g: Taylor Swift",
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.white,
                            suffixIconConstraints: const BoxConstraints(
                                minWidth: 16, minHeight: 16),
                            suffixIcon: state is ItunesStateLoading
                                ? const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      color: Colors.white,
                                    ),
                                  )
                                : null),
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) {
                            _debounce?.cancel();
                          }

                          _debounce = Timer(const Duration(milliseconds: 700),
                              () async {
                            if (value.length > 2) {
                              _searchInCache(value);

                              if (displayList.isEmpty) {
                                context
                                    .read<ItunesBloc>()
                                    .add(ItunesEventSearch(term: value));
                              }
                            }
                          });
                        },
                        enabled: state is! ItunesStateLoading,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sort By',
                            style: TextStyle(color: Colors.white)),
                        IconButton(
                          icon: Icon(
                            size: 40,
                            sortBy == 'trackName'
                                ? Icons.switch_right
                                : Icons.switch_left,
                            color: Colors.white,
                          ),
                          onPressed: displayList.isEmpty ? null : _toggleSort,
                        ),
                        Text(sortBy == 'trackName' ? 'Song' : 'Album',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: state is ItunesStateSearchSuccessful &&
                          displayList.isEmpty
                      ? const Center(
                          child: Text(
                            'No results found',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white70),
                          ),
                        )
                      : NotificationListener(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent &&
                                displayList.length < cacheList.length) {
                              _loadMoreItems();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemCount: displayList.length,
                            itemBuilder: (context, index) => ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              leading: Image.network(displayList[index].image!),
                              title: Text(
                                displayList[index].trackName!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Album: ${displayList[index].collectionName!}',
                                style: const TextStyle(color: Colors.white60),
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
