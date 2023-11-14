import 'package:flutter/material.dart';

import 'circular_avatar_button.dart';

class CustomAppBar extends AppBar{

  CustomAppBar({super.key});

  @override
  bool get automaticallyImplyLeading => false;
  @override
  Color? get backgroundColor => const Color(0xFFFFFFFF);
  @override
  double? get elevation => 0;
  @override
  double? get toolbarHeight => 70;
  @override
  Widget? get title => const Text("Descarte Bem");
  @override
  TextStyle? get titleTextStyle => const TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w400,
      fontSize: 22
  );
  @override
  bool? get centerTitle => true;
  @override
  List<Widget>? get actions => const [
    CircularAvatarButton()
  ];


}