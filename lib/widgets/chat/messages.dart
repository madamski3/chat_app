import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] == _currentUser,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
