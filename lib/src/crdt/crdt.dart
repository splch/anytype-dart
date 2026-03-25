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

/// CRDT engine for the any-sync protocol.
///
/// Provides the Merkle DAG change tree, deterministic merge,
/// change building/signing, and object tree management.
library;

export 'change.dart';
export 'change_builder.dart' show ChangeBuilder, ChangeContent, RootChangeContent, RawChange;
export 'lexid.dart';
export 'object_tree.dart';
export 'tree.dart';
