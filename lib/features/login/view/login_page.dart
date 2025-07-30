import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/login/bloc/login_state.dart';
import '../bloc/login_viewmodel.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../core/utils/validators.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const _LoginViewContent(),
    );
  }
}

class _LoginViewContent extends StatefulWidget {
  const _LoginViewContent();

  @override
  State<_LoginViewContent> createState() => _LoginViewContentState();
}

class _LoginViewContentState extends State<_LoginViewContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final loginBloc = context.read<LoginBloc>();
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
                                      "login.title".tr(),
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
                                        "login.description".tr(),
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
                                        controller: _emailController,
                                        labelText: 'login.email'.tr(),
                                        prefixIcon: Icons.email_outlined,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: Validators.validateEmail,
                                      ),
                                    ),
                                    CustomTextFormField(
                                      controller: _passwordController,
                                      labelText: 'login.password'.tr(),
                                      prefixIcon: Icons.lock_open_outlined,
                                      obscureText: !loginBloc.isPasswordVisible,
                                      suffixIcon: loginBloc.isPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      onSuffixIconPressed:
                                          loginBloc.togglePasswordVisibility,
                                      validator: Validators.validatePassword,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 10,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "login.forgot_password".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    if (state is LoginError &&
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
                                    if (state is LoginSuccess)
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
                                        text: 'login.login_button'.tr(),
                                        isLoading: state is LoginLoading,
                                        onPressed: state is LoginLoading
                                            ? null
                                            : () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  loginBloc.login(
                                                    context,
                                                    _emailController.text,
                                                    _passwordController.text,
                                                  );
                                                }
                                              },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                          _mockSocialButton(
                                            Icons.g_mobiledata_outlined,
                                            iconSize: 40,
                                          ),
                                          _mockSocialButton(
                                            Icons.apple_outlined,
                                          ),
                                          _mockSocialButton(
                                            Icons.facebook_outlined,
                                          ),
                                        ],
                                      ),
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
                                      "login.no_account".tr(),
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
                                      onPressed: () {},
                                      child: Text(
                                        "login.register_button".tr(),
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

  Widget _mockSocialButton(IconData icon, {double? iconSize = 30}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
        ),
      ),
      child: Icon(icon, color: Colors.white, size: iconSize ?? 30),
    );
  }
}
