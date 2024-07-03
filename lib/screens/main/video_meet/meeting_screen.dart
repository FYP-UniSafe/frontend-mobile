import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unisafe/Services/storage.dart';
import 'package:videosdk/videosdk.dart';
import '../../../Models/User.dart';
import 'Widgets/meeting_controls.dart';
import 'Widgets/participant_tile.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;

  Map<String, Participant> participants = {};
  late LocalStorageProvider _storageProvider;
  User? _user;

  @override
  void initState() {
    _storageProvider =
        Provider.of<LocalStorageProvider>(context, listen: false);
    _user = _storageProvider.user;
    // create room
    _room = VideoSDK.createRoom(
      roomId: widget.meetingId,
      token: widget.token,
      displayName: _user?.full_name ?? "Guest User",
      micEnabled: micEnabled,
      notification: NotificationInfo(
          title: "UniSafe",
          message: "UniSafe is sharing screen in the meeting",
          icon: "notification_share"),
      camEnabled: camEnabled,
      defaultCameraIndex:
          1, // Index of MediaDevices will be used to set default camera
    );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(
          () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
          () => participants.remove(participantId),
        );
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(8, 100, 175, 1.0),
          surfaceTintColor: Color.fromRGBO(8, 100, 175, 1.0),
          title: const Text(
            'UniSafe',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Meeting Workspace',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(
                height: 30.0,
                color: Color.fromRGBO(8, 100, 175, 1.0),
              ),
              /*if (widget.meetingId == null)
                Text(
                  widget.meetingId.toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),*/

              //render all participant
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300,
                    ),
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                          key: Key(participants.values.elementAt(index).id),
                          participant: participants.values.elementAt(index));
                    },
                    itemCount: participants.length,
                  ),
                ),
              ),
              MeetingControls(
                onToggleMicButtonPressed: () {
                  micEnabled ? _room.muteMic() : _room.unmuteMic();
                  micEnabled = !micEnabled;
                },
                onToggleCameraButtonPressed: () {
                  camEnabled ? _room.disableCam() : _room.enableCam();
                  camEnabled = !camEnabled;
                },
                onLeaveButtonPressed: () => _room.leave(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
