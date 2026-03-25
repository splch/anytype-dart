// This file is part of anytype-dart.
//
// anytype-dart is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// anytype-dart is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with anytype-dart.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src/model/any_object.dart';
import '../shell/app_state.dart';

/// Global search page.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';

  List<AnyObject> _filter(List<AnyObject> objects) {
    if (_query.isEmpty) return objects;
    final q = _query.toLowerCase();
    return objects.where((obj) {
      final name = obj.name.toLowerCase();
      if (name.contains(q)) return true;
      // Search in text block content
      for (final block in obj.blocks.values) {
        if (block.textContent != null &&
            block.textContent!.text.toLowerCase().contains(q)) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final results = _filter(appState.objects);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search objects...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Text(
                      _query.isEmpty ? 'Type to search' : 'No results',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final obj = results[index];
                      return ListTile(
                        title: Text(obj.name.isNotEmpty ? obj.name : 'Untitled'),
                        onTap: () => appState.selectObject(obj.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
