// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:newapp/Firebase%20Services/google_signin.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// class MockGoogleSignIn extends Mock implements GoogleSignIn {}
// class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
// class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}
// class MockAuthCredential extends Mock implements AuthCredential {}
// class MockSharedPreferences extends Mock implements SharedPreferences {}
//
// void main() {
//   group('FirebaseServices Tests', () {
//     FirebaseServices firebaseServices;
//     MockFirebaseAuth mockFirebaseAuth;
//     MockGoogleSignIn mockGoogleSignIn;
//     MockGoogleSignInAccount mockGoogleSignInAccount;
//     MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
//     MockAuthCredential mockAuthCredential;
//     MockSharedPreferences mockSharedPreferences;
//
//     setUp(() {
//       mockFirebaseAuth = MockFirebaseAuth();
//       mockGoogleSignIn = MockGoogleSignIn();
//       mockGoogleSignInAccount = MockGoogleSignInAccount();
//       mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
//       mockAuthCredential = MockAuthCredential();
//       mockSharedPreferences = MockSharedPreferences();
//
//       firebaseServices = FirebaseServices();
//       firebaseServices.auth = mockFirebaseAuth;
//       firebaseServices.googleSignIn = mockGoogleSignIn;
//     });
//
//     test('signInWithGoogle() should sign in with Google credentials', () async {
//       firebaseServices.auth = mockFirebaseAuth; // Set the auth object here
//       // Mock the necessary methods for signInWithGoogle
//       when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
//       when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
//       when(mockGoogleSignInAuthentication.accessToken).thenReturn('access_token');
//       when(mockGoogleSignInAuthentication.idToken).thenReturn('id_token');
//       when(mockAuthCredential.accessToken).thenReturn('access_token');
//       when(mockAuthCredential.idToken).thenReturn('id_token');
//
//       await firebaseServices.signInWithGoogle();
//
//       verify(mockFirebaseAuth.signInWithCredential(mockAuthCredential));
//     });
//
//     test('saveUserToken() should save the user token in SharedPreferences', () async {
//       when(mockSharedPreferences.setString('userToken', 'access_token')).thenAnswer((_) => Future.value(true));
//       await firebaseServices.saveUserToken('access_token');
//       verify(mockSharedPreferences.setString('userToken', 'access_token'));
//     });
//
//     test('signUpWithGoogle() should sign up with Google credentials', () async {
//       when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
//       when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
//       when(mockGoogleSignInAuthentication.accessToken).thenReturn('access_token');
//       when(mockGoogleSignInAuthentication.idToken).thenReturn('id_token');
//       when(mockAuthCredential.accessToken).thenReturn('access_token');
//       when(mockAuthCredential.idToken).thenReturn('id_token');
//
//       await firebaseServices.signUpWithGoogle();
//
//       verify(mockFirebaseAuth.signInWithCredential(mockAuthCredential));
//     });
//
//     test('googleSignOut() should sign out from Firebase and Google Sign-In', () async {
//       await firebaseServices.googleSignOut();
//
//       verify(mockFirebaseAuth.signOut());
//       verify(mockGoogleSignIn.signOut());
//     });
//   });
// }
