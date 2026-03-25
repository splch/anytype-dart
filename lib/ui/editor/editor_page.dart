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

import '../../src/editor/block_editor.dart';
import '../../src/model/any_object.dart';
import '../../src/model/block.dart' as model;
import '../shell/app_state.dart';
import 'block_widget.dart';
import 'slash_menu.dart';

/// Full-page block editor for an object.
class EditorPage extends StatefulWidget {
  final String objectId;
  const EditorPage({super.key, required this.objectId});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late BlockEditor _editor;
  late AnyObject _object;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = context.read<AppState>();
    _object = appState.selectedObject!;
    _editor = appState.editorForObject(widget.objectId)!;
  }

  Future<void> _onTextChanged(String blockId, String text) async {
    await _editor.setText(blockId, text);
    setState(() {});
  }

  Future<void> _onStyleChanged(String blockId, model.TextStyle style) async {
    await _editor.setStyle(blockId, style);
    setState(() {});
  }

  Future<void> _onCheckedChanged(String blockId, bool checked) async {
    await _editor.setChecked(blockId, checked);
    setState(() {});
  }

  Future<void> _deleteBlock(String blockId) async {
    await _editor.deleteBlock(blockId);
    setState(() {});
  }

  Future<void> _insertNewParagraph(String afterId) async {
    await _editor.insertText(
      parentId: _object.rootBlockId,
      afterId: afterId,
    );
    setState(() {});
  }

  void _showSlashMenu(BuildContext context, String afterBlockId) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SlashMenu(
        onSelect: (type) async {
          Navigator.of(ctx).pop();
          switch (type) {
            case SlashMenuItem.paragraph:
              await _editor.insertText(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
              );
            case SlashMenuItem.heading1:
              await _editor.insertHeading(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                level: 1,
              );
            case SlashMenuItem.heading2:
              await _editor.insertHeading(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                level: 2,
              );
            case SlashMenuItem.heading3:
              await _editor.insertHeading(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                level: 3,
              );
            case SlashMenuItem.bulletList:
              await _editor.insertText(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                style: model.TextStyle.bulletedList,
              );
            case SlashMenuItem.numberedList:
              await _editor.insertText(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                style: model.TextStyle.numberedList,
              );
            case SlashMenuItem.checkbox:
              await _editor.insertText(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                style: model.TextStyle.checkboxList,
              );
            case SlashMenuItem.quote:
              await _editor.insertText(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                style: model.TextStyle.quote,
              );
            case SlashMenuItem.divider:
              await _editor.insertDivider(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
              );
            case SlashMenuItem.code:
              await _editor.insertText(
                parentId: _object.rootBlockId,
                afterId: afterBlockId,
                style: model.TextStyle.code,
              );
          }
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final blockIds = _object.contentBlockIds;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<AppState>().selectObject(null),
        ),
        title: _TitleField(
          name: _object.name,
          onChanged: (name) async {
            await _editor.setDetails({'name': name});
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add block',
            onPressed: () => _showSlashMenu(
              context,
              blockIds.isNotEmpty ? blockIds.last : _object.rootBlockId,
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'save', child: Text('Save')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
            onSelected: (value) async {
              if (value == 'save') {
                await context.read<AppState>().saveObject(widget.objectId);
              } else if (value == 'delete') {
                await context.read<AppState>().deleteObject(widget.objectId);
              }
            },
          ),
        ],
      ),
      body: blockIds.isEmpty
          ? Center(
              child: TextButton.icon(
                onPressed: () => _showSlashMenu(context, _object.rootBlockId),
                icon: const Icon(Icons.add),
                label: const Text('Add a block'),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: blockIds.length,
              itemBuilder: (context, index) {
                final blockId = blockIds[index];
                final block = _object.getBlock(blockId);
                if (block == null) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Dismissible(
                    key: ValueKey(blockId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Theme.of(context).colorScheme.errorContainer,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (_) => _deleteBlock(blockId),
                    child: GestureDetector(
                      onLongPress: () => _showSlashMenu(context, blockId),
                      child: BlockWidget(
                        block: block,
                        onTextChanged: (text) =>
                            _onTextChanged(blockId, text),
                        onStyleChanged: (style) =>
                            _onStyleChanged(blockId, style),
                        onCheckedChanged: (checked) =>
                            _onCheckedChanged(blockId, checked),
                        onDelete: () => _deleteBlock(blockId),
                        onEnter: () => _insertNewParagraph(blockId),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _TitleField extends StatelessWidget {
  final String name;
  final ValueChanged<String> onChanged;

  const _TitleField({required this.name, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: name),
      style: Theme.of(context).textTheme.titleLarge,
      decoration: const InputDecoration(
        hintText: 'Untitled',
        border: InputBorder.none,
      ),
      onSubmitted: onChanged,
    );
  }
}
