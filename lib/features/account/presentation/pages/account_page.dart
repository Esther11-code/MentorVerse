
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorverse/config/page%20route/page_route.dart';
import '../../../../constants/appcolors.dart';
import '../../../../globalwidget/export.dart';
import '../../../authentication/presentation/bloc/cubit/auth_cubit.dart';
import '../../../splash_onboarding/data/local/onboardingimages.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.login, (route) => false);
        }
      },
      child: AppScaffold(
          isloading: context.watch<AuthCubit>().state is AuthLoadingState,
          body: AppshadowContainer(
            shadowcolour: Appcolors.blue,
            color: Appcolors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: AppText(
                        text: 'Welcome Back!',
                        color: Appcolors.white,
                        size: 25,
                        fontweight: FontWeight.w600)),
                SizedBox(height: size.height * 0.03),
                const AcountpageUserInfo(),
                SizedBox(height: size.height * 0.06),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Appcolors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * 0.08),
                              topRight: Radius.circular(size.width * 0.08))),
                      padding: EdgeInsets.symmetric(
                          vertical: size.width * 0.03,
                          horizontal: size.width * 0.03),
                      width: size.width,
                      child: Column(children: [
                        AccountSelection(
                            size: size,
                            title: 'Account Details',
                            prefixIcon: Icons.account_circle,
                            onTap: () {
                              context.read<AuthCubit>().getUserInfo();
                              Navigator.pushNamed(
                                  context, RouteName.accountdetail);
                            }),
                        AccountSelection(
                            size: size,
                            prefixIcon: Icons.key,
                            title: 'Change Password',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.changepassword);
                            }),
                        AccountSelection(
                            size: size,
                            prefixIcon: Icons.contact_support,
                            title: 'Contact Us',
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.contactUs)),
                        AccountSelection(
                            size: size, prefixIcon: Icons.help, title: 'Help'),
                        SizedBox(height: size.height * 0.04),
                        Appbutton(
                            onTap: () => showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return const DelecteAcctDialog();
                                }),
                            height: size.height * 0.06,
                            label: 'Delete Account'),
                        SizedBox(height: size.height * 0.04),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                  text: 'Want to become a service provider? ',
                                  size: 14,
                                  color: Appcolors.blue),
                              GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, RouteName.kyc),
                                  child: AppText(
                                      maxline: 2,
                                      text: 'Click Here ',
                                      size: 16,
                                      fontweight: FontWeight.w600,
                                      color: Appcolors.orange)),
                            ])
                      ])),
                ),
              ],
            ),
          )),
    );
  }
}

class DelecteAcctDialog extends StatelessWidget {
  const DelecteAcctDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AcctDeletedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.login, (route) => false);
        }
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: AppshadowContainer(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppText(
                  text: 'Are you sure you want to delete your Account',
                  textalign: TextAlign.center,
                  fontweight: FontWeight.w500),
              SizedBox(height: size.height * 0.02),
              AppText(
                  text:
                      'If you Procced to delete, Your account will be permanently deleted and Can\'t be reversed. ',
                  size: 16,
                  color: Appcolors.blue,
                  textalign: TextAlign.center),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Appbutton(
                    onTap: () => Navigator.pop(context),
                    width: size.width * 0.36,
                    label: 'Cancel',
                  ),
                  Appbutton(
                    isLoading:
                        context.watch<AuthCubit>().state is AuthLoadingState,
                    onTap: () => context.read<AuthCubit>().deleteUser(),
                    width: size.width * 0.36,
                    label: 'OK',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AcountpageUserInfo extends StatelessWidget {
  const AcountpageUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final user = context.watch<AuthCubit>().user;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.25,
            height: size.width * 0.25,
            decoration: BoxDecoration(
                color: Appcolors.orange,
                image: const DecorationImage(
                    image: AssetImage(OnboardingImagesData.welcome)),
                borderRadius: BorderRadius.circular(size.width * 0.15)),
          ),
          SizedBox(
            width: size.width * 0.41,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                    text: '${user.firstName} ${user.lastname} ',
                    size: 16,
                    fontweight: FontWeight.w500,
                    color: Appcolors.white),
                SizedBox(height: size.height * 0.01),
                AppText(
                    text: '${user.email}',
                    color: Appcolors.white,
                    size: 15,
                    fontweight: FontWeight.w500)
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.read<AuthCubit>().logout(),
            child: Row(
              children: [
                Icon(Icons.logout_outlined,
                    size: 25.sp, color: Appcolors.orange),
                AppText(text: 'Sign Out', color: Appcolors.white, size: 14)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AccountSelection extends StatelessWidget {
  const AccountSelection(
      {super.key,
      required this.size,
      required this.prefixIcon,
      required this.title,
      this.onTap});

  final Size size;
  final IconData prefixIcon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.width * 0.03),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(prefixIcon, size: 28.sp),
                AppText(text: title, fontweight: FontWeight.w500, size: 16),
                Icon(Icons.arrow_forward_ios, size: 28.sp)
              ],
            ),
          ),
        ),
        Divider(color: Appcolors.blackColor.withOpacity(0.5))
      ],
    );
  }
}
