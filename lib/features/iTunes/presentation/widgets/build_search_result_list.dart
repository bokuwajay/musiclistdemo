import 'package:flutter/material.dart';
import 'package:keysoctest/features/iTunes/domain/entities/track_entity.dart';
import 'package:keysoctest/features/iTunes/presentation/bloc/itunes_state.dart';

Widget buildSearchResultList(ItunesState state, List<TrackEntity> displayList, List<TrackEntity> cacheList, loadMoreItems) {
  return Expanded(
    key: const Key('song list'),
    child: state is ItunesStateSearchSuccessful && displayList.isEmpty
        ? const Center(
            child: Text(
              'No results found',
              style: TextStyle(fontSize: 30, color: Colors.white70),
            ),
          )
        : NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && displayList.length < cacheList.length) {
                loadMoreItems();
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
                  style: TextStyle(color: Colors.amber[400], fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Album: ${displayList[index].collectionName!}',
                  style: const TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),
  );
}
