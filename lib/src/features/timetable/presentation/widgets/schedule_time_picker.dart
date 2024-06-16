import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule_time.dart';

class ScheduleTimePicker extends StatefulWidget {
  final int startHour;
  final int endHour;
  final ScheduleTime scheduleTime;
  final bool isFirst;
  final void Function(ScheduleTime) onTapAction;
  final void Function() onTap;

  const ScheduleTimePicker({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.scheduleTime,
    this.isFirst = true,
    required this.onTapAction,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScheduleTimePickerState();
  }
}

class _ScheduleTimePickerState extends State<ScheduleTimePicker> {
  late final TextEditingController dayController;
  late final TextEditingController startTimeController;
  late final TextEditingController endTimeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dayController =
        TextEditingController(text: widget.scheduleTime.day.korean);
    startTimeController =
        TextEditingController(text: widget.scheduleTime.start.toString());
    endTimeController =
        TextEditingController(text: widget.scheduleTime.end.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: OrbTextField(
                controller: dayController,
                readOnly: true,
                hintText: '요일',
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: OrbIcon(
                    Icons.arrow_drop_down,
                  ),
                ),
                onTap: widget.onTap,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: OrbTextField(
                controller: startTimeController,
                readOnly: true,
                hintText: '시작',
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: OrbIcon(
                    Icons.arrow_drop_down,
                  ),
                ),
                onTap: widget.onTap,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: OrbTextField(
                controller: endTimeController,
                readOnly: true,
                hintText: '종료',
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: OrbIcon(
                    Icons.arrow_drop_down,
                  ),
                ),
                onTap: widget.onTap,
              ),
            ),
            widget.isFirst
                ? IconButton(
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    onPressed: () {
                      final newScheduleTimeInfo = ScheduleTime(
                        day: widget.scheduleTime.day,
                        start: widget.scheduleTime.start,
                        end: widget.scheduleTime.end,
                        place: '',
                      );
                      widget.onTapAction(newScheduleTimeInfo);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                    onPressed: () {
                      widget.onTapAction(widget.scheduleTime);
                    },
                  ),
          ],
        ),
      ],
    );
  }
}
