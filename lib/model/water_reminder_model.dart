class WaterReminderData {
  int? id;
  String? goal;
  String? waterDrunk;
  String? date;

  WaterReminderData({
    this.id,
    this.goal,
    this.waterDrunk,
    this.date,
  });

  WaterReminderData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    goal = map['goal'];
    waterDrunk = map['waterDrunk'];
    date = map['date'];
  }
}
