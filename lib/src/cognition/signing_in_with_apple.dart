import 'package:json_utils/json_utils.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:percepts/percepts.dart';
import 'package:abstractions/beliefs.dart';
import 'package:types_for_auth/types_for_auth.dart';

import '../subsystems/sign_in_with_apple_subsystem.dart';
import '../utils/nonce.dart';

class SigningInWithApple<T extends CoreBeliefs> extends Consideration<T> {
  SigningInWithApple();

  /// From: `somewhere I can't remember now...`
  /// To prevent replay attacks with the credential returned from Apple, we
  /// include a nonce in the credential request. When signing in with
  /// Firebase, the nonce in the id token returned by Apple, is expected to
  /// match the sha256 hash of `rawNonce`.
  ///
  /// From: `firebase_auth_platform_interface-6.5.2/lib/src/providers/oauth.dart`:
  /// The raw nonce associated with the ID token. It is required when an ID
  /// token with a nonce field is provided. The SHA-256 hash of the raw nonce
  /// must match the nonce field in the ID token.

  // final nonce = sha256ofString(rawNonce);
  @override
  Future<void> consider(BeliefSystem<T> beliefSystem) async {
    var service = locate<SignInWithAppleSubsystem>();

    beliefSystem.conclude(UserAuthStateUpdated<T>(SignedInState.signingIn));

    String token = await service.signIn();

    beliefSystem.conclude(
      CredentialAdded<T>(
        newAppleCredential: token,
        nonce: generateNonce(),
      ),
    );

    /// Start any cognitions that were added to [OnAuthStateChange].
    locate<OnProviderAuthStateChange<T>>()
        .runAll(SignedInState.signedIn, beliefSystem);
  }

  @override
  JsonMap toJson() =>
      {'name_': 'SigningInWithApple', 'state_': <String, dynamic>{}};
}
