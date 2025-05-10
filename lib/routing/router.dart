import 'package:go_router/go_router.dart';
import 'package:torneos_udea/ui/views/menu/menu_view.dart';
import 'package:torneos_udea/ui/views/reglamento/reglamento_view.dart';
import 'package:torneos_udea/ui/views/resoluciones/resoluciones_view.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: "/",
    routes: [
      // Ruta principal
      GoRoute(
        path: "/",
        builder: (context, state) => const MenuView(),
      ),
      GoRoute(
        path: "/reglamento",
        builder: (context, state) => const ReglamentoView(),
      ),
      GoRoute(
        path: "/resoluciones",
        builder: (context, state) => const ResolucionesView(),
      ),
    ],
  );
}
