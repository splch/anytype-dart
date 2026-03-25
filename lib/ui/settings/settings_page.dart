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

import '../shell/app_state.dart';

/// Settings page showing account info, sync status, and storage usage.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final accountId = appState.signingKey?.publicKey.account ?? 'Not set';
    final objectCount = appState.objects.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Account'),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Account ID'),
            subtitle: Text(
              accountId,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          const Divider(),
          const _SectionHeader('Space'),
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Space'),
            subtitle: Text(appState.currentSpace?.name ?? 'None'),
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text('Objects'),
            subtitle: Text('$objectCount'),
          ),
          const Divider(),
          const _SectionHeader('Sync'),
          const ListTile(
            leading: Icon(Icons.cloud_off_outlined),
            title: Text('Sync Status'),
            subtitle: Text('Offline (local only)'),
          ),
          const Divider(),
          const _SectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('anytype-dart'),
            subtitle: Text('v0.1.0 - GPL-3.0'),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('Protocol'),
            subtitle: Text('any-sync (MIT licensed)'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
