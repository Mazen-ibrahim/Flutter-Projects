import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authuser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .orderBy("createAt", descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Messages Found."));
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went wrong..."));
        }
        final loadedMessages = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index].data()
                : null;
            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId = nextMessage != null
                ? nextMessage['userId']
                : null;
            final bool nextUserIsSame =
                currentMessageUserId == nextMessageUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authuser.uid == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authuser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
