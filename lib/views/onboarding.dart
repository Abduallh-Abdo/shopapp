import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shopapp/auth/login/shop_login_screen.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/helper/shared_preference/shared_pref.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        // Page 1
        PageViewModel(
          title: "Welcome to MyApp",
          body: "Let's make a new journy in my app",
          image: const Center(
            child: Icon(
              Icons.waving_hand,
              size: 100.0,
            ),
          ),
        ),
        // Page 2
        PageViewModel(
          title: "Explore Features",
          body: "Stay up to date with the latest shops.",
          image: const Center(
            child: Icon(
              Icons.notifications_active,
              size: 100.0,
            ),
          ),
        ),
        // Page 3
        PageViewModel(
          title: "Get Started",
          body: "Ready to get started?  Let's go!",
          image: const Center(
            child: Text(
              "🚀",
              style: TextStyle(
                fontSize: 100.0,
              ),
            ),
          ),
        ),
      ],
      onDone: () {
        CacheHelper.saveData(
          key: 'onBoarding',
          value: true,
        ).then(
          (value) {
            if (value) {
              navigateAndFinish(
                context: context,
                widget: const ShopLoginScreen(),
              );
            }
          },
        );
      },
      curve: Easing.emphasizedAccelerate,
      done: Text(
        "Get Started",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: Theme.of(context)
            .textTheme
            .titleMedium, // Applying the titleLarge style
      ),
      next: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        child: const Icon(
          Icons.arrow_forward,
        ),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: Colors.lightGreen,
        size: const Size(
          15.0,
          10.0,
        ),
        activeSize: const Size(
          30.0,
          10.0,
        ),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }
}
