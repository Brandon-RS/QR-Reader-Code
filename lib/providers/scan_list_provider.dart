import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    // Assign database id to model
    newScan.id = id;

    if (typeSelected == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.allScan();
    this.scans = [...scans!];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans!];
    typeSelected = type;
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    // loadScansByType(typeSelected);
  }

  deleteAll() async {
    await DBProvider.db.deleteALlScans();
    scans = [];
    notifyListeners();
  }

  deleteScansByType(String type) async {
    await DBProvider.db.deleteScansByType(type);
    scans = [];
    notifyListeners();
  }
}
