import 'package:decarte_bem/ui/views/home_page.dart';
import 'package:decarte_bem/ui/views/login_page.dart';
import 'package:get/get.dart';

part './app_routes.dart';

abstract class Pages{

  static final pages = [
    GetPage(name: Routes.HOME, page:() => const HomePage()),
    GetPage(name: Routes.LOGIN, page:() => const LoginPage()),
  ];
}
