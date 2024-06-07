import 'package:blood_donation/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double kheight = MediaQuery.of(context).size.height - kToolbarHeight;
    // double kwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: kheight * 0.05),
            Text('Hey There'),
            Text(
              'Welcome to\nBlood Donation App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kheight * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kheight * 0.04),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Username',
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(kheight * 0.025)))),
                controller: usernameController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  kheight * 0.04, 0, kheight * 0.04, kheight * 0.04),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Mail',
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(kheight * 0.025)))),
                controller: emailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  kheight * 0.04, 0, kheight * 0.04, kheight * 0.04),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(kheight * 0.025)))),
                controller: passwordController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Sign in'))
              ],
            ),
            SizedBox(
              height: kheight * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                print("ElevatedButt :${usernameController.text}");
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .then(
                  (value) {
                    print('Created new account');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                ).onError(
                  (error, stackTrace) {
                    print("error : ${error.toString()}");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              Text('Wrong input\nError:${error.toString()}'),
                        );
                      },
                    );
                  },
                );
              },
              child: Text("Sign in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  fixedSize: Size(180, 50)),
            )
          ],
        ),
      )),
    );
  }
}
