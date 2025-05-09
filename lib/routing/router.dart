import 'package:go_router/go_router.dart';
import 'package:torneos_udea/ui/views/menu/menu_view.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: "/",
    routes: [
      // Ruta principal
      GoRoute(
        path: "/",
        builder: (context, state) => const MenuView(),
      ),
    ],
  );
}
