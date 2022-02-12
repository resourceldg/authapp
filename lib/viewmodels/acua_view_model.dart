



import 'package:flutter/material.dart';

import '../data/acua_mvp_repostory.dart';


class AcuaViewModel extends ChangeNotifier {
  final AcuaMvpRepository? mvpRepository;
  bool fetchingSensors = false;
  bool clearingSensors = false;

  AcuaViewModel(this.mvpRepository);

  fetchColors() async {
    fetchingSensors = true;
    notifyListeners();
    await mvpRepository!.fetchSensors();
    fetchingSensors = false;
    notifyListeners();
  }

  clearColors() async {
    clearingSensors = true;
    notifyListeners();
    await mvpRepository!.clearSensorSubscription();
    clearingSensors = false;
    notifyListeners();
  }
}
