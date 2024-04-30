import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/utils/utils.dart';
// import 'package:student_hub/models/project.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/circle_container.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/select_date_time.dart';
import 'package:student_hub/widgets/text_field_title.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class UpdateMeeting extends StatefulWidget {
  const UpdateMeeting({
    super.key,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.socket,
    this.currentDate,
    this.currentTime,
  });
  final int projectId;
  final int senderId;
  final int receiverId;
  final DateTime? currentDate;
  final TimeOfDay? currentTime;
  final Message message;
  final io.Socket? socket;
  @override
  State<UpdateMeeting> createState() => _UpdateMeetingState();
}

class _UpdateMeetingState extends State<UpdateMeeting> {
  final titleController = TextEditingController();
  late DateTime pickedDate;
  late TimeOfDay pickedTime;
  @override
  void initState() {
    super.initState();
    pickedDate = widget.currentDate ?? DateTime.now();
    pickedTime = widget.currentTime ?? TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    void createMeeting() {
      Navigator.pop(context);

      if (titleController.text.isEmpty) {
        MySnackBar.showSnackBar(
          context,
          'Please fill all meeting\'s information',
          'Error',
          ContentType.failure,
        );
        return;
      } else {
        // widget.socket.emit('SCHEDULE_INTERVIEW', {
        //   'title': titleController.text,
        //   'startTime': DateTime(
        //     pickedDate.year,
        //     pickedDate.month,
        //     pickedDate.day,
        //     pickedTime.hour,
        //     pickedTime.minute,
        //   ).toIso8601String(),
        //   'endTime': DateTime(
        //     pickedDate.year,
        //     pickedDate.month,
        //     pickedDate.day,
        //     pickedTime.hour + 1,
        //     pickedTime.minute,
        //   ).toIso8601String(),
        //   'projectId': widget.projectId,
        //   'senderId': widget.senderId,
        //   'receiverId': widget.receiverId,
        //   'meeting_room_code': MeetingRoom.generateMeetingRoomCode(),
        //   'meeting_room_id': MeetingRoom.generateMeetingRoomId(),
        // });
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            CircleContainer(
              color: primary_300.withOpacity(0.3),
              child: const Icon(Icons.calendar_month, color: primary_300),
            ),
            const Gap(4),
            Text(
              'Schedule a video call interview',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            const Divider(thickness: 1.5, color: primary_300),
            const Gap(8),
            SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldTitle(
                    title: 'Title',
                    hintText: 'Enter meeting\'s title',
                    controller: titleController,
                  ),
                  const Gap(30),
                  SelectDateTime(
                    titleDate: 'Start Date',
                    titleTime: 'Start Time',
                    date: pickedDate,
                    time: pickedTime,
                  ),
                  const Gap(30),
                  SelectDateTime(
                    titleDate: 'End Date',
                    titleTime: 'End Time',
                    date: pickedDate,
                    time: pickedTime,
                  ),
                  const Gap(20),
                  const Divider(thickness: 1.5, color: primary_300),
                  const Gap(30),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  colorButton: primary_300,
                  colorText: text_50,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Button(
                  onTap: () {
                    createMeeting();
                  },
                  text: 'Send Invite',
                  colorButton: primary_300,
                  colorText: text_50,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
