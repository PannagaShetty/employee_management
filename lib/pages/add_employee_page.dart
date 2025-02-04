import 'package:flutter/material.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Container(), // Employee details will be added here
    );
  }
}
