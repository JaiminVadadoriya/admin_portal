import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/message.dart';

class Broadcast extends StatefulWidget {
  const Broadcast({super.key});

  @override
  State<Broadcast> createState() => _BroadcastState();
}

class _BroadcastState extends State<Broadcast> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  void sendMessage() async {
    final text = _messageController.text;
    final sender =
        'Admin'; // You can replace this with dynamic sender information

    if (text.isNotEmpty) {
      try {
        await db.collection('messages').add({
          'msgInfo': text,
          'sender': sender,
          'timestamp': FieldValue.serverTimestamp(),
        }).then((value) {
          db.collection('messages').doc(value.id).update({"mID": value.id});
          _messageController.clear();
        });
        // print('Message sent and stored successfully.');
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  String messageTime(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final time = TimeOfDay.fromDateTime(dateTime).format(context);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Messaging App'),
      // ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text('No messages available'),
                  );
                }

                final messages = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;

                  return Message.fromMap(data);
                }).toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSender = message.sender ==
                        'Admin'; // Replace 'John Doe' with the dynamic sender information

                    return Align(
                      alignment: //isSender
                          Alignment.centerRight,
                      //: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: isSender
                                  ? Theme.of(context).focusColor
                                  : Theme.of(context).indicatorColor,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.sender,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  message.msgInfo,
                                  style: const TextStyle(
                                      // color: isSender ? Colors.white : Colors.black,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  messageTime(
                                      message.timestamp ?? Timestamp.now()),
                                  style: const TextStyle(
                                    // color: isSender ? Colors.white70 : Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                db
                                    .collection('messages')
                                    .doc(message.mID)
                                    .delete();
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
