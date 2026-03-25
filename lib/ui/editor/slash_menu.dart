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

/// Items available in the slash command menu.
enum SlashMenuItem {
  paragraph,
  heading1,
  heading2,
  heading3,
  bulletList,
  numberedList,
  checkbox,
  quote,
  divider,
  code,
}

/// Slash command menu (/) for inserting new blocks.
class SlashMenu extends StatelessWidget {
  final ValueChanged<SlashMenuItem> onSelect;
  const SlashMenu({super.key, required this.onSelect});

  static const _items = [
    (SlashMenuItem.paragraph, Icons.text_fields, 'Text', 'Plain text paragraph'),
    (SlashMenuItem.heading1, Icons.looks_one, 'Heading 1', 'Large heading'),
    (SlashMenuItem.heading2, Icons.looks_two, 'Heading 2', 'Medium heading'),
    (SlashMenuItem.heading3, Icons.looks_3, 'Heading 3', 'Small heading'),
    (SlashMenuItem.bulletList, Icons.format_list_bulleted, 'Bulleted List', 'Unordered list'),
    (SlashMenuItem.numberedList, Icons.format_list_numbered, 'Numbered List', 'Ordered list'),
    (SlashMenuItem.checkbox, Icons.check_box_outlined, 'Checkbox', 'Task checkbox'),
    (SlashMenuItem.quote, Icons.format_quote, 'Quote', 'Block quote'),
    (SlashMenuItem.divider, Icons.horizontal_rule, 'Divider', 'Horizontal line'),
    (SlashMenuItem.code, Icons.code, 'Code', 'Code block'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final (item, icon, title, subtitle) = _items[index];
        return ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () => onSelect(item),
        );
      },
    );
  }
}
