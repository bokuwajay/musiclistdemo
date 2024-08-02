import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_bloc.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_event.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_state.dart';

Widget buildSearchTextField(
    BuildContext context, ItunesState state, TextEditingController searchController, Timer? debounce, searchInCache, List<TrackEntity> displayList) {
  return Expanded(
    child: TextField(
      cursorColor: Colors.amber[400],
      controller: searchController,
      style: TextStyle(color: Colors.amber[400]),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade900,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
          hintText: "e.g: song / album name",
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(Icons.search, size: 30),
          prefixIconColor: Colors.amber[400],
          suffixIconConstraints: const BoxConstraints(minWidth: 16, minHeight: 16),
          suffixIcon: state is ItunesStateLoading
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.amber[400]),
                )
              : null),
      onChanged: (value) {
        if (debounce?.isActive ?? false) {
          debounce?.cancel();
        }

        debounce = Timer(const Duration(milliseconds: 700), () async {
          if (value.length > 2) {
            searchInCache(value);
            if (displayList.isEmpty) {
              context.read<ItunesBloc>().add(ItunesEventSearch(term: value));
            }
          }
        });
      },
      enabled: state is! ItunesStateLoading,
    ),
  );
}
