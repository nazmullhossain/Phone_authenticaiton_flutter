import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';



class OTPScreen extends StatefulWidget {

  const OTPScreen({Key? key,required this.phone}) : super(key: key);
  final String phone;


  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey=GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController=TextEditingController();
  final FocusNode _pinPutFocusNode= FocusNode();
  final BoxDecoration pinPutDecoration=BoxDecoration(
    color: Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Color.fromRGBO(126, 203, 224, 1)
    )
  );
  @override
  void initState(){
    super.initState();
    _verifyPhone();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Otp verification'),
        backgroundColor: Colors.teal[800],

      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                "verify ${widget.phone} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
          child: Pinput(
            length: 6,
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            pinAnimationType: PinAnimationType.fade,
            onSubmitted: (pin)async{

              try {
                await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: _verificationCode, smsCode: pin))
                    .then((value)  {
                  CupertinoAlertDialog(
                    title: Text("Phone Authentication"),
                    content: Text('Phone Number Verified'),
                    actions: [
                      CupertinoButton(
                          child: Text('Close'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          }),
                    ],
                  );
                } );
              }catch (e){
                FocusScope.of(context).unfocus();
                _scaffoldkey.currentState
                    ?.showSnackBar(SnackBar(content: Text('invalid OTP')));
              }
            },


          ),
          )

        ],
      ),
    );
  }


  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+88${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            CupertinoAlertDialog(
              title: Text("Phone Authentication"),
              content: Text("Phone Number verified!!!"),
              actions: [
                CupertinoButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: ( verficationID,  resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }



}
