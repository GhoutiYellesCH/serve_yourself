import 'package:flutter/material.dart';

import '../../helpers/design.dart';
import '../../models/comment_model.dart';

class CommentScreen extends StatefulWidget {
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  final List<CommentModel> comments = [
    CommentModel(
      user: 'Amine',
      image: 'https://i.pravatar.cc/150?img=3',
      comment: 'Looks delicious!',
    ),
    CommentModel(
      user: 'Sarah',
      image: 'https://i.pravatar.cc/150?img=5',
      comment: 'Yummy ',
    ),
  ];

  void loadComments (){
    // Todo : load comments from the server
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      // todo : add comment to the server
      // For now, we will just add it to the local list
      setState(() {
        comments.add(CommentModel(
          user: 'You',
          image: 'https://i.pravatar.cc/150?img=1',
          comment: _commentController.text.trim(),
        ));
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Comments', style: TextStyle(color:  Design.primary)),
        iconTheme: IconThemeData(color: Design.primary),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(comment.image),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.user,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              comment.comment,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
