import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/helpers/user_info.dart';
import 'package:perpustakaansekolah/model/login.dart';
import 'package:perpustakaansekolah/ui/buku_page.dart';
import 'package:perpustakaansekolah/ui/registrasi_page.dart';
import 'package:perpustakaansekolah/widget/warning_dialog.dart';

import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
            image: NetworkImage(
              'https://images.unsplash.com/photo-1568667256549-094345857637?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=830&q=80',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 510,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Silakan Masukkan Email & Password kamu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo.shade800,
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    userInput(_emailTextboxController, 'Email',
                        TextInputType.emailAddress),
                    userInput(_passwordTextboxController, 'Password',
                        TextInputType.visiblePassword),
                    Container(
                      height: 55,
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.indigo.shade800),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)))),
                        onPressed: () {
                          var validate = _formKey.currentState.validate();
                          if (validate) {
                            if (!_isLoading) _submit();
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 0, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextFormField(
          validator: (value) {
            //validasi harus diisi
            if (value.isEmpty && keyboardType == TextInputType.emailAddress) {
              return 'Email harus diisi';
            } else if (value.isEmpty &&
                keyboardType == TextInputType.visiblePassword) {
              return 'Password harus diisi';
            }
            return null;
          },
          obscureText:
              keyboardType == TextInputType.visiblePassword ? true : false,
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  void _submit() {
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
      await UserInfo().setToken(value.token);
      await UserInfo().setUserID(value.userID);
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => BukuPage()));
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WarningDialog(
                description: "Login gagal, silhakan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  //Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Container(
      child: Center(
        child: InkWell(
          child: Text(
            "Registrasi",
            style: TextStyle(color: Colors.blue),
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => RegistrasiPage()));
          },
        ),
      ),
    );
  }
}
  //Membuat menu untuk membuka halaman registrasi
 // Widget _menuRegistrasi() {
    //return Container(
      //child: Center(
        //child: InkWell(
          //child: Text("Registrasi",style: TextStyle(color: Colors.blue),),
          //onTap: () {
           // Navigator.push(context, new MaterialPageRoute(builder: (context)=> RegistrasiPage()));
          //},
       // ),
     // ),
    //);
 // }
