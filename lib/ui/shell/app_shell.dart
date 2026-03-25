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

import '../editor/editor_page.dart';
import '../search/search_page.dart';
import '../settings/settings_page.dart';
import '../views/object_list.dart';
import 'app_state.dart';

/// Adaptive app shell — sidebar on wide screens, bottom nav on narrow.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
    NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
  ];

  static const _railDestinations = [
    NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
    NavigationRailDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: Text('Search')),
    NavigationRailDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: Text('Settings')),
  ];

  Widget _buildPage(int index) {
    return switch (index) {
      0 => const ObjectListPage(),
      1 => const SearchPage(),
      2 => const SettingsPage(),
      _ => const ObjectListPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isWide = MediaQuery.sizeOf(context).width >= 800;
    final selectedObject = appState.selectedObject;

    // If an object is selected, show the editor
    if (selectedObject != null) {
      return EditorPage(objectId: selectedObject.id);
    }

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              labelType: NavigationRailLabelType.all,
              leading: _SpaceBadge(name: appState.currentSpace?.name ?? ''),
              destinations: _railDestinations,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: _buildPage(_selectedIndex)),
          ],
        ),
      );
    }

    return Scaffold(
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: _destinations,
      ),
    );
  }
}

class _SpaceBadge extends StatelessWidget {
  final String name;
  const _SpaceBadge({required this.name});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'S';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(initial, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
