import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// The [sign_in_with_apple] package uses static methods so to allow testing
/// we use a wrapper class with methods that call the plugin's static methods.
class SignInWithAppleWrapper {
  const SignInWithAppleWrapper();

  Future<AuthorizationCredentialAppleID> getAppleIDCredential(
          {required List<AppleIDAuthorizationScopes> scopes,
          String? nonce}) async =>
      SignInWithApple.getAppleIDCredential(scopes: scopes, nonce: nonce);
}
