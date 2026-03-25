# anytype-dart

A cross-platform Flutter client fully compatible with the [Anytype](https://anytype.io) network. Reimplements all middleware from scratch in Dart, depending **only** on MIT-licensed [any-sync](https://github.com/anyproto/any-sync) protocol code.

> **Status:** Prototype — middleware complete, UI scaffold functional, not yet connected to live network nodes.

## Architecture

```
┌─────────────────────────────────────┐
│           Flutter UI Layer          │
│  Material 3, adaptive per platform  │
├─────────────────────────────────────┤
│         anytype-dart Middleware          │
│  ┌───────────┐  ┌────────────────┐  │
│  │  Object   │  │ Block Editor   │  │
│  │  Model    │  │ Engine         │  │
│  ├───────────┤  ├────────────────┤  │
│  │ CRDT /    │  │ Space & ACL    │  │
│  │ Change    │  │ Manager        │  │
│  │ Engine    │  │                │  │
│  ├───────────┤  ├────────────────┤  │
│  │ Crypto    │  │ File Manager   │  │
│  │ Layer     │  │                │  │
│  ├───────────┤  ├────────────────┤  │
│  │ any-sync  │  │ Local Storage  │  │
│  │ Protocol  │  │ (In-Memory)    │  │
│  └───────────┘  └────────────────┘  │
├─────────────────────────────────────┤
│    Network (P2P + Sync Nodes)       │
└─────────────────────────────────────┘
```

## What's Implemented

### Crypto Layer (`lib/src/crypto/`)

| Module | Description |
|--------|-------------|
| **SLIP-10** | Ed25519 hierarchical deterministic key derivation. Verified against official test vectors. |
| **SLIP-21** | Symmetric key derivation with label-based paths for per-space and per-object encryption keys. |
| **Ed25519** | Signing, verification, and protobuf-compatible marshaling. Account/Network string encoding with Base58 + CRC-16 XMODEM. |
| **AES-256-GCM** | Authenticated encryption matching the any-sync wire format (nonce \|\| ciphertext \|\| tag). |
| **CID** | IPFS-compatible Content Identifiers (CID v1, DagCBOR, SHA-256) for content addressing. |
| **Account** | BIP-39 mnemonic generation, seed derivation, and the full Anytype key hierarchy (`m/44'/2046'/index'`). |

### CRDT Engine (`lib/src/crdt/`)

| Module | Description |
|--------|-------------|
| **LexId** | Dense lexicographic ID generation for deterministic change ordering across peers. |
| **Change** | Merkle DAG node with all protocol fields (CID, parents, snapshot, signature, identity, ACL head). |
| **Tree** | DAG with attached/unattached tracking, waitlist-based dependency resolution, topological sort, and OrderId assignment. |
| **ChangeBuilder** | Builds, signs (Ed25519), optionally encrypts (AES-GCM), and verifies changes with CID computation. |
| **ObjectTree** | High-level API: initialize, addContent, addRawChanges from peers, snapshot paths, tree reduction. |

### Object Model (`lib/src/model/`)

| Module | Description |
|--------|-------------|
| **Block** | 10 block types (text, file, link, bookmark, divider, relation, layout, table, tableRow/Column, widget) with serialization. |
| **TextContent** | Rich text with marks (bold, italic, strikethrough, link, mention, color) and styles (paragraph, headings, lists, quote, code). |
| **Relation** | 14 relation formats (text, number, date, select, multiSelect, checkbox, url, object, file, etc.). |
| **ObjectType** | Type schemas with recommended relations and default layouts. Built-in system types (Page, Note, Task, Bookmark, Collection). |
| **AnyObject** | Top-level container with block tree, relations, add/remove/move operations, and full serialization. |
| **Space** | Collection of objects, types, and relation definitions sharing ACL and encryption scope. |

### Block Editor Engine (`lib/src/editor/`)

| Module | Description |
|--------|-------------|
| **Operations** | 12 operation types (AddBlock, RemoveBlock, MoveBlock, SetText, SetStyle, SetMarks, SetChecked, SetRelation, etc.) with JSON serialization. |
| **BlockEditor** | Applies operations to AnyObject and commits CRDT changes to ObjectTree. Includes `replay()` for rebuilding state from change history. |

### Storage (`lib/src/storage/`)

| Module | Description |
|--------|-------------|
| **Interfaces** | Abstract `ObjectStore`, `ChangeStore`, `SyncStateStore`, `FileStore`, and unified `StorageService`. |
| **In-Memory** | Complete `MemoryStorageService` implementation with monotonic sequence assignment and OrderId range queries. |

### ACL (`lib/src/acl/`)

| Module | Description |
|--------|-------------|
| **Permissions** | Owner / Admin / Writer / Reader / Guest / None with capability checks (canWrite, canRead, canAdmin). |
| **AclState** | Full state machine: root creation, invite/accept flows, anyone-can-join, account removal, permission changes, read key rotation, ownership transfer, change validation. |

### Sync (`lib/src/sync/`)

| Module | Description |
|--------|-------------|
| **SyncStateMachine** | 8 states (disconnected → connecting → handshake → syncing → idle → receiving/sending → reconnecting). |
| **SyncClient** | Handles HeadUpdate, FullSyncRequest/Response, space subscriptions, peer management. Abstract `SyncTransport` for plugging in gRPC/WebSocket/P2P. |
| **ConflictDetector** | Detects divergent heads — classifies as soft (same identity) or hard (different identities) conflicts. |
| **SyncOrchestrator** | Ties storage, CRDT trees, and sync client together. Persists changes offline-first, queues for background sync, emits conflict events. |

### Persistent Storage (`lib/src/storage/sqlite_storage.dart`)

| Module | Description |
|--------|-------------|
| **SqliteStorageService** | Full SQLite implementation of all storage interfaces. WAL mode, indexed queries (OrderId range scans, addSeq filtering), object index for fast search. |
| **ObjectIndex** | Lightweight index table for object metadata (name, type, icon, favorite, archive) — enables fast list/search without loading full snapshots. |

### Flutter UI (`lib/ui/`)

| Module | Description |
|--------|-------------|
| **AppShell** | Adaptive navigation: sidebar on desktop (800px+), bottom nav on mobile. Space badge. |
| **EditorPage** | Block-based page editor with swipe-to-delete, slash command menu (10 block types), title editing. |
| **BlockWidget** | Renders text (paragraph, headings, lists, checkboxes, quotes, code), dividers, files, links, bookmarks. |
| **ObjectList** | Object grid with empty state, create button, delete. |
| **SearchPage** | Full-text search across object names and text content. |
| **SettingsPage** | Account ID, space info, sync status, version. |
| **ConflictBanner** | Material banner for divergent edits with severity indicators. |
| **SyncStatusIndicator** | Compact icon showing online/offline/syncing/pending state. |

### Platform Support

Generated platform scaffolds for Android, iOS, Linux, macOS, and Windows via `flutter create`.

## Tests

190 tests across all modules:

```
Crypto (SLIP-10, SLIP-21, Ed25519, AES-GCM, CID) ........ 49
CRDT (LexId, Tree, ChangeBuilder, ObjectTree) ............ 41
Model & Editor (Block, Object, Space, Operations) ........ 26
Storage — In-Memory (all interfaces) ...................... 21
Storage — SQLite (full CRUD, indexing, dedup) ............. 20
ACL (Permissions, AclState, invite flows) ................. 16
Sync (StateMachine, SyncClient) ........................... 12
Conflict Detection (soft/hard, checkAll, resolution) ...... 5
```

Run them:

```bash
flutter test
```

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── src/
│   ├── crypto/                # SLIP-10/21, Ed25519, AES-GCM, CID, account keys
│   ├── crdt/                  # Change DAG, merge, LexId ordering, ObjectTree
│   ├── model/                 # Block types, relations, object types, spaces
│   ├── editor/                # Block operations, BlockEditor engine
│   ├── storage/               # Storage interfaces + in-memory implementation
│   ├── acl/                   # ACL state machine, permissions
│   ├── sync/                  # Sync state machine, sync client
│   └── proto/                 # Generated protobuf bindings
├── ui/
│   ├── shell/                 # App scaffold, navigation, state management
│   ├── editor/                # Block editor widgets, slash menu
│   ├── views/                 # Object list
│   ├── search/                # Global search
│   └── settings/              # Settings screen
test/
├── slip10_test.dart           # SLIP-10 test vectors (both vector sets)
├── slip21_test.dart           # SLIP-21 test vectors
├── keys_test.dart             # Ed25519 sign/verify, marshaling
├── aes_gcm_test.dart          # AES-GCM roundtrip, tampering, edge cases
├── cid_test.dart              # CID format, verification, SHA-256
├── lexid_test.dart            # Ordering properties, insertions
├── change_tree_test.dart      # Tree ops, forks, merges, dependency resolution
├── model_test.dart            # Blocks, objects, editor operations
├── storage_test.dart          # All storage interface tests
├── acl_test.dart              # Permission enforcement, invite flows
└── sync_test.dart             # State machine, sync client
docs/
└── protocol-notes.md          # Comprehensive any-sync protocol analysis
```

## Legal

### License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

### Protocol Compliance

All code is written from scratch in Dart, guided solely by the MIT-licensed any-sync protocol specifications:

- [any-sync](https://github.com/anyproto/any-sync) — core protocol, CRDT tree, change structures (MIT)
- [any-sync-node](https://github.com/anyproto/any-sync-node) — sync node reference (MIT)
- [any-sync-filenode](https://github.com/anyproto/any-sync-filenode) — file storage protocol (MIT)
- [any-sync-consensusnode](https://github.com/anyproto/any-sync-consensusnode) — ACL validation (MIT)
- [any-sync-coordinator](https://github.com/anyproto/any-sync-coordinator) — network coordination (MIT)
- [go-slip10](https://github.com/anyproto/go-slip10) — SLIP-10 key derivation (MIT)
- [go-slip21](https://github.com/anyproto/go-slip21) — SLIP-21 key derivation (MIT)

**No code** from `anytype-heart`, `anytype-ts`, `anytype-kotlin`, or `anytype-swift` (Any Source Available License 1.0) has been read, copied, referenced, or reverse-engineered.

## Dependencies

| Package | Purpose |
|---------|---------|
| `pointycastle` | HMAC-SHA512, SHA-256 (synchronous) |
| `cryptography` | Ed25519, AES-GCM, X25519 |
| `bip39` | Mnemonic generation and seed derivation |
| `protobuf` | Protocol buffer runtime (for generated proto bindings) |
| `grpc` | gRPC client (for future sync node communication) |
| `drift` | SQLite ORM (for future persistent storage) |
| `provider` | State management |
| `uuid` | Block ID generation |
