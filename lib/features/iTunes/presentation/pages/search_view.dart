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
  List<TrackEntity> playList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItunesBloc, ItunesState>(
      listener: (context, state) {
        if (state is ItunesStateFailed) {
          showErrorDialog(context, state.message);
        }
        if (state is ItunesStateSearchSuccessful) {
          playList = state.data ?? [];
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
                TextField(
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
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 16, minHeight: 16),
                      suffixIcon: state is ItunesStateLoading
                          ? const CircularProgressIndicator()
                          : null),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) {
                      _debounce?.cancel();
                    }

                    _debounce =
                        Timer(const Duration(milliseconds: 700), () async {
                      if (value.length > 2) {
                        context
                            .read<ItunesBloc>()
                            .add(ItunesEventSearch(term: value));
                      }
                    });
                  },
                  enabled: state is! ItunesStateLoading,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: state is ItunesStateSearchSuccessful &&
                          playList.isEmpty
                      ? const Center(
                          child: Text(
                            'No results found',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white70),
                          ),
                        )
                      : ListView.builder(
                          itemCount: playList.length,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            leading: Image.network(playList[index].image!),
                            title: Text(
                              playList[index].trackName!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Album: ${playList[index].collectionName!}',
                              style: const TextStyle(color: Colors.white60),
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
