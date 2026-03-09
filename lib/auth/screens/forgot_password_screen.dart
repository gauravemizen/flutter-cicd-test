import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _handleResetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Back button
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 40),
                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _emailSent
                              ? Icons.mark_email_read_outlined
                              : Icons.lock_reset_rounded,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _emailSent ? 'Check Your Email' : 'Forgot Password?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          _emailSent
                              ? 'We have sent a password reset link to ${_emailController.text}'
                              : "Don't worry! Enter your email address and we'll send you a link to reset your password.",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                if (!_emailSent) ...[
                  // Email field
                  AuthTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 32),
                  // Reset password button
                  AuthButton(
                    text: 'Reset Password',
                    isLoading: _isLoading,
                    onPressed: _handleResetPassword,
                  ),
                ] else ...[
                  // Success state
                  _buildSuccessMessage(context),
                  const SizedBox(height: 32),
                  AuthButton(
                    text: 'Open Email App',
                    icon: Icons.email_outlined,
                    onPressed: () {
                      // Open email app - you can use url_launcher package
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Opening email app...'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthButton(
                    text: 'Back to Login',
                    isOutlined: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                const SizedBox(height: 32),
                if (!_emailSent)
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Email Sent Successfully!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your inbox and follow the instructions to reset your password.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the email? ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _emailSent = false;
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Try again',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
