import 'package:flutter/material.dart';
import 'package:transit_app/common_layout.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class PlanTripPage extends StatefulWidget {
  const PlanTripPage({Key? key}) : super(key: key);

  @override
  _PlanTripPageState createState() => _PlanTripPageState();
}

class _PlanTripPageState extends State<PlanTripPage> {
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _addTripToCalendar() {
    if (_selectedDate != null) {
      final Event event = Event(
        title: _destinationController.text,
        description: _descriptionController.text,
        location: 'Bus Station',
        startDate: _selectedDate!,
        endDate: _selectedDate!.add(Duration(hours: 1)),
        allDay: false,
        iosParams: IOSParams(
          reminder: Duration(minutes: 30),
        ),
        androidParams: AndroidParams(
          emailInvites: [], // Add email invites if needed
        ),
      );

      Add2Calendar.addEvent2Cal(event).then((success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success ? 'Trip added to calendar' : 'Failed to add trip to calendar')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Plan Your Trip'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'Destination',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? 'No date selected'
                      : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                  ElevatedButton(
                    onPressed: _selectDate,
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addTripToCalendar,
                child: Text('Add to Calendar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

