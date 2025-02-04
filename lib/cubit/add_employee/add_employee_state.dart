import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/employee.dart';

class AddEmployeeState extends Equatable {
  final String name;
  final Role? selectedRole;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? error;
  final bool isSuccess;

  const AddEmployeeState({
    this.name = '',
    this.selectedRole,
    this.startDate,
    this.endDate,
    this.error,
    this.isSuccess = false,
  });

  AddEmployeeState copyWith({
    String? name,
    Role? selectedRole,
    DateTime? startDate,
    DateTime? endDate,
    String? error,
    bool? isSuccess,
  }) {
    return AddEmployeeState(
      name: name ?? this.name,
      selectedRole: selectedRole ?? this.selectedRole,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [name, selectedRole, startDate, endDate, error, isSuccess];
}
