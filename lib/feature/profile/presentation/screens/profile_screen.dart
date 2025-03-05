import 'package:booki/core/themes/light_theme.dart';
import 'package:booki/core/utils/app_assets.dart';
import 'package:booki/feature/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:booki/feature/profile/presentation/screens/update_password.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booki/core/translations/locale_keys.g.dart';
import 'package:booki/core/utils/app_color.dart';
import 'package:booki/core/utils/extensions.dart';
import 'package:booki/feature/profile/presentation/screens/edit_profile.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.main,
          title: Text(
            LocaleKeys.profile.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppColor.white),
              onPressed: () {
                context.read<ProfileCubit>().logout(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  return ListView(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundImage: Image.network(state.image).image,
                          ),
                          16.W,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.name,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.main,
                                ),
                              ),
                              Text(state.email),
                            ],
                          ),
                        ],
                      ),
                      24.H,
                      _buildProfileOptions(context),
                    ],
                  );
                } else if (state is ProfileError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Center(child: Text("Unknown Error"));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final List<Map<String, dynamic>> profileItems = [
      {
        "title": LocaleKeys.editProfile.tr(),
        "icon": SvgPicture.asset(AppAssets.backIconSvg),
      },
      {"title": "My Orders", "icon": SvgPicture.asset(AppAssets.backIconSvg)},
      {
        "title": "Reset Password",
        "icon": SvgPicture.asset(AppAssets.backIconSvg),
      },
      {"title": "FAQ", "icon": SvgPicture.asset(AppAssets.backIconSvg)},
      {"title": "Contact Us", "icon": SvgPicture.asset(AppAssets.backIconSvg)},
      {
        "title": "Privacy & Terms",
        "icon": SvgPicture.asset(AppAssets.backIconSvg),
      },
    ];

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: profileItems.length,
      itemBuilder: (context, index) {
        final item = profileItems[index];

        return Container(
          margin: EdgeInsets.all(6.sp),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.darkGrey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(1, .1),
              ),
            ],
          ),
          child: ListTile(
            trailing: item["icon"],
            title: Text(
              item["title"],
              style: textStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.dark,
              ),
            ),
          ).withTapEffect(
            highlightColor: AppColor.secondary,
            onTap: () {
              if (item["title"] == "Reset Password") {
                context.push(UpdatePassword());
              } else if (item["title"] == LocaleKeys.editProfile.tr()) {
                context.push(EditProfile());
              }
            },
          ),
        );
      },
    );
  }
}
