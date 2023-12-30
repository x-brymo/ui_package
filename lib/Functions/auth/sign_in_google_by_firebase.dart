import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInGoogleByFirebaseAuth{
  ////* [HafezCodx] clinet ID google
  // 408175319305-qjq5ajvr8qs6g5li6j4u4r00mes3o2on.apps.googleusercontent.com
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final googleSignIn = GoogleSignIn.standard(scopes: [ga.DriveApi.driveAppdataScope]);
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    signInOption:SignInOption.standard ,
    clientId: '408175319305-qjq5ajvr8qs6g5li6j4u4r00mes3o2on.apps.googleusercontent.com',
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/drive.metadata.readonly'
     
    ]
  );

   Future<void> googleSignUp() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with Google credentials
        await _auth.signInWithCredential(credential);
         print(credential.toString());
        // Navigate to the desired screen after successful sign-in
        // For example:
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Google Sign-In was canceled
      }
    } catch (e) {
      // Handle the error
      print("Google Sign-In Error: $e");
    }
  }
  //final auth = SignInGoogleByFirebaseAuth.googleSignUp();
  

}
