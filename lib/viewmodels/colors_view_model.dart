
import 'package:flutter/material.dart';

import '../data/colors_repository.dart';


class ColorsViewModel extends ChangeNotifier {
  final ColorsRepository? colorsRepository;
  bool fetchingColors = false;
  bool clearingColors = false;

  ColorsViewModel(this.colorsRepository);

  fetchColors() async {
    fetchingColors = true;
    notifyListeners();
    await colorsRepository!.fetchColors();
    fetchingColors = false;
    notifyListeners();
  }

  clearColors() async {
    clearingColors = true;
    notifyListeners();
    await colorsRepository!.clearColors();
    clearingColors = false;
    notifyListeners();
  }
}
