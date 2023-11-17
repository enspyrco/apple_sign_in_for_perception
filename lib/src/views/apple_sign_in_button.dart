import 'package:abstractions/beliefs.dart';
import 'package:flutter/widgets.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as plugin;

import '../../apple_sign_in_for_perception.dart';

class AppleSignInButton<T extends CoreBeliefs> extends StatelessWidget {
  const AppleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return plugin.SignInWithAppleButton(
      onPressed: () => locate<BeliefSystem<T>>().consider(
        SigningInWithApple<T>(),
      ),
    );
  }
}
