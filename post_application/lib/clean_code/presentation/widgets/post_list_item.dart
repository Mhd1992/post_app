


import 'package:flutter/material.dart';

import '../../domain/entities/post_entity.dart';

class PostListItem extends StatelessWidget {
  final PostEntity post;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const PostListItem({super.key, required this.post, required this.onDelete, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.desc),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}