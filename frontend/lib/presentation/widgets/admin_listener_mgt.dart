import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/admin/admin_providers.dart';
import 'package:masinqo/application/auth/auth_providers.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';
import 'package:masinqo/presentation/widgets/admin_header.dart';
import 'delete_confirmation_modal.dart';

class AdminListenerMGT extends ConsumerWidget {
  const AdminListenerMGT({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tk = ref.read(adminLoginProvider).token;
    final state = ref.watch(listenerProvider(tk));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AdminHeader(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              'Listeners',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          state.listeners.isEmpty
              ? Expanded(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/empty_list.png"))),
                      height: 400,
                      width: 400,
                    ),
                  ),
                )
              : Expanded(
                  child: ListenerList(listenerData: state.listeners),
                ),
        ],
      ),
    );
  }
}

class ListenerList extends ConsumerWidget {
  final List<AdminListener> listenerData;
  const ListenerList({
    super.key,
    required this.listenerData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tk = ref.read(adminLoginProvider).token;
    final provider = listenerProvider(tk);
    return ListView.builder(
      itemCount: listenerData.length,
      itemBuilder: (context, index) {
        final listener = listenerData[index];
        return ListTile(
          minLeadingWidth: 20,
          minVerticalPadding: 20,
          leading: const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/u.png'),
          ),
          title: Text(listener.name),
          subtitle: Text(listener.email,
              style:
                  const TextStyle(color: Color.fromARGB(255, 193, 191, 191))),
          textColor: Colors.white,
          subtitleTextStyle: const TextStyle(color: Colors.white70),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  void emitDeleteEvent() {
                    ref.read(provider.notifier).deleteListener(listener.id);
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteConfirmationDialog(
                        title: 'Are you sure you want to delete this Listener?',
                        onConfirm: () {
                          emitDeleteEvent();
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                tooltip: 'Delete',
                color: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }
}
