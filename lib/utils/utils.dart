import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.value;

  if (scan.type == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cloud not launch $url';
    }
  } else {
    Navigator.pushNamed(context, '/map_page', arguments: scan);
  }
}
