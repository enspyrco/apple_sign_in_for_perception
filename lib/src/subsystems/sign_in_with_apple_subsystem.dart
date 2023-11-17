import 'package:sign_in_with_apple/sign_in_with_apple.dart' as plugin;

import '../utils/typedefs.dart';
import 'sign_in_with_apple_wrapper.dart';

class SignInWithAppleSubsystem {
  SignInWithAppleSubsystem({SignInWithAppleWrapper? plugin})
      : _plugin = plugin ?? const SignInWithAppleWrapper();

  final SignInWithAppleWrapper _plugin;

  // Request credential for the currently signed in Apple account & return token
  Future<String> signIn() async {
    final AppleCredential credential = await _plugin.getAppleIDCredential(
      scopes: [
        plugin.AppleIDAuthorizationScopes.email,
        plugin.AppleIDAuthorizationScopes.fullName,
      ],
    );

    return credential.identityToken ??
        (throw 'The credential.identityToken variable was null');
  }
}
