import 'package:aphone/verification.dart';
import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController phoneNumber= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white70,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneNumber,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter your phone number",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.phone
                  ),

                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)
                    =>OTPScreen(phone: phoneNumber.text,),
                    ),
                );
              },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Get OTP"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
