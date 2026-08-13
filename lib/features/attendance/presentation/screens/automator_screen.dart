import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

class AutomatorScreen extends StatefulWidget {
  const AutomatorScreen({super.key});

  @override
  State<AutomatorScreen> createState() => _AutomatorScreenState();
}

class _AutomatorScreenState extends State<AutomatorScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _worklogController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(LoadTokenEvent());
    final today = DateTime.now();
    context.read<AttendanceBloc>().add(UpdateFormStateEvent(
          startDate: today,
          endDate: today,
        ));
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _reasonController.dispose();
    _worklogController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final bloc = context.read<AttendanceBloc>();
    final currentState = bloc.state;
    DateTime now = DateTime.now();
    DateTimeRange? initialRange;
    if (currentState.startDate != null && currentState.endDate != null) {
      initialRange = DateTimeRange(start: currentState.startDate!, end: currentState.endDate!);
    }

    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: initialRange,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );

    if (picked != null && context.mounted) {
      bloc.add(UpdateFormStateEvent(startDate: picked.start, endDate: picked.end));
    }
  }

  Future<void> _pickSingleDate(BuildContext context) async {
    final bloc = context.read<AttendanceBloc>();
    final currentState = bloc.state;
    DateTime now = DateTime.now();
    
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentState.startDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );

    if (picked != null && context.mounted) {
      bloc.add(UpdateFormStateEvent(startDate: picked, endDate: picked));
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Automator'),
        centerTitle: true,
      ),
      body: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceRunning || state is AttendanceCompleted) {
            _scrollToBottom();
          }
          if (state is AttendanceInitial && state.savedToken != null && _tokenController.text.isEmpty) {
            _tokenController.text = state.savedToken!;
          }
          if (state.savedToken != null && _tokenController.text.isEmpty) {
            _tokenController.text = state.savedToken!;
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Token Input
              BlocSelector<AttendanceBloc, AttendanceState, bool>(
                selector: (state) => state is AttendanceRunning,
                builder: (context, isRunning) {
                  return TextField(
                    controller: _tokenController,
                    decoration: const InputDecoration(
                      labelText: 'Bearer Token',
                      hintText: 'ey...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.security),
                    ),
                    obscureText: true,
                    enabled: !isRunning,
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: BlocSelector<AttendanceBloc, AttendanceState, (bool, bool)>(
                      selector: (state) => (state.saveTokenLocally, state is AttendanceRunning),
                      builder: (context, tuple) {
                        return CheckboxListTile(
                          title: const Text("Save token"),
                          value: tuple.$1,
                          onChanged: tuple.$2 ? null : (val) {
                            context.read<AttendanceBloc>().add(UpdateFormStateEvent(saveTokenLocally: val));
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocSelector<AttendanceBloc, AttendanceState, (bool, bool)>(
                      selector: (state) => (state.skipWeekends, state is AttendanceRunning),
                      builder: (context, tuple) {
                        return CheckboxListTile(
                          title: const Text("Skip Weekends"),
                          value: tuple.$1,
                          onChanged: tuple.$2 ? null : (val) {
                            context.read<AttendanceBloc>().add(UpdateFormStateEvent(skipWeekends: val));
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Reason / Remarks Input
              BlocSelector<AttendanceBloc, AttendanceState, bool>(
                selector: (state) => state is AttendanceRunning,
                builder: (context, isRunning) {
                  return TextField(
                    controller: _reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Reason / Remarks',
                      hintText: 'e.g. work from DN',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                    enabled: !isRunning,
                  );
                },
              ),
              const SizedBox(height: 16),

              // Action Selection
              Row(
                children: [
                  const Text("Actions:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  BlocSelector<AttendanceBloc, AttendanceState, (bool, bool)>(
                    selector: (state) => (state.submitAttendance, state is AttendanceRunning),
                    builder: (context, tuple) {
                      return FilterChip(
                        label: const Text("Attendance"),
                        selected: tuple.$1,
                        onSelected: tuple.$2 ? null : (selected) {
                          context.read<AttendanceBloc>().add(UpdateFormStateEvent(submitAttendance: selected));
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  BlocSelector<AttendanceBloc, AttendanceState, (bool, bool)>(
                    selector: (state) => (state.submitWorklog, state is AttendanceRunning),
                    builder: (context, tuple) {
                      return FilterChip(
                        label: const Text("Worklog"),
                        selected: tuple.$1,
                        onSelected: tuple.$2 ? null : (selected) {
                          context.read<AttendanceBloc>().add(UpdateFormStateEvent(submitWorklog: selected));
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Mode Selection
              Row(
                children: [
                  const Text("Date Mode:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  BlocSelector<AttendanceBloc, AttendanceState, (bool, bool)>(
                    selector: (state) => (state.isSingleDateMode, state is AttendanceRunning),
                    builder: (context, tuple) {
                      final isSingleDate = tuple.$1;
                      final isRunning = tuple.$2;
                      return Row(
                        children: [
                          ChoiceChip(
                            label: const Text("Range"),
                            selected: !isSingleDate,
                            onSelected: isRunning ? null : (selected) {
                              if (selected) {
                                context.read<AttendanceBloc>().add(const UpdateFormStateEvent(isSingleDateMode: false));
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            label: const Text("Single Day"),
                            selected: isSingleDate,
                            onSelected: isRunning ? null : (selected) {
                              if (selected) {
                                context.read<AttendanceBloc>().add(const UpdateFormStateEvent(isSingleDateMode: true));
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Date Selection
              BlocSelector<AttendanceBloc, AttendanceState, (DateTime?, DateTime?, bool, bool)>(
                selector: (state) => (state.startDate, state.endDate, state.isSingleDateMode, state is AttendanceRunning),
                builder: (context, tuple) {
                  final start = tuple.$1;
                  final end = tuple.$2;
                  final isSingleDate = tuple.$3;
                  final isRunning = tuple.$4;
                  
                  String dateRangeText = "No date selected";
                  if (start != null && end != null) {
                    if (start.day == end.day && start.month == end.month && start.year == end.year) {
                      dateRangeText = _formatDate(start);
                    } else {
                      dateRangeText = "${_formatDate(start)} to ${_formatDate(end)}";
                    }
                  }

                  return Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSingleDate ? 'Selected Date:' : 'Selected Date Range:',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Text(dateRangeText, style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: isRunning 
                                ? null 
                                : () => isSingleDate ? _pickSingleDate(context) : _pickDateRange(context),
                            icon: Icon(isSingleDate ? Icons.calendar_today : Icons.date_range),
                            label: Text(isSingleDate ? 'Select Date' : 'Select Dates'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // Worklog Input (Conditional)
              BlocSelector<AttendanceBloc, AttendanceState, bool>(
                selector: (state) => state.submitWorklog,
                builder: (context, submitWorklog) {
                  if (!submitWorklog) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: TextField(
                      controller: _worklogController,
                      maxLines: 5,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                      decoration: InputDecoration(
                        labelText: 'Daily Worklog Content',
                        hintText: '[Date: 2026-03-24]\n[09:00 - 13:00] Task details...\n[14:00 - 18:00] Next task details...\n\n[Date: 2026-03-25]\n[09:00 - 13:00] More tasks...',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                        alignLabelWithHint: true,
                        fillColor: Colors.white.withValues(alpha: 0.05),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Approve Pending Requests
              BlocSelector<AttendanceBloc, AttendanceState, bool>(
                selector: (state) => state is AttendanceRunning,
                builder: (context, isRunning) {
                  return OutlinedButton.icon(
                    onPressed: isRunning
                        ? null
                        : () {
                            final token = _tokenController.text.trim();
                            if (token.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter your Bearer token.')),
                              );
                              return;
                            }
                            context.read<AttendanceBloc>().add(
                                  ApproveAttendanceRequestsEvent(
                                    token: token,
                                    saveTokenLocally: context.read<AttendanceBloc>().state.saveTokenLocally,
                                  ),
                                );
                          },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text(
                      'Approve All Pending Requests',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Controls
              BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  final isRunning = state is AttendanceRunning;
                  return ElevatedButton(
                    onPressed: isRunning
                        ? null
                        : () {
                            final token = _tokenController.text.trim();
                            if (token.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter your Bearer token.')),
                              );
                              return;
                            }
                            if (state.startDate == null || state.endDate == null) {
                              return;
                            }
                            if (!state.submitAttendance && !state.submitWorklog) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select at least one action (Attendance or Worklog).')),
                              );
                              return;
                            }
                            if (state.submitWorklog && _worklogController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter a worklog.')),
                              );
                              return;
                            }
                            context.read<AttendanceBloc>().add(
                                  ExecuteAttendanceEvent(
                                    token: token,
                                    worklogText: _worklogController.text,
                                    reason: _reasonController.text.trim(),
                                  ),
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: isRunning
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Executing...',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : const Text(
                            'Execute',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Log Console
              const Text(
                'Execution Logs',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              BlocSelector<AttendanceBloc, AttendanceState, List<String>>(
                selector: (state) => state.logs,
                builder: (context, logs) {
                  return Container(
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: logs.isEmpty
                        ? const Center(
                            child: Text(
                              'Logs will appear here...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: logs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: SelectableText(
                                  logs[index],
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
