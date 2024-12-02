import 'package:flutter/material.dart';
import 'package:clima_app/helpers/preferences.dart';
import 'package:clima_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class BackgroundDetector extends StatefulWidget {
  const BackgroundDetector({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<BackgroundDetector> createState() => _BackgroundDetectorState();
}

class _BackgroundDetectorState extends State<BackgroundDetector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final temaProvider = Provider.of<ThemeProvider>(context, listen: false);
      temaProvider.setTheme(Preferences.getTheme());
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
