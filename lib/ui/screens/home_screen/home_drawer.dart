import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Matheus Bonfim'),
          ),
          ListTile(
            title: const Text('Perfil'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
