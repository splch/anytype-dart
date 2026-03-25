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

import 'src/crypto/account.dart';
import 'ui/shell/app_shell.dart';
import 'ui/shell/app_state.dart';

void main() {
  runApp(const AnytypeDartApp());
}

class AnytypeDartApp extends StatelessWidget {
  const AnytypeDartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'anytype-dart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF6750A4),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xFF6750A4),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const _InitializerScreen(),
      ),
    );
  }
}

/// Initializes the app with a signing key, then shows the shell.
///
/// On first launch, generates a new mnemonic and derives keys.
/// In a production app, this would show an onboarding flow
/// with mnemonic backup.
class _InitializerScreen extends StatefulWidget {
  const _InitializerScreen();

  @override
  State<_InitializerScreen> createState() => _InitializerScreenState();
}

class _InitializerScreenState extends State<_InitializerScreen> {
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final appState = context.read<AppState>();

      // Generate a temporary account (in production, this would be
      // persisted and the mnemonic shown for backup)
      final mnemonic = generateMnemonic();
      final account = await AccountKeys.fromMnemonic(mnemonic);

      await appState.initialize(account.identityKey);

      if (mounted) setState(() => _loading = false);
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: $_error', style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return const AppShell();
  }
}
