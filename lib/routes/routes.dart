import 'package:flutter/material.dart';
import 'package:qr_reader/pages/all_scans_page.dart';
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/map_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() => <String, WidgetBuilder>{
      '/home_page': (BuildContext context) => const HomePage(),
      '/map_page': (BuildContext context) => const MapPage(),
      '/all_scans_page': (BuildContext context) => const AllScansPage(),
    };
