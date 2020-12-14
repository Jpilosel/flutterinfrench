import 'package:flutter/material.dart';
import 'package:flutterinfrench/screens/components/appbar_component.dart';
import 'package:flutterinfrench/screens/components/menu_component.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent.build(),
      drawer: MenuComponent(),
    );
  }
}