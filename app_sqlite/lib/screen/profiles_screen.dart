import 'package:app_sqlite/provider/local_database_provider.dart';
import 'package:app_sqlite/static/action_page_enum.dart';
import 'package:flutter/material.dart';
import 'package:app_sqlite/screen/form_screen.dart';
import 'package:app_sqlite/widgets/profile_card_widget.dart';
import 'package:provider/provider.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  bool _isFirstBuild = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstBuild) {
      context.read<LocalDatabaseProvider>().loadAllProfileValue();
      _isFirstBuild = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Profile Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Consumer<LocalDatabaseProvider>(
                builder: (context, value, child) {
                  if (value.profileList == null) {
                    return const SizedBox();
                  }

                  final profileList = value.profileList;
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: profileList!.length,
                    itemBuilder: (context, index) {
                      final profile = profileList[index];
                      return ProfileCardWidget(
                        profile: profile,
                        onTapRemove: () async {
                          if (profile.id != null) {
                            final localDatabaseProvider =
                                context.read<LocalDatabaseProvider>();
                            await localDatabaseProvider.removeProfileValueById(
                              profile.id!,
                            );
                            await localDatabaseProvider.loadAllProfileValue();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("This item cannot be deleted"),
                              ),
                            );
                          }
                        },
                        onTapEdit: () {
                          if (profile.id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FormScreen(
                                      actionPageEnum: ActionPageEnum.edit,
                                      profile: profile,
                                    ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("This item cannot be edited"),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const FormScreen(actionPageEnum: ActionPageEnum.add),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
