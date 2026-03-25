# any-sync Protocol Analysis

Comprehensive analysis of the MIT-licensed any-sync protocol, derived from studying
the reference Go implementations.

---

## 1. Protobuf Message Types

### 1.1 Handshake Protocol

**File:** `any-sync/net/secureservice/handshake/handshakeproto/protos/handshake.proto`

The handshake establishes authenticated, optionally compressed connections between peers.

| Message | Fields | Purpose |
|---------|--------|---------|
| `Credentials` | type (CredentialsType), payload (bytes), version (uint32), clientVersion (string) | Identity exchange |
| `PayloadSignedPeerIds` | identity (bytes), sign (bytes) | Signature of localPeerId + remotePeerId |
| `Ack` | error (Error enum) | Handshake confirmation |
| `Proto` | proto (ProtoType), encodings (repeated Encoding) | Protocol/encoding negotiation |

**Enums:**
- `CredentialsType`: SkipVerify (0), SignedPeerIds (1)
- `Error`: Null (0), Unexpected (1), InvalidCredentials (2), UnexpectedPayload (3), SkipVerifyNotAllowed (4), DeadlineExceeded (5), IncompatibleVersion (6), IncompatibleProto (7)
- `ProtoType`: DRPC (0)
- `Encoding`: None (0), Snappy (1)

### 1.2 Tree Change Protocol

**File:** `any-sync/commonspace/object/tree/treechangeproto/protos/treechange.proto`

Core CRDT messages for the Merkle DAG of changes.

| Message | Key Fields | Purpose |
|---------|-----------|---------|
| `RootChange` | aclHeadId, spaceId, changeType, timestamp, seed, identity, changePayload, isDerived, parentId | Initial tree snapshot |
| `TreeChange` | treeHeadIds (parents), aclHeadId, snapshotBaseId, changesData, readKeyId, timestamp, identity, isSnapshot, dataType | Regular change in DAG |
| `RawTreeChange` | payload (bytes), signature (bytes) | Signed change wrapper |
| `RawTreeChangeWithId` | rawChange (bytes), id (string/CID) | Network-serialized change |
| `TreeSyncMessage` | content (oneof: headUpdate, fullSyncRequest, fullSyncResponse, errorResponse), rootChange | Sync envelope |
| `TreeHeadUpdate` | heads[], changes[], snapshotPath[] | Incremental sync |
| `TreeFullSyncRequest` | heads[], changes[], snapshotPath[] | Full state request |
| `TreeFullSyncResponse` | heads[], changes[], snapshotPath[] | Full state response |

### 1.3 Space Sync Protocol

**File:** `any-sync/commonspace/spacesyncproto/protos/spacesync.proto`

Top-level space synchronization.

| Message | Key Fields | Purpose |
|---------|-----------|---------|
| `HeadSyncRequest` | spaceId, ranges[], diffType | Hash-range consistency check |
| `HeadSyncResponse` | results[], diffType | Diff results |
| `HeadSyncRange` | from, to, limit, elements | Range query parameters |
| `HeadSyncResult` | hash (bytes), elements[], count | Hash + element list |
| `ObjectSyncMessage` | spaceId, requestId, replyId, payload, objectId, objectType | Object-level sync envelope |
| `SpacePushRequest` | payload (SpacePayload), Credential (bytes) | Push new space to node |
| `SpacePullRequest/Response` | id / payload, aclRecords[] | Pull space from node |
| `SpaceHeader` | identity, timestamp, spaceType, replicationKey, seed, spaceHeaderPayload, aclPayload, settingPayload, version | Space creation header |
| `StoreKeyValue` | keyPeerId, value, identitySignature, peerSignature, spaceId | Key-value store entry |
| `SpaceSubscription` | spaceIds[], action (Subscribe/Unsubscribe) | Subscribe to space updates |

**ObjectType enum:** Tree (0), Acl (1), KeyValue (2)

**SpaceSync Service RPCs:**
- `HeadSync` — hash-based diff
- `StoreDiff` — key-value store diff
- `StoreElements` — bidirectional stream for KV sync
- `SpacePush` / `SpacePull` — space creation/retrieval
- `ObjectSyncStream` — bidirectional object sync (primary)
- `ObjectSync` — single message sync (deprecated)
- `ObjectSyncRequestStream` — request with streaming response

### 1.4 ACL Record Protocol

**File:** `any-sync/commonspace/object/acl/aclrecordproto/protos/aclrecord.proto`

| Message | Key Fields | Purpose |
|---------|-----------|---------|
| `AclRoot` | identity, masterKey, spaceId, encryptedReadKey, timestamp, identitySignature, metadataPubKey, encryptedMetadataPrivKey, encryptedOwnerMetadata, options | Space ACL root record |
| `AclAccountInvite` | inviteKey, inviteType, permissions, encryptedReadKey | Invite creation |
| `AclAccountInviteJoin` | identity, inviteRecordId, inviteIdentitySignature, metadata, encryptedReadKey, permissions | Direct join via invite |
| `AclAccountRequestJoin` | inviteIdentity, inviteRecordId, inviteIdentitySignature, metadata | Join request |
| `AclAccountRequestAccept` | identity, requestRecordId, encryptedReadKey, permissions | Accept join request |
| `AclAccountRemove` | identities[], readKeyChange | Remove users + rotate key |
| `AclReadKeyChange` | accountKeys[], metadataPubKey, encryptedMetadataPrivKey, encryptedOldReadKey, inviteKeys[] | Read key rotation |
| `AclOwnershipChange` | newOwnerIdentity, oldOwnerPermissions | Transfer ownership |
| `AclContentValue` | oneof: 16 ACL operation types | Polymorphic ACL operation |

**AclUserPermissions:** None (0), Owner (1), Admin (2), Writer (3), Reader (4), Guest (5)
**AclInviteType:** RequestToJoin (0), AnyoneCanJoin (1)

### 1.5 Consensus Protocol

**File:** `any-sync/consensus/consensusproto/protos/consensus.proto`

| Message | Key Fields | Purpose |
|---------|-----------|---------|
| `Log` | id, records[] | Ordered log of records |
| `RawRecord` | payload, signature, acceptorIdentity, acceptorSignature, acceptorTimestamp | Dual-signed record |
| `Record` | prevId, identity, data, timestamp | Record content |
| `LogSyncMessage` | id, payload, content (oneof: headUpdate, fullSyncRequest, fullSyncResponse) | Log sync |

**Consensus Service RPCs:**
- `LogAdd` — create new log
- `RecordAdd` — append to log (returns with acceptor signature)
- `LogWatch` — bidirectional stream for live updates
- `LogDelete` — remove log

### 1.6 File Protocol

**File:** `any-sync/commonfile/fileproto/protos/file.proto`

| Message | Key Fields | Purpose |
|---------|-----------|---------|
| `BlockGetRequest/Response` | spaceId, cid, wait / cid, data | Download block by CID |
| `BlockPushRequest` | spaceId, fileId, cid, data | Upload single block |
| `BlockPushManyRequest` | fileBlocks[] (FileBlocks: fileId, spaceId, blocks[]) | Batch upload (20MB limit) |
| `BlocksCheckRequest/Response` | spaceId, cids[] / blocksAvailability[] | Check CID existence |
| `BlocksBindRequest` | spaceId, fileId, cids[] | Bind CIDs to file |
| `FilesDeleteRequest` | spaceId, fileIds[] | Delete files |
| `SpaceInfoResponse` | limitBytes, totalUsageBytes, cidsCount, filesCount | Quota info |
| `AccountInfoResponse` | limitBytes, totalUsageBytes, totalCidsCount, spaces[] | Account quota |

**AvailabilityStatus:** NotExists (0), Exists (1), ExistsInSpace (2)

### 1.7 Coordinator Protocol

**File:** `any-sync/coordinator/coordinatorproto/protos/coordinator.proto`

| Message | Key Fields | Purpose |
|---------|-----------|---------|
| `SpaceSignRequest` | spaceId, header, forceRequest | Request space receipt |
| `SpaceReceipt` | spaceId, peerId, accountIdentity, networkId, validUntil | Proof of space registration |
| `NetworkConfigurationResponse` | configurationId, networkId, nodes[] | Network topology |
| `Node` | peerId, addresses[], types[] | Node descriptor |
| `SpaceDeleteRequest` | spaceId, deletionPayloadId, deletionPayload, deletionDuration | Delete space |
| `DeletionLogRecord` | id, spaceId, status, timestamp, fileGroup, aclRecordId | Deletion audit |

**NodeType:** TreeAPI (0), FileAPI (1), CoordinatorAPI (2), ConsensusAPI (3), NamingNodeAPI (4), PaymentProcessingAPI (5)

**Coordinator Service RPCs:**
- `SpaceSign` — register space
- `SpaceStatusCheck` / `SpaceStatusCheckMany` — query status
- `SpaceMakeShareable` / `SpaceMakeUnshareable` — sharing control
- `NetworkConfiguration` — discover network nodes
- `SpaceDelete` / `AccountDelete` / `AccountRevertDeletion` — lifecycle
- `AclAddRecord` / `AclGetRecords` — ACL management
- `DeletionLog` — audit trail
- `NotifySubscribe` — live event stream

### 1.8 Other Protocols

- **IdentityRepo** (`identityrepo.proto`): DataPut/DataDelete/DataPull for identity data
- **NameService** (`nameservice.proto`): DNS-like name resolution (*.any names)
- **PaymentService** (`paymentservice.proto`, `paymentservice2.proto`): Subscription management
- **Crypto** (`crypto.proto`): Key type enum (Ed25519Public, Ed25519Private, AES)
- **ClientSpace** (`clientspace.proto`): P2P space exchange with local server discovery
- **NodeSync** (`nodesync.proto`): Inter-node partition sync and cold sync

---

## 2. Sync Handshake Sequence

### 2.1 Connection Establishment

```
Phase 1: Transport Layer
  Client ──TLS/QUIC/WebTransport──► Server
  (libp2p TLS with Ed25519 peer keys)

Phase 2: Credential Exchange
  Client ──[Credentials{type:SignedPeerIds, payload:PayloadSignedPeerIds}]──► Server
  Server ──[Credentials{type:SignedPeerIds, payload:PayloadSignedPeerIds}]──► Client
  Client ──[Ack{error:Null}]──► Server
  Server ──[Ack{error:Null}]──► Client

Phase 3: Protocol Negotiation
  Client ──[Proto{proto:DRPC, encodings:[Snappy]}]──► Server
  Server ──[Proto{proto:DRPC, encodings:[Snappy]}]──► Client
```

**PayloadSignedPeerIds** contains:
- `identity`: Account public key (Ed25519)
- `sign`: Ed25519 signature over `localPeerId || remotePeerId`

**Protocol Versions:**
- v8: ACL ownership transfer, SpaceHeader V1
- v9: Nested derived objects, delete restrictions (current default)
- Compatible set: [8, 9, 12]

### 2.2 Space Subscription

After handshake, client subscribes to spaces:

```
Client ──[SpaceSubscription{spaceIds:["space1","space2"], action:Subscribe}]──► Node
```

### 2.3 Sync Flow (Per Space)

```
1. HeadSync (consistency check)
   Client ──[HeadSyncRequest{spaceId, ranges, diffType:Initial}]──► Node
   Node   ──[HeadSyncResponse{results[hash, elements]}]──► Client

   Client compares hashes, identifies differing ranges.

2. Object Sync (bidirectional stream)
   Client ◄──[ObjectSyncStream]──► Node

   For each divergent object:
     Peer1 ──[ObjectSyncMessage{objectId, payload:TreeHeadUpdate}]──► Peer2

     If heads match: done
     If heads diverge: exchange full sync request/response

     Peer2 ──[ObjectSyncMessage{objectId, payload:TreeFullSyncResponse}]──► Peer1

3. Store Sync (key-value)
   Client ◄──[StoreElements stream]──► Node
```

### 2.4 Sync State Machine

```
DISCONNECTED → CONNECTING → HANDSHAKE → SYNCING → IDLE
                                           ↕
                                    RECEIVING / SENDING
```

**Reconnect:** Fixed 1-minute timeout after failure. No exponential backoff.

---

## 3. Change Structure (DAG)

### 3.1 Change Fields

Each change in the Merkle DAG contains:

| Field | Type | Description |
|-------|------|-------------|
| `Id` | string (CID) | Content hash of serialized RawTreeChange |
| `OrderId` | string | Lexicographic ordering ID (lexid library, 4-100 chars) |
| `PreviousIds` | []string | Parent change IDs (1+ for merges) |
| `SnapshotId` | string | Base snapshot this extends |
| `SnapshotCounter` | int | Depth in snapshot tree |
| `Timestamp` | int64 | Creation time |
| `Identity` | PubKey | Creator's Ed25519 public key |
| `AclHeadId` | string | ACL record ID at creation time |
| `ReadKeyId` | string | Encryption key reference |
| `Data` | bytes | Encrypted payload |
| `DataType` | string | Semantic type |
| `IsSnapshot` | bool | Full state snapshot flag |
| `Signature` | bytes | Ed25519 signature |

### 3.2 ID Computation

```
RawTreeChange = { payload: marshal(TreeChange), signature: Ed25519Sign(payload) }
id = CID(marshal(RawTreeChange))   // IPFS-compatible CID with SHA2-256
```

### 3.3 Merge Algorithm

The merge is a **topological sort with lexicographic tie-breaking**:

1. **DAG Construction**: Changes added to `attached` map when all parents present. Unresolved dependencies tracked in `unAttached` with wait-lists.

2. **Topological Sort** (DFS post-order):
   ```
   For each head:
     DFS traversal, push to stack
     First visit: mark visited, push again
     Second visit: add to results (after all children)
   Result: reverse topological order
   ```

3. **Lexicographic Ordering** via `lexid`:
   - Generates dense, lexicographically comparable string IDs
   - Supports `Next(prev)` and `NextBefore(prev, before)` for gap-filling
   - Config: `CharsAllNoEscape`, 4-100 character IDs
   - Deterministic: all peers produce same ordering given same DAG

4. **Determinism guarantee**: CID-based identity + topological ordering + lexicographic tie-breaking = identical results on all clients.

### 3.4 Snapshot Generation

**Trigger** (probabilistic):
```
if treeLen <= 100: no snapshot
else: random trigger around treeLen ≈ 1000
  delta = treeLen/50 + 1
  midPoint = 1000
  trigger if rand(0..2000) in [midPoint-delta, midPoint+delta]
```

**Snapshot Counter**: Each snapshot increments from its base: `parent.SnapshotCounter + 1`

**Tree Reduction** (garbage collection):
- Single head + is snapshot → make root, remove predecessors
- Multiple heads → find common snapshot across all head paths → make new root

### 3.5 Incremental Sync

Two mechanisms:
- **OrderId-based**: `GetAfterOrder(orderId)` — loads changes with OrderId > given value
- **AddSeq-based**: `GetAfterAddSeq(seq)` — per-space monotonic sequence, peers track last processed

---

## 4. ACL Record Structure and Permission Model

### 4.1 ACL Root

Created when space is initialized:
```
AclRoot {
  identity: owner Ed25519 public key
  masterKey: space master key
  spaceId: unique identifier
  encryptedReadKey: read key encrypted for owner
  timestamp: creation time
  identitySignature: owner signs root
  metadataPubKey: public key for metadata encryption
  encryptedMetadataPrivKey: metadata private key encrypted with read key
  encryptedOwnerMetadata: owner metadata encrypted with metadata key
}
```

### 4.2 Record Chain

ACL records form a chain (not a tree) via the consensus protocol:
```
Record {
  prevId: previous record ID
  identity: creator's public key
  data: AclData (one or more AclContentValue operations)
  timestamp: creation time
}

RawRecord {
  payload: serialized Record
  signature: creator's Ed25519 signature
  acceptorIdentity: consensus node's public key
  acceptorSignature: consensus node's signature (acceptance proof)
  acceptorTimestamp: consensus acceptance time
}
```

### 4.3 Permission Hierarchy

```
Owner (1) > Admin (2) > Writer (3) > Reader (4) > Guest (5) > None (0)

Owner:  full control, transfer ownership, manage all
Admin:  manage accounts (invite, remove, change permissions), read, write
Writer: read and write objects
Reader: read only
Guest:  read only, cannot request removal, cannot upgrade
```

### 4.4 Invite Flows

**RequestToJoin** (owner approval required):
```
1. Owner: BuildInvite() → generates ephemeral Ed25519 keypair
   → AclAccountInvite{inviteKey: pubKey, type: RequestToJoin}
   → Returns private inviteKey (shared out-of-band)

2. Joiner: BuildRequestJoin(inviteKey)
   → Signs own pubKey with inviteKey (proves possession)
   → AclAccountRequestJoin{inviteIdentity, inviteRecordId, inviteIdentitySignature, metadata}

3. Owner: BuildRequestAccept(joinerId, permissions)
   → Encrypts read key with joiner's public key
   → AclAccountRequestAccept{identity, requestRecordId, encryptedReadKey, permissions}
```

**AnyoneCanJoin** (immediate access):
```
1. Owner: BuildInviteAnyone(permissions)
   → Generates ephemeral keypair
   → Encrypts read key with invite pubKey
   → AclAccountInvite{inviteKey, type: AnyoneCanJoin, encryptedReadKey, permissions}

2. Joiner: BuildInviteJoinWithoutApprove(invitePrivKey)
   → Decrypts read key using invite private key
   → Re-encrypts with own pubKey
   → AclAccountInviteJoin{identity, inviteRecordId, sig, metadata, encryptedReadKey, permissions}
```

### 4.5 Read Key Rotation

When users are removed, the read key must be rotated:
```
AclReadKeyChange {
  accountKeys: [{ identity, encryptedReadKey }]  // new key for each remaining user
  metadataPubKey: new metadata public key
  encryptedMetadataPrivKey: metadata privkey encrypted with new read key
  encryptedOldReadKey: old read key encrypted with new read key (for history)
  inviteKeys: [{ identity, encryptedReadKey }]   // new key for pending invites
}
```

---

## 5. Cryptographic Primitives

### 5.1 Key Derivation Hierarchy

```
BIP-39 Mnemonic (12-24 words)
  → Seed (512 bits)
  → SLIP-10: m/44'/2046'/index'  → Master Key (Ed25519)
     └─ m/44'/2046'/index'/0'    → Identity Key (Ed25519)
  → SLIP-10: m/44'/60'/0'/0/index → Ethereum Key (secp256k1, for naming service)
  → SLIP-21: m/anysync/space     → Space Read Key (AES-256)
     └─ m/anysync/tree/{id}      → Per-Object Key
     └─ m/anysync/keyvalue/{id}  → Per-KV Key
     └─ m/anysync/onetoone/0     → One-to-One Write Key
     └─ m/anysync/onetoonemeta   → One-to-One Metadata Key
```

### 5.2 SLIP-10 (Ed25519 Asymmetric Key Derivation)

```
Master Generation:
  hash = HMAC-SHA512(key="ed25519 seed", message=seed)
  masterKey = hash[0:32]
  chainCode = hash[32:64]

Hardened Child Derivation (only hardened for Ed25519):
  hash = HMAC-SHA512(key=parent.chainCode, message=0x00 || parent.key || bigEndian(index))
  childKey = hash[0:32]
  childChainCode = hash[32:64]

  FirstHardenedIndex = 0x80000000 (2147483648)
```

**Test Vectors** (seed: `000102030405060708090a0b0c0d0e0f`):

| Path | Private Key | Public Key |
|------|------------|------------|
| m | `2b4be7f19ee27bbf30c667b642d5f4aa69fd169872f8fc3059c08ebae2eb19e7` | `00a4b2856bfec510abab89753fac1ac0e1112364e7d250545963f135f2a33188ed` |
| m/0' | `68e0fe46dfb67e368c75379acec591dad19df3cde26e63b93a8e704f1dade7a3` | `008c8a13df77a28f3445213a0f432fde644acaa215fc72dcdf300d5efaa85d350c` |
| m/0'/1' | `b1d0bad404bf35da785a64ca1ac54b2617211d2777696fbffaf208f746ae84f2` | `001932a5270f335bed617d5b935c80aedb1a35bd9fc1e31acafd5372c30f5c1187` |
| m/0'/1'/2' | `92a5b23c0b8a99e37d07df3fb9966917f5d06e02ddbd909c7e184371463e9fc9` | `00ae98736566d30ed0e9d2f4486a64bc95740d89c7db33f52121f8ea8f76ff0fc1` |
| m/0'/1'/2'/2' | `30d1dc7e5fc04c31219ab25a27ae00b50f6fd66622f6e9c913253d6511d1e662` | `008abae2d66361c879b900d204ad2cc4984fa2aa344dd7ddc46007329ac76c429c` |
| m/0'/1'/2'/2'/1000000000' | `8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793` | `003c24da049451555d51a7014a37337aa4e12d41e485abccfa46b47dfb2af54b7a` |

### 5.3 SLIP-21 (Symmetric Key Derivation)

```
Master Generation:
  hash = HMAC-SHA512(key="Symmetric key seed", message=seed)
  masterKey = hash[0:32]
  chainCode = hash[32:64]

Child Derivation:
  hash = HMAC-SHA512(key=parent.chainCode, message=0x00 || label)
  childKey = hash[32:64]      // NOTE: key is second half
  childChainCode = hash[0:32] // chain code is first half
```

**Test Vectors** (seed: `c76c4ac4f4e4a00d6b274d5c39c700bb4a7ddc04fbc6f78e85ca75007b5b495f74a9043eeb77bdd53aa6fc3a0e31462270316fa04b8c19114c8798706cd02ac8`):

| Path | Key |
|------|-----|
| m | `dbf12b44133eaab506a740f6565cc117228cbf1dd70635cfa8ddfdc9af734756` |
| m/SLIP-0021 | `1d065e3ac1bbe5c7fad32cf2305f7d709dc070d672044a19e610c77cdf33de0d` |
| m/SLIP-0021/Master encryption key | `ea163130e35bbafdf5ddee97a17b39cef2be4b4f390180d65b54cf05c6a82fde` |
| m/SLIP-0021/Authentication key | `47194e938ab24cc82bfa25f6486ed54bebe79c40ae2a5a32ea6db294d81861a6` |

### 5.4 AES-256-GCM

```
Key:    32 bytes (256-bit)
Nonce:  12 bytes (96-bit, random, prepended to ciphertext)
Tag:    16 bytes (128-bit, appended by GCM)

Encrypt(key, plaintext):
  nonce = random(12)
  ciphertext = AES-GCM-Seal(key, nonce, plaintext)
  return nonce || ciphertext

Decrypt(key, data):
  nonce = data[0:12]
  ciphertext = data[12:]
  return AES-GCM-Open(key, nonce, ciphertext)
```

### 5.5 Ed25519 + X25519

- **Signing**: Ed25519 (identity keys, change signatures, ACL records)
- **Encryption**: Ed25519 public key → X25519 public key (birational map), ECDH → symmetric key → AES-GCM
- **Key Agreement**: X25519 ECDH between two peers → shared secret → derive per-session keys

---

## 6. File Upload/Download Protocol

### 6.1 Content Addressing

- IPFS-compatible CIDs: CID v1, DagProtobuf codec, SHA2-256 hash
- Files split into **1 MB chunks** (`ChunkSize = 1 << 20`)
- Balanced Merkle DAG tree: leaves = chunks, inner nodes = directory references
- Block deduplication via CID

### 6.2 Upload Flow

```
1. Client: chunk file → 1 MB blocks
2. Client: build balanced Merkle DAG
3. Client: compute CID for each block (SHA2-256)
4. Client: BlocksCheck(spaceId, cids[]) → find which blocks already exist
5. Client: BlockPush(spaceId, fileId, cid, data) for each missing block
   - Server verifies: CID == SHA2-256(data), rejects on mismatch
6. Client: BlocksBind(spaceId, fileId, cids[]) → link blocks to file
7. Server: updates quota (SpaceEntry, GroupEntry), increments ref counts
```

**Batch upload**: `BlockPushMany` accepts multiple FileBlocks, 20 MB total limit.

### 6.3 Download Flow

```
1. Client: BlockGet(spaceId, rootCid, wait=false)
2. Server: lookup CID in index, fetch from storage backend
3. Client: parse Merkle DAG links from root block
4. Client: recursively BlockGet child CIDs
5. Client: reassemble file from ordered chunks
6. Client: verify each block hash matches its CID
```

**Wait mode**: `BlockGet(wait=true)` blocks until CID becomes available (for real-time sync).

### 6.4 Quota System

```
Three-level hierarchy:
  AccountLimit (total across all spaces)
    └─ GroupLimit (shared across spaces, default)
        └─ SpaceLimit (optional per-space override)

Check: if space.limit > 0 → use space limit, else → use group limit
```

### 6.5 Metadata Structure

```
CidEntry:  { size, createTime, updateTime, refs (refcount), version }
FileEntry: { cids[], size, createTime, updateTime }
SpaceEntry: { groupId, size, cidCount, fileCount, limit }
GroupEntry: { groupId, size, cidCount, spaceIds[], limit, accountLimit }
```

---

## 7. Sync Engine Architecture

### 7.1 Connection Management

```
Pool:
  Get(peerId)         → get/create outgoing connection
  GetOneOf(peerIds[]) → get first available (shuffled)
  AddPeer(peer)       → register incoming connection
  Pick(peerId)        → check existing without dial
  Flush()             → close all

Preferences: incoming connections preferred (already verified).
Reconnect: 1-minute fixed timeout after failure.
```

### 7.2 Stream Pool

Each stream runs:
- **Read loop**: receive messages, dispatch to handler
- **Write loop**: send queued messages
- **Handler**: ProcessMessage(ctx, peerId, msg)
- **Stats**: track message sizes

### 7.3 Peer Manager

```
GetResponsiblePeers() → nodes responsible for this space
BroadcastMessage(msg) → flood to all responsible peers
SendMessage(peerId, msg) → targeted send
KeepAlive() → maintain connections
```

### 7.4 Message Queue

```
Types:
  MsgTypeIncoming (0)          → from peer
  MsgTypeOutgoing (1)          → to peer
  MsgTypeIncomingRequest (2)   → sync request received
  MsgTypeOutgoingRequest (3)   → sync request sent
  MsgTypeReceivedResponse (4)  → response received
  MsgTypeSentResponse (5)      → response sent
```

### 7.5 Conflict Resolution

On receiving remote changes:
1. Add changes to local DAG via `AddRawChangesFromPeer`
2. Compare resulting heads with expected heads
3. If mismatch → automatic `TreeFullSyncRequest`
4. Full sync rebuilds consistent state
5. No exponential backoff — immediate retry

---

## 8. Network Configuration

### 8.1 Node Types

| Type | Role |
|------|------|
| TreeAPI (0) | Sync node — stores/serves object trees |
| FileAPI (1) | File node — stores/serves file blocks |
| CoordinatorAPI (2) | Coordinator — space registration, network config |
| ConsensusAPI (3) | Consensus node — ACL record ordering |
| NamingNodeAPI (4) | Name service — *.any name resolution |
| PaymentProcessingAPI (5) | Payment processing |

### 8.2 Discovery

```
NetworkConfiguration RPC → returns all known nodes with addresses and types
ClientSpace.SpaceExchange → P2P space discovery (includes local server IPs/ports)
mDNS → LAN peer discovery
```

---

## 9. Key Interfaces for Dart Implementation

Based on the protocol analysis, the Dart client must implement:

1. **Handshake client**: TLS + credential exchange + proto negotiation
2. **SpaceSync client**: HeadSync, ObjectSyncStream, SpacePush/Pull, StoreElements
3. **Consensus client**: LogAdd, RecordAdd, LogWatch
4. **File client**: BlockGet/Push/PushMany, BlocksCheck/Bind, FilesDelete/Info
5. **Coordinator client**: SpaceSign, NetworkConfiguration, SpaceDelete, AclAddRecord
6. **Change tree**: DAG with merge, snapshots, lexicographic ordering
7. **ACL state machine**: parse records, enforce permissions, handle invites
8. **Crypto**: SLIP-10/21, Ed25519, X25519, AES-256-GCM, CID generation
