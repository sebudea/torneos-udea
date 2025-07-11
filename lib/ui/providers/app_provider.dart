import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  bool build() {
    return false; // Estado inicial
  }

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
