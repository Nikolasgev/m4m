import 'package:hive/hive.dart';

import '../models/checkin_model.dart';

class CheckinLocalDataSource {
  final Box<CheckinModel> _checkinBox;

  CheckinLocalDataSource(this._checkinBox);

  Future<void> addCheckin(CheckinModel checkin) async {
    await _checkinBox.add(checkin);
  }

  List<CheckinModel> getCheckins() {
    return _checkinBox.values.toList();
  }
}
