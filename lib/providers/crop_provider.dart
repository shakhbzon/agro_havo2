import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "../services/notification_service.dart";

class CropProvider extends ChangeNotifier {
    late Box _cropBox;
    late Box _taskBox;
    List<dynamic> _crops = [];
    List<dynamic> _tasks = [];

    CropProvider() {
          _init();
    }

    List<dynamic> get crops => _crops;
    List<dynamic> get tasks => _tasks;

    Future<void> _init() async {
          _cropBox = Hive.box("crops_box");
          _taskBox = Hive.box("tasks_box");
          _loadData();
    }

    void _loadData() {
          _crops = _cropBox.values.toList();
          _tasks = _taskBox.values.toList();
          notifyListeners();
    }
}

  Future<void> addCrop(Map<String, dynamic> crop) async {
        await _cropBox.add(crop);
        _loadData();
  }

  Future<void> updateCrop(int index, Map<String, dynamic> crop) async {
        await _cropBox.putAt(index, crop);
        _loadData();
  }

  Future<void> deleteCrop(int index) async {
        await _cropBox.deleteAt(index);
        _loadData();
  }

  Future<void> addTask(Map<String, dynamic> task) async {
        await _taskBox.add(task);
        if (task["reminder"] == true) {
                NotificationService().scheduleNotification(
                          id: _tasks.length,
                          title: task["name"],
                          body: "Vazifa vaqti keldi",
                          scheduledDate: DateTime.parse(task["date"]),
                        );
        }
        _loadData();
  }

  Future<void> toggleTask(int index) async {
        var task = _taskBox.getAt(index);
        task["completed"] = !(task["completed"] ?? false);
        await _taskBox.putAt(index, task);
        _loadData();
  }

  Future<void> clearAll() async {
        await _cropBox.clear();
        await _taskBox.clear();
        _loadData();
  }
}

}
