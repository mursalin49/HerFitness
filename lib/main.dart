import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Helpers/route.dart';
import 'utils/AppTheme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          getPages: AppRoutes.page,
          initialRoute: AppRoutes.splashScreen,
        );
      },
    );
  }
}
