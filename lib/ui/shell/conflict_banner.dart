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

import '../../src/sync/conflict.dart';

/// Banner displayed when an object has divergent edits.
class ConflictBanner extends StatelessWidget {
  final ConflictInfo conflict;
  final VoidCallback? onResolve;

  const ConflictBanner({super.key, required this.conflict, this.onResolve});

  @override
  Widget build(BuildContext context) {
    final isHard = conflict.severity == ConflictSeverity.hard;
    final color = isHard
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.tertiary;

    return MaterialBanner(
      backgroundColor: color.withValues(alpha: 0.1),
      leading: Icon(
        isHard ? Icons.warning_amber : Icons.merge_type,
        color: color,
      ),
      content: Text(
        isHard
            ? '${conflict.heads.length} divergent edits from different users'
            : '${conflict.heads.length} concurrent edits (auto-mergeable)',
        style: TextStyle(color: color),
      ),
      actions: [
        if (onResolve != null)
          TextButton(
            onPressed: onResolve,
            child: const Text('Review'),
          ),
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          child: const Text('Dismiss'),
        ),
      ],
    );
  }
}

/// Small conflict indicator icon for object list tiles.
class ConflictIndicator extends StatelessWidget {
  final ConflictSeverity severity;

  const ConflictIndicator({super.key, required this.severity});

  @override
  Widget build(BuildContext context) {
    if (severity == ConflictSeverity.none) return const SizedBox.shrink();

    final isHard = severity == ConflictSeverity.hard;
    return Tooltip(
      message: isHard ? 'Conflicting edits' : 'Concurrent edits',
      child: Icon(
        isHard ? Icons.warning_amber : Icons.merge_type,
        size: 16,
        color: isHard
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

/// Sync status indicator for the app bar.
class SyncStatusIndicator extends StatelessWidget {
  final bool isOnline;
  final bool isSyncing;
  final int pendingCount;

  const SyncStatusIndicator({
    super.key,
    this.isOnline = false,
    this.isSyncing = false,
    this.pendingCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = isOnline
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;

    IconData icon;
    String tooltip;

    if (isSyncing) {
      icon = Icons.sync;
      tooltip = 'Syncing...';
    } else if (isOnline && pendingCount == 0) {
      icon = Icons.cloud_done_outlined;
      tooltip = 'Up to date';
    } else if (isOnline && pendingCount > 0) {
      icon = Icons.cloud_upload_outlined;
      tooltip = '$pendingCount changes pending';
    } else {
      icon = Icons.cloud_off_outlined;
      tooltip = 'Offline';
    }

    return Tooltip(
      message: tooltip,
      child: Icon(icon, size: 20, color: color),
    );
  }
}
