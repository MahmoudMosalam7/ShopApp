import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings Page',style: Theme.of(context).textTheme.bodyMedium,),);
  }
}