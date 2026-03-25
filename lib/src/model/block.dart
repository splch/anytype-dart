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

/// Block types for the Anytype object model.
///
/// Objects are composed of blocks arranged in a tree. Each block has
/// a type, an ID, optional children, and type-specific content.
library;

import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Visual style applied to text blocks.
enum TextStyle {
  paragraph,
  header1,
  header2,
  header3,
  header4,
  quote,
  callout,
  toggle,
  bulletedList,
  numberedList,
  checkboxList,
  code,
  title,
  description,
}

/// Inline marks on a span of text.
enum MarkType {
  bold,
  italic,
  strikethrough,
  underline,
  code,
  link,
  color,
  backgroundColor,
  mention,
  emoji,
  keyboard,
}

/// A mark applied to a range of text.
class Mark {
  final MarkType type;
  final int from;
  final int to;

  /// For link: URL. For color: hex. For mention: object ID.
  final String? param;

  const Mark({required this.type, required this.from, required this.to, this.param});

  Mark copyWith({int? from, int? to, String? param}) => Mark(
        type: type,
        from: from ?? this.from,
        to: to ?? this.to,
        param: param ?? this.param,
      );

  Map<String, dynamic> toMap() => {
        'type': type.index,
        'from': from,
        'to': to,
        if (param != null) 'param': param,
      };

  factory Mark.fromMap(Map<String, dynamic> map) => Mark(
        type: MarkType.values[map['type'] as int],
        from: map['from'] as int,
        to: map['to'] as int,
        param: map['param'] as String?,
      );
}

/// Content of a text block.
class TextContent {
  String text;
  TextStyle style;
  List<Mark> marks;
  bool? checked;
  String? iconEmoji;
  String? iconImage;

  TextContent({
    this.text = '',
    this.style = TextStyle.paragraph,
    List<Mark>? marks,
    this.checked,
    this.iconEmoji,
    this.iconImage,
  }) : marks = marks ?? [];

  Map<String, dynamic> toMap() => {
        'text': text,
        'style': style.index,
        'marks': marks.map((m) => m.toMap()).toList(),
        if (checked != null) 'checked': checked,
        if (iconEmoji != null) 'iconEmoji': iconEmoji,
        if (iconImage != null) 'iconImage': iconImage,
      };

  factory TextContent.fromMap(Map<String, dynamic> map) => TextContent(
        text: map['text'] as String? ?? '',
        style: TextStyle.values[map['style'] as int? ?? 0],
        marks: (map['marks'] as List<dynamic>?)
                ?.map((m) => Mark.fromMap(m as Map<String, dynamic>))
                .toList() ??
            [],
        checked: map['checked'] as bool?,
        iconEmoji: map['iconEmoji'] as String?,
        iconImage: map['iconImage'] as String?,
      );
}

/// File/media type.
enum FileType { image, video, audio, pdf, file }

/// File block content.
class FileContent {
  String hash;
  String name;
  String mime;
  int size;
  FileType fileType;
  int? width;
  int? height;

  FileContent({
    this.hash = '',
    this.name = '',
    this.mime = '',
    this.size = 0,
    this.fileType = FileType.file,
    this.width,
    this.height,
  });

  Map<String, dynamic> toMap() => {
        'hash': hash,
        'name': name,
        'mime': mime,
        'size': size,
        'fileType': fileType.index,
        if (width != null) 'width': width,
        if (height != null) 'height': height,
      };

  factory FileContent.fromMap(Map<String, dynamic> map) => FileContent(
        hash: map['hash'] as String? ?? '',
        name: map['name'] as String? ?? '',
        mime: map['mime'] as String? ?? '',
        size: map['size'] as int? ?? 0,
        fileType: FileType.values[map['fileType'] as int? ?? 4],
        width: map['width'] as int?,
        height: map['height'] as int?,
      );
}

/// Bookmark block content.
class BookmarkContent {
  String url;
  String title;
  String description;
  String imageHash;
  String faviconHash;

  BookmarkContent({
    this.url = '',
    this.title = '',
    this.description = '',
    this.imageHash = '',
    this.faviconHash = '',
  });

  Map<String, dynamic> toMap() => {
        'url': url,
        'title': title,
        'description': description,
        'imageHash': imageHash,
        'faviconHash': faviconHash,
      };

  factory BookmarkContent.fromMap(Map<String, dynamic> map) => BookmarkContent(
        url: map['url'] as String? ?? '',
        title: map['title'] as String? ?? '',
        description: map['description'] as String? ?? '',
        imageHash: map['imageHash'] as String? ?? '',
        faviconHash: map['faviconHash'] as String? ?? '',
      );
}

/// Link block content (link to another object).
class LinkContent {
  String targetObjectId;
  String iconEmoji;
  String iconImage;
  String description;

  LinkContent({
    this.targetObjectId = '',
    this.iconEmoji = '',
    this.iconImage = '',
    this.description = '',
  });

  Map<String, dynamic> toMap() => {
        'targetObjectId': targetObjectId,
        'iconEmoji': iconEmoji,
        'iconImage': iconImage,
        'description': description,
      };

  factory LinkContent.fromMap(Map<String, dynamic> map) => LinkContent(
        targetObjectId: map['targetObjectId'] as String? ?? '',
        iconEmoji: map['iconEmoji'] as String? ?? '',
        iconImage: map['iconImage'] as String? ?? '',
        description: map['description'] as String? ?? '',
      );
}

/// Layout types for layout blocks.
enum LayoutStyle { row, column, div, header, tableRow, tableColumn }

/// The type of a block.
enum BlockType {
  text,
  file,
  link,
  bookmark,
  divider,
  relation,
  layout,
  table,
  tableRow,
  tableColumn,
  widget,
}

/// A block in the object tree.
///
/// Blocks are the fundamental content unit. They form a tree
/// where a parent block contains an ordered list of child block IDs.
class Block {
  /// Unique block ID within the object.
  final String id;

  /// Block type discriminator.
  final BlockType type;

  /// Ordered child block IDs.
  final List<String> childIds;

  /// Text content (only for text blocks).
  TextContent? textContent;

  /// File content (only for file blocks).
  FileContent? fileContent;

  /// Bookmark content (only for bookmark blocks).
  BookmarkContent? bookmarkContent;

  /// Link content (only for link blocks).
  LinkContent? linkContent;

  /// Layout style (only for layout blocks).
  LayoutStyle? layoutStyle;

  /// Relation key (only for relation blocks).
  String? relationKey;

  /// Background color (CSS hex or named).
  String? backgroundColor;

  /// Horizontal alignment.
  String? align;

  /// Vertical alignment.
  String? verticalAlign;

  Block({
    String? id,
    required this.type,
    List<String>? childIds,
    this.textContent,
    this.fileContent,
    this.bookmarkContent,
    this.linkContent,
    this.layoutStyle,
    this.relationKey,
    this.backgroundColor,
    this.align,
    this.verticalAlign,
  })  : id = id ?? _uuid.v4(),
        childIds = childIds ?? [];

  /// Creates a text block with the given style and content.
  factory Block.text({
    String? id,
    String text = '',
    TextStyle style = TextStyle.paragraph,
    List<Mark>? marks,
    bool? checked,
  }) =>
      Block(
        id: id,
        type: BlockType.text,
        textContent: TextContent(
          text: text,
          style: style,
          marks: marks,
          checked: checked,
        ),
      );

  /// Creates a heading block.
  factory Block.heading(int level, {String? id, String text = ''}) {
    final style = switch (level) {
      1 => TextStyle.header1,
      2 => TextStyle.header2,
      3 => TextStyle.header3,
      _ => TextStyle.header4,
    };
    return Block.text(id: id, text: text, style: style);
  }

  /// Creates a divider block.
  factory Block.divider({String? id}) => Block(id: id, type: BlockType.divider);

  /// Creates a link block pointing to another object.
  factory Block.link({String? id, required String targetObjectId}) => Block(
        id: id,
        type: BlockType.link,
        linkContent: LinkContent(targetObjectId: targetObjectId),
      );

  /// Creates a file/image block.
  factory Block.file({
    String? id,
    String hash = '',
    String name = '',
    FileType fileType = FileType.file,
  }) =>
      Block(
        id: id,
        type: BlockType.file,
        fileContent: FileContent(hash: hash, name: name, fileType: fileType),
      );

  /// Creates a bookmark block.
  factory Block.bookmark({String? id, String url = ''}) => Block(
        id: id,
        type: BlockType.bookmark,
        bookmarkContent: BookmarkContent(url: url),
      );

  /// Creates a layout block.
  factory Block.layout({
    String? id,
    LayoutStyle style = LayoutStyle.row,
    List<String>? childIds,
  }) =>
      Block(
        id: id,
        type: BlockType.layout,
        layoutStyle: style,
        childIds: childIds,
      );

  /// Serializes the block to a map.
  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type.index,
        'childIds': childIds,
        if (textContent != null) 'text': textContent!.toMap(),
        if (fileContent != null) 'file': fileContent!.toMap(),
        if (bookmarkContent != null) 'bookmark': bookmarkContent!.toMap(),
        if (linkContent != null) 'link': linkContent!.toMap(),
        if (layoutStyle != null) 'layoutStyle': layoutStyle!.index,
        if (relationKey != null) 'relationKey': relationKey,
        if (backgroundColor != null) 'backgroundColor': backgroundColor,
        if (align != null) 'align': align,
        if (verticalAlign != null) 'verticalAlign': verticalAlign,
      };

  /// Deserializes a block from a map.
  factory Block.fromMap(Map<String, dynamic> map) => Block(
        id: map['id'] as String,
        type: BlockType.values[map['type'] as int],
        childIds: (map['childIds'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        textContent: map['text'] != null
            ? TextContent.fromMap(map['text'] as Map<String, dynamic>)
            : null,
        fileContent: map['file'] != null
            ? FileContent.fromMap(map['file'] as Map<String, dynamic>)
            : null,
        bookmarkContent: map['bookmark'] != null
            ? BookmarkContent.fromMap(map['bookmark'] as Map<String, dynamic>)
            : null,
        linkContent: map['link'] != null
            ? LinkContent.fromMap(map['link'] as Map<String, dynamic>)
            : null,
        layoutStyle: map['layoutStyle'] != null
            ? LayoutStyle.values[map['layoutStyle'] as int]
            : null,
        relationKey: map['relationKey'] as String?,
        backgroundColor: map['backgroundColor'] as String?,
        align: map['align'] as String?,
        verticalAlign: map['verticalAlign'] as String?,
      );

  @override
  String toString() => 'Block($id, $type)';
}
