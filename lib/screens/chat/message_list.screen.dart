import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/screens/chat/widgets/chat.widgets.dart';
import 'package:student_hub/widgets/search_field.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  late List<MessageModel> lstMessage = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleFetchApiMessage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchController.dispose();
  }

  List<MessageModel> getLatestMessages(List<dynamic> results) {
    Map<String, MessageModel> latestMessages = {};

    for (var message in results) {
      MessageModel messageModel = MessageModel.fromMap(message);
      int senderId = messageModel.sender?.id ?? -1;
      int receiverId = messageModel.receiver?.id ?? -1;
      String pair = senderId.compareTo(receiverId) < 0
          ? '$senderId-$receiverId'
          : '$receiverId-$senderId';
      DateTime messageTime = DateTime.parse(messageModel.createdAt!);

      if (!latestMessages.containsKey(pair) ||
          messageTime
              .isAfter(DateTime.parse(latestMessages[pair]?.createdAt ?? ''))) {
        latestMessages[pair] = messageModel;
      }
    }

    return latestMessages.values.toList();
  }

  void handleFetchApiMessage() {
    final messageService = MessageService();

    setState(() {
      isLoading = true;
    });

    messageService.getAllMessage().then((value) {
      List<dynamic> data = value;
      List<MessageModel> res = getLatestMessages(data).reversed.toList();

      setState(() {
        lstMessage = res;
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void handleFilterUser(String name) {
    if (name.isEmpty) {
      handleFetchApiMessage();
      return;
    }

    List<MessageModel> filteredMessages = lstMessage.where((message) {
      String senderName = message.sender?.fullname ?? '';
      String receiverName = message.receiver?.fullname ?? '';
      return senderName.toLowerCase().contains(name.toLowerCase()) ||
          receiverName.toLowerCase().contains(name.toLowerCase());
    }).toList();

    setState(() {
      lstMessage = filteredMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchBox(
                  controller: _searchController, onChanged: handleFilterUser),
            ],
          ),
        ),
        isLoading
            ? const Center(
                child: Column(children: [
                  Gap(30),
                  CircularProgressIndicator(),
                ]),
              )
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: lstMessage.length,
                      itemBuilder: (ctx, index) {
                        return MessageItem(
                          message: lstMessage[index],
                        );
                      }),
                ),
              ),
      ]),
    );
  }
}
