import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
