import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crop_provider.dart';
import '../providers/weather_provider.dart';
import '../providers/locale_provider.dart';

class NotificationsScreen extends StatelessWidget {
    const NotificationsScreen({super.key});

    @override
    Widget build(BuildContext context) {
          final weather = Provider.of<WeatherProvider>(context);
          final cropProvider = Provider.of<CropProvider>(context);
          final t = Provider.of<LocaleProvider>(context);
          final activeTasks = cropProvider.todayTasks;
          final historyTasks = cropProvider.completedTasksHistory;

          return Scaffold(
                  backgroundColor: Colors.grey.shade50,
                  appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            iconTheme: const IconThemeData(color: Colors.black87),
                            title: Text(t.t('notifications'), style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                          ),
                  body: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                                      // Kunlik maslahat
                                                      Container(
                                                                      padding: const EdgeInsets.all(16),
                                                                      decoration: BoxDecoration(
                                                                                        color: const Color(0xFFF1F8E9),
                                                                                        borderRadius: BorderRadius.circular(16),
                                                                                        border: Border.all(color: const Color(0xFF0F9D58), width: 1.5),
                                                                                      ),
                                                                      child: Row(
                                                                                        children: [
                                                                                                            const Icon(Icons.lightbulb, size: 32, color: Color(0xFF0F9D58)),
                                                                                                            const SizedBox(width: 16),
                                                                                                            Expanded(
                                                                                                                                  child: Column(
                                                                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                                          children: [
                                                                                                                                                                                    Text(t.t('today_advice'), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F9D58), fontSize: 16)),
                                                                                                                                                                                    const SizedBox(height: 4),
                                                                                                                                                                                    Text(t.t(weather.agroAdvice), style: const TextStyle(color: Colors.black87, fontSize: 14)),
                                                                                                                                                                                  ],
                                                                                                                                                        ),
                                                                                                                                ),
                                                                                                          ],
                                                                                      ),
                                                                    ),
                                                      const SizedBox(height: 24),

                                                      // Faol vazifalar
                                                      Text(t.t('active_tasks'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                                                      const SizedBox(height: 12),
                                                      if (activeTasks.isEmpty)
                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                                                          child: Center(child: Text(t.t('no_active_tasks'), style: const TextStyle(color: Colors.grey))),
                                                                        )
                                                      else
                                                        ...activeTasks.map((task) => _buildActiveTaskCard(context, cropProvider, t, task)),

                                                      const SizedBox(height: 32),

                                                      // Tarix
                                                      Text(t.t('completed_history'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                                                      const SizedBox(height: 12),
                                                      if (historyTasks.isEmpty)
                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                                                          child: Center(child: Text(t.t('history_empty'), style: const TextStyle(color: Colors.grey))),
                                                                        )
                                                      else
                                                        ...historyTasks.map((taskData) => _buildHistoryCard(t, taskData)),
                                                    ],
                                      ),
                          ),
                );
    }

    Widget _buildActiveTaskCard(BuildContext context, CropProvider provider, LocaleProvider t, AgroTask task) {
          return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                  child: Column(
                            children: [
                                        Row(
                                                      children: [
                                                                      Text(task.icon, style: const TextStyle(fontSize: 24)),
                                                                      const SizedBox(width: 12),
                                                                      Expanded(child: Text(t.translateTaskTitle(task.title), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
                                                                    ],
                                                    ),
                                        const SizedBox(height: 12),
                                        Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                                      TextButton(
                                                                                        onPressed: () => provider.completeTask(task.id, task.title, task.icon),
                                                                                        child: Text(t.t('later'), style: const TextStyle(color: Colors.grey)),
                                                                                      ),
                                                                      const SizedBox(width: 8),
                                                                      ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(
                                                                                                            backgroundColor: const Color(0xFF0F9D58),
                                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                                                            elevation: 0,
                                                                                                          ),
                                                                                        onPressed: () {
                                                                                                            provider.completeTask(task.id, task.title, task.icon);
                                                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.t('task_completed')), backgroundColor: const Color(0xFF0F9D58)));
                                                                                        },
                                                                                        child: Text(t.t('done'), style: const TextStyle(color: Colors.white)),
                                                                                      ),
                                                                    ],
                                                    ),
                                      ],
                          ),
                );
    }

    Widget _buildHistoryCard(LocaleProvider t, Map<String, dynamic> taskData) {
          return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                  child: Row(
                            children: [
                                        Container(
                                                      padding: const EdgeInsets.all(8),
                                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                                                      child: Text(taskData['icon'] ?? 'Done', style: const TextStyle(fontSize: 20)),
                                                    ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                                      child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                                        Text(taskData['title'] != null ? t.translateTaskTitle(taskData['title']) : t.t('unknown_task'), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black87)),
                                                                                        const SizedBox(height: 4),
                                                                                        Text(taskData['date'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                                                                      ],
                                                                    ),
                                                    ),
                                        const Icon(Icons.check_circle, color: Color(0xFF0F9D58), size: 20),
                                      ],
                          ),
                );
    }
}
