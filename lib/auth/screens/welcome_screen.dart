import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/auth_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const AppLogo(size: 120),
              const SizedBox(height: 32),
              Text(
                'Welcome to Flutter Auth',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Your secure and seamless\nauthentication solution',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              AuthButton(
                text: 'Login',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              AuthButton(
                text: 'Create Account',
                isOutlined: true,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

