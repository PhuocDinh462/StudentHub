import 'package:flutter/material.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/screens/account/widgets/user_item.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Users
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ListTileTheme(
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                horizontalTitleGap: 10,
                minLeadingWidth: 0,
                child: ExpansionTile(
                  leading: const Icon(Icons.school_outlined, size: 46),
                  title: Text(
                    'Hai Pham',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    'Student',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  children: const <Widget>[
                    Gap(5),
                    Row(
                      children: [
                        Gap(30),
                        UserItem(
                            username: 'Hai Pham', userType: UserType.company),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
                height: 40, thickness: .5, endIndent: 0, color: text_400),

            // Others setting
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(Icons.account_box, size: 32),
                    const Gap(10),
                    Text(
                      'Profiles',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 50,
              thickness: .5,
              indent: 20,
              endIndent: 20,
              color: text_400,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/account/settings'),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(Icons.settings, size: 32),
                    const Gap(10),
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 50,
              thickness: .5,
              indent: 20,
              endIndent: 20,
              color: text_400,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(Icons.lock, size: 32),
                    const Gap(10),
                    Text(
                      'Change password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 50,
              thickness: .5,
              indent: 20,
              endIndent: 20,
              color: text_400,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded,
                        size: 32, color: Colors.red),
                    const Gap(10),
                    Text(
                      'Logout',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
