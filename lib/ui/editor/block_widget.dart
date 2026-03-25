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

import '../../src/model/block.dart' as model;

/// Renders a single block as a Flutter widget.
class BlockWidget extends StatelessWidget {
  final model.Block block;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<model.TextStyle>? onStyleChanged;
  final ValueChanged<bool>? onCheckedChanged;
  final VoidCallback? onDelete;
  final VoidCallback? onEnter;

  const BlockWidget({
    super.key,
    required this.block,
    this.onTextChanged,
    this.onStyleChanged,
    this.onCheckedChanged,
    this.onDelete,
    this.onEnter,
  });

  @override
  Widget build(BuildContext context) {
    return switch (block.type) {
      model.BlockType.text => _TextBlockWidget(
          block: block,
          onTextChanged: onTextChanged,
          onStyleChanged: onStyleChanged,
          onCheckedChanged: onCheckedChanged,
          onDelete: onDelete,
          onEnter: onEnter,
        ),
      model.BlockType.divider => const _DividerBlockWidget(),
      model.BlockType.file => _FileBlockWidget(block: block),
      model.BlockType.link => _LinkBlockWidget(block: block),
      model.BlockType.bookmark => _BookmarkBlockWidget(block: block),
      _ => _UnsupportedBlockWidget(block: block),
    };
  }
}

class _TextBlockWidget extends StatefulWidget {
  final model.Block block;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<model.TextStyle>? onStyleChanged;
  final ValueChanged<bool>? onCheckedChanged;
  final VoidCallback? onDelete;
  final VoidCallback? onEnter;

  const _TextBlockWidget({
    required this.block,
    this.onTextChanged,
    this.onStyleChanged,
    this.onCheckedChanged,
    this.onDelete,
    this.onEnter,
  });

  @override
  State<_TextBlockWidget> createState() => _TextBlockWidgetState();
}

class _TextBlockWidgetState extends State<_TextBlockWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.block.textContent?.text ?? '',
    );
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(_TextBlockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.block.textContent?.text ?? '';
    if (_controller.text != newText) {
      _controller.text = newText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  TextStyle _textStyle(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return switch (widget.block.textContent?.style) {
      model.TextStyle.header1 => theme.headlineLarge!,
      model.TextStyle.header2 => theme.headlineMedium!,
      model.TextStyle.header3 => theme.headlineSmall!,
      model.TextStyle.header4 => theme.titleLarge!,
      model.TextStyle.title => theme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
      model.TextStyle.quote => theme.bodyLarge!.copyWith(
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      model.TextStyle.callout => theme.bodyLarge!,
      model.TextStyle.code => theme.bodyMedium!.copyWith(fontFamily: 'monospace'),
      _ => theme.bodyLarge!,
    };
  }

  String? _hintText() {
    return switch (widget.block.textContent?.style) {
      model.TextStyle.header1 => 'Heading 1',
      model.TextStyle.header2 => 'Heading 2',
      model.TextStyle.header3 => 'Heading 3',
      model.TextStyle.title => 'Title',
      _ => 'Type / for commands...',
    };
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.block.textContent?.style ?? model.TextStyle.paragraph;
    final isCheckbox = style == model.TextStyle.checkboxList;
    final isBullet = style == model.TextStyle.bulletedList;
    final isNumbered = style == model.TextStyle.numberedList;
    final isQuote = style == model.TextStyle.quote;

    Widget textField = TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: _textStyle(context),
      decoration: InputDecoration(
        hintText: _hintText(),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
      maxLines: null,
      onChanged: widget.onTextChanged,
      onSubmitted: (_) => widget.onEnter?.call(),
    );

    if (isCheckbox) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Checkbox(
              value: widget.block.textContent?.checked ?? false,
              onChanged: (v) => widget.onCheckedChanged?.call(v ?? false),
            ),
          ),
          Expanded(child: textField),
        ],
      );
    }

    if (isBullet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Icon(Icons.circle, size: 6),
          ),
          Expanded(child: textField),
        ],
      );
    }

    if (isNumbered) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8),
            child: Text('1.', style: _textStyle(context)),
          ),
          Expanded(child: textField),
        ],
      );
    }

    if (isQuote) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 3,
            ),
          ),
        ),
        padding: const EdgeInsets.only(left: 12),
        child: textField,
      );
    }

    return textField;
  }
}

class _DividerBlockWidget extends StatelessWidget {
  const _DividerBlockWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(),
    );
  }
}

class _FileBlockWidget extends StatelessWidget {
  final model.Block block;
  const _FileBlockWidget({required this.block});

  @override
  Widget build(BuildContext context) {
    final content = block.fileContent;
    final name = content?.name ?? 'File';
    final isImage = content?.fileType == model.FileType.image;

    if (isImage) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.image_outlined, size: 48),
              const SizedBox(height: 8),
              Text(name, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: const Icon(Icons.attach_file),
        title: Text(name),
        subtitle: Text(content?.mime ?? ''),
      ),
    );
  }
}

class _LinkBlockWidget extends StatelessWidget {
  final model.Block block;
  const _LinkBlockWidget({required this.block});

  @override
  Widget build(BuildContext context) {
    final target = block.linkContent?.targetObjectId ?? '';
    return Card(
      child: ListTile(
        leading: const Icon(Icons.link),
        title: Text('Link to $target'),
        subtitle: Text(block.linkContent?.description ?? ''),
      ),
    );
  }
}

class _BookmarkBlockWidget extends StatelessWidget {
  final model.Block block;
  const _BookmarkBlockWidget({required this.block});

  @override
  Widget build(BuildContext context) {
    final content = block.bookmarkContent;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.bookmark_outline),
        title: Text(content?.title.isNotEmpty == true
            ? content!.title
            : content?.url ?? 'Bookmark'),
        subtitle: content?.description.isNotEmpty == true
            ? Text(content!.description, maxLines: 2, overflow: TextOverflow.ellipsis)
            : null,
      ),
    );
  }
}

class _UnsupportedBlockWidget extends StatelessWidget {
  final model.Block block;
  const _UnsupportedBlockWidget({required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Unsupported block: ${block.type.name}',
        style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
      ),
    );
  }
}
