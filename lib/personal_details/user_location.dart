import 'package:flutter/material.dart';

class DropdownMenuExample extends StatelessWidget {
  const DropdownMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedLocation; // Selected location value

    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown in Container')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: selectedLocation,
            hint: const Text('Select Location'),
            isExpanded: true, // Dropdown matches the width of the container
            underline: const SizedBox(), // Removes the default underline
            items: ['New York', 'Berlin', 'Tokyo', 'London']
                .map((location) => DropdownMenuItem<String>(
                      value: location,
                      child: Text(location),
                    ))
                .toList(),
            onChanged: (newValue) {
              selectedLocation = newValue!;
            },
          ),
        ),
      ),
    );
  }
}

