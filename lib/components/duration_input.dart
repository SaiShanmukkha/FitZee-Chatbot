import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DurationInput extends StatefulWidget {
  final TextEditingController controller;

  DurationInput({Key? key, required this.controller}) : super(key: key);

  @override
  _DurationInputState createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_formatDuration);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_formatDuration);
    super.dispose();
  }

  void _formatDuration() {
    String text = widget.controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 4) {
      text = text.substring(0, 4); // Restrict input to 4 digits
    }
    if (text.length > 2) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
    }
    widget.controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'Duration (HH:MM)',
        hintText: '00:00',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a duration';
        }
        if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(value)) {
          return 'Enter duration in HH:MM format';
        }
        return null;
      },
    );
  }
}
