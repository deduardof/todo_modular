import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_modular/src/home/home_page.dart';
import 'package:todo_modular/src/services/todos_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(TodosService.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
  }
}
