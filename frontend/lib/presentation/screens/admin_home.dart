import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/presentation/widgets/admin_artist_mgt.dart';
import 'package:masinqo/presentation/widgets/admin_listener_mgt.dart';
import 'package:masinqo/presentation/widgets/admin_tabs.dart';
import 'package:masinqo/presentation/widgets/background.dart';

class AdminHome extends ConsumerWidget {
  final String tk;
  const AdminHome({super.key, required this.tk});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: const BackgroundGradient(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: TabBarView(
                children: [
                  AdminArtistMGT(),
                  AdminListenerMGT(),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              height: 55,
              child: AdminTabs(),
            ),
          ),
        ),
      ),
    );
  }
}
