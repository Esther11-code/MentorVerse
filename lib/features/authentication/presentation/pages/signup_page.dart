import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorverse/globalwidget/export.dart';
import '../../../../config/page route/page_route.dart';
import '../../../splash_onboarding/data/local/onboardingimages.dart';
import '../bloc/cubit/auth_cubit.dart';
import '../src/auth_widgets_export.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthTokenSentState) {
          Navigator.pushNamed(context, RouteName.emailotp);
        }
      },
      child: AppScaffold(
        isloading: context.watch<AuthCubit>().state is AuthLoadingState,
        body: Column(children: [
          Image.asset(OnboardingImagesData.welcome,
              height: size.height * 0.15, width: size.width * 0.9),
          Form(
            key: formKey,
            child: Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                children: [
                  const AppText(
                      text: 'Create New Account', fontweight: FontWeight.w500),
                  SizedBox(height: size.height * 0.01),
                  const SignupFirstnameTextfield(),
                  15.verticalSpace,
                  const SignupEmailTextfield(),
                  15.verticalSpace,
                  const SignupPhoneTextField(),
                  15.verticalSpace,
                  const SignupPasswodTextfield(),
                  15.verticalSpace,
                  const SigupTermsAndCondition(),
                  SizedBox(height: size.height * 0.04),
                  SignupButton(formKey: formKey),
                  SizedBox(height: size.height * 0.02),
                  SignupOrLogin(
                      ontap: () {
                        Navigator.pushNamed(context, RouteName.login);
                      },
                      subTitle: 'Login',
                      title: 'Already have an account?'),
                  SizedBox(height: size.height * 0.04),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
