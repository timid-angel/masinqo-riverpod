import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/admin/admin_state.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners_repository_interface.dart';

class AdminListenerNotifier extends StateNotifier<AdminListenersState> {
  final AdminListenerRepositoryInterface adminListenerRepo;

  AdminListenerNotifier({required this.adminListenerRepo})
      : super(AdminListenersState(listeners: [])) {
    getListeners();
  }

  Future<void> getListeners() async {
    final res =
        await AdminListenerCollection(adminListenersRepo: adminListenerRepo)
            .getListeners();

    res.fold((l) {
      final newState = AdminListenersState(listeners: []);
      newState.errorMessages = l.message;
      state = newState;
    }, (r) {
      final newState = AdminListenersState(listeners: r.listeners);
      state = newState;
    });
  }

  Future<void> deleteListener(String listenerId) async {
    final res =
        await AdminListenerCollection(adminListenersRepo: adminListenerRepo)
            .deleteListener(listenerId);

    res.fold((l) {
      AdminListenersState newState =
          AdminListenersState(listeners: state.listeners);
      newState.errorMessages = l.message;
      state = newState;
    }, (r) {
      final List<AdminListener> res = [];
      for (int i = 0; i < state.listeners.length; i++) {
        if (state.listeners[i].id != listenerId) {
          res.add(state.listeners[i]);
        }
      }

      state = AdminListenersState(listeners: res);
    });
  }
}
