import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .orderBy("createAt", descending: false)
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
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            return Text("");
          },
        );
      },
    );
  }
}
