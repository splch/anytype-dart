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

/// Displays all objects in the current space.
class ObjectListPage extends StatelessWidget {
  const ObjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final objects = appState.objects;

    return Scaffold(
      appBar: AppBar(
        title: Text(appState.currentSpace?.name ?? 'anytype-dart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New page',
            onPressed: () => _createObject(context, appState),
          ),
        ],
      ),
      body: objects.isEmpty
          ? _EmptyState(onCreatePressed: () => _createObject(context, appState))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: objects.length,
              itemBuilder: (context, index) {
                return _ObjectTile(
                  object: objects[index],
                  onTap: () => appState.selectObject(objects[index].id),
                  onDelete: () => appState.deleteObject(objects[index].id),
                );
              },
            ),
      floatingActionButton: objects.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _createObject(context, appState),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Future<void> _createObject(BuildContext context, AppState appState) async {
    final obj = await appState.createObject();
    appState.selectObject(obj.id);
  }
}

class _ObjectTile extends StatelessWidget {
  final AnyObject object;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ObjectTile({
    required this.object,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final name = object.name.isNotEmpty ? object.name : 'Untitled';
    final emoji = object.iconEmoji;
    final blockCount = object.blocks.length - 1; // exclude root

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Text(
          emoji.isNotEmpty ? emoji : name[0].toUpperCase(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
      title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('$blockCount blocks'),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, size: 20),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreatePressed;
  const _EmptyState({required this.onCreatePressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.article_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No objects yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first page to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onCreatePressed,
            icon: const Icon(Icons.add),
            label: const Text('New page'),
          ),
        ],
      ),
    );
  }
}
