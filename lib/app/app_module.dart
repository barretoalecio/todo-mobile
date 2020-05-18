import 'package:dio/dio.dart';
import 'package:todo_mobile/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:todo_mobile/app/app_widget.dart';
import 'package:todo_mobile/app/modules/home/home_module.dart';
import 'package:todo_mobile/app/repositories/TaskRepository.dart';
import 'package:todo_mobile/app/utils/constants.dart';

import 'modules/home/home_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => HomeController(i.get<TaskRepository>())),
        Bind((i) => TaskRepository(i.get<Dio>())),
        Bind((i) => Dio(BaseOptions(baseUrl: API_URL)))
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
