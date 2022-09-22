import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class otpverify extends StatefulWidget {
  const otpverify({Key? key}) : super(key: key);

  @override
  State<otpverify> createState() => _otpverifyState();
}

class _otpverifyState extends State<otpverify> {
  TextEditingController tcontact = TextEditingController();
  String smsCode='';
  String mverificationid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("otp veridication"),
      ),
      body: Column(
        children: [
          TextField(
            controller: tcontact,
          ),
          ElevatedButton(
              onPressed: () async {
                String contact = tcontact.text;
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+91$contact',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    mverificationid=verificationId;
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: Text("send otp")),
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {
            },
            onSubmit: (String verificationCode){
              smsCode=verificationCode;
            }, // end onSubmit
          ),
          ElevatedButton(
              onPressed: () {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: mverificationid, smsCode: smsCode);
                FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                  print(value);
                  print("sucess");
                });
              },
              child: Text("otp verify"))
        ],
      ),
    );
  }
}
