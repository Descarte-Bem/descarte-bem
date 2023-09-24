import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controllers/login_controller.dart';
import '../views/home_page.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? leading;
  final List<Widget> actionsparam;
  final Widget titleparam;
  const CustomAppBar({super.key,
    required this.actionsparam,
    this.leading,
    required this.titleparam
  });
  @override
  Widget build(BuildContext context) {


    return AppBar(
      title: titleparam,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: actionsparam,
    );
    throw UnimplementedError();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70.0);
  
  
  
}