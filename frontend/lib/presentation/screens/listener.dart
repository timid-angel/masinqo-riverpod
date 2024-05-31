import 'package:flutter/material.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/screens/listener_favorites.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_tabs.dart';

class ListenerWidget extends StatefulWidget {
  final String arguments;

  const ListenerWidget({
    super.key,
    required this.arguments,
  });

  @override
  State<ListenerWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  late String token;
  @override
  void initState() {
    super.initState();
    token = widget.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.black,
        endDrawer: ListenerDrawer(
          token: token,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              const ListenerAppbar(),
            ];
          },
          body: TabBarView(
            children: [
              ListenerHome(
                token: token,
              ),
              ListenerFavorites(
                token: token,
              ),
              ListenerLibrary(
                token: token,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }
}
