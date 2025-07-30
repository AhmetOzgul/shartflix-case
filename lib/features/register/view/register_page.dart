import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/register_state.dart';
import '../bloc/register_bloc.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../core/utils/validators.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/social_buttons.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const _RegisterViewContent(),
    );
  }
}

class _RegisterViewContent extends StatefulWidget {
  const _RegisterViewContent();

  @override
  State<_RegisterViewContent> createState() => _RegisterViewContentState();
}

class _RegisterViewContentState extends State<_RegisterViewContent> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final registerBloc = context.read<RegisterBloc>();
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "register.title".tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "register.description".tr(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 35,
                                        bottom: 16,
                                      ),
                                      child: CustomTextFormField(
                                        controller: _nameController,
                                        labelText: 'register.name'.tr(),
                                        prefixIcon: Icons.person_outlined,
                                        validator: Validators.validateName,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: CustomTextFormField(
                                        controller: _emailController,
                                        labelText: 'register.email'.tr(),
                                        prefixIcon: Icons.email_outlined,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: Validators.validateEmail,
                                      ),
                                    ),
                                    CustomTextFormField(
                                      controller: _passwordController,
                                      labelText: 'register.password'.tr(),
                                      prefixIcon: Icons.lock_open_outlined,
                                      obscureText: !state.isPasswordVisible,
                                      suffixIcon: state.isPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      onSuffixIconPressed:
                                          registerBloc.togglePasswordVisibility,
                                      validator: Validators.validatePassword,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 10,
                                      ),
                                      child: CustomTextFormField(
                                        controller: _confirmPasswordController,
                                        labelText: 'register.confirm_password'
                                            .tr(),
                                        prefixIcon: Icons.lock_open_outlined,
                                        obscureText: !state.isPasswordVisible,
                                        suffixIcon: state.isPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        onSuffixIconPressed: registerBloc
                                            .togglePasswordVisibility,
                                        validator: (value) =>
                                            Validators.validateConfirmPassword(
                                              value,
                                              _passwordController.text,
                                            ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: _isTermsAccepted,
                                            onChanged: (value) {
                                              setState(() {
                                                _isTermsAccepted =
                                                    value ?? false;
                                              });
                                            },
                                            activeColor: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                          Expanded(
                                            child: _buildTermsText(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (state is RegisterError &&
                                        state.message.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          state.message,
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    if (state is RegisterSuccess)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          state.message,
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: PrimaryButton(
                                        text: 'register.register_button'.tr(),
                                        isLoading: state is RegisterLoading,
                                        onPressed:
                                            (state is RegisterLoading ||
                                                !_isTermsAccepted)
                                            ? null
                                            : () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  registerBloc.register(
                                                    context,
                                                    _nameController.text,
                                                    _emailController.text,
                                                    _passwordController.text,
                                                  );
                                                }
                                              },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: const SocialButtons(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 24,
                                  top: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "register.has_account".tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.6),
                                          ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.go(AppRoutes.login);
                                      },
                                      child: Text(
                                        "register.login_button".tr(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTermsText(BuildContext context) {
    final String fullText = 'register.terms_accept'.tr();
    final List<InlineSpan> spans = [];

    final RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    final Match? match = regex.firstMatch(fullText);

    if (match != null) {
      final int startIndex = match.start;
      final int endIndex = match.end;
      final String beforeText = fullText.substring(0, startIndex);
      final String linkText = match.group(1)!;
      final String afterText = fullText.substring(endIndex);

      if (beforeText.isNotEmpty) {
        spans.add(TextSpan(text: beforeText));
      }

      spans.add(
        WidgetSpan(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              linkText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      );

      if (afterText.isNotEmpty) {
        spans.add(TextSpan(text: afterText));
      }
    } else {
      spans.add(TextSpan(text: fullText));
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.6),
        ),
        children: spans,
      ),
    );
  }
}
