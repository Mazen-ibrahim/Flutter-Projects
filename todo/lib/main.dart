import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskController());
  await GetStorage.init();
  await DBHelper.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
