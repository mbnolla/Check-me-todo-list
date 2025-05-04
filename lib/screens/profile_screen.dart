// screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                child: Text(
                  user.displayName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              user.displayName,
              style: theme.textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              user.email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}