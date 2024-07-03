import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls(
      {super.key,
        required this.onToggleMicButtonPressed,
        required this.onToggleCameraButtonPressed,
        required this.onLeaveButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onLeaveButtonPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            // fixedSize: Size(
            //     MediaQuery.of(context).size.width * 0.9,
            //     50),
            backgroundColor:
            Colors.red,
            padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.call_end,color: Colors.white,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Leave',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onToggleMicButtonPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            // fixedSize: Size(
            //     MediaQuery.of(context).size.width * 0.9,
            //     50),
            backgroundColor:
            Color.fromRGBO(8, 100, 175, 1.0),
            padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.mic,color: Colors.white,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Toggle Mic',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onToggleCameraButtonPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            // fixedSize: Size(
            //     MediaQuery.of(context).size.width * 0.9,
            //     50),
            backgroundColor:
            Color.fromRGBO(8, 100, 175, 1.0),
            padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Row(
            children: [
              Icon(CupertinoIcons.camera_fill,color: Colors.white,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Toggle WebCam',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}