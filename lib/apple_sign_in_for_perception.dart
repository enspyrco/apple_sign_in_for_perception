library apple_sign_in_for_perception;

import 'package:abstractions/beliefs.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:percepts/percepts.dart';

import 'src/subsystems/sign_in_with_apple_subsystem.dart';

///
export 'src/cognition/signing_in_with_apple.dart';
export 'src/views/apple_sign_in_button.dart';

void initializeAppleSignIn<S extends CoreBeliefs>({
  List<Consideration<S>>? considerOnSignedIn,
  List<Conclusion<S>>? concludeOnSignedIn,
  List<Consideration<S>>? considerOnSignedOut,
  List<Conclusion<S>>? concludeOnSignedOut,
}) {
  /// Add the [OnProviderAuthStateChange] object to the locator, which will be
  /// used to start cognitions at given auth state change events.
  Locator.add<OnProviderAuthStateChange<S>>(
    OnProviderAuthStateChange<S>(
      considerOnSignedIn: considerOnSignedIn,
      concludeOnSignedIn: concludeOnSignedIn,
      considerOnSignedOut: considerOnSignedOut,
      concludeOnSignedOut: concludeOnSignedOut,
    ),
  );

  /// Create and add a FirebaseAuthService to the Locator
  Locator.add<SignInWithAppleSubsystem>(SignInWithAppleSubsystem());
}
