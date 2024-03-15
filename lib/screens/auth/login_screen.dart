import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/screens/auth/register_screen.dart';
import 'package:todo_app/widgets/myTextFormField.dart';
import 'package:todo_app/widgets/my_elevated_button.dart';

import '../../firebase_utils.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const  routeName='login screen route name';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final formKey =GlobalKey<FormState>();
  bool isPasswordObscure=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Todo App'
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextFormField(
                  validator: (value){
                    if(value==null || value==''){
                      return'email can not be empty';
                    }
                    return null;
                  },
                    controller: emailController,
                    labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                MyTextFormField(
                    controller: passwordController,
                    labelText: 'Password',
                  isPassword: isPasswordObscure,
                  suffixIcon: IconButton(
                      onPressed: (){
                        isPasswordObscure= !isPasswordObscure;
                        setState(() {});
                      },
                      icon: isPasswordObscure ? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
                  ),
                  validator: (password){
                      if(password ==null ||password.isEmpty){
                        return'password can not be empty';
                      }else if(password.length<6){
                        return 'Password must be more than 6 characters';
                      }
                      return null;
                  },
                ),
                MyElevatedButton(
                    label: 'Login',
                    onPressed: (){
                      if(formKey.currentState?.validate()==true){
                        FirebaseUtils.login(
                          emailController.text,
                          passwordController.text,
                        ).then((newUser) {
                          Provider.of<UserProvider>(context,listen: false).changeUser(newUser);
                          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                        }).catchError(
                                (error){
                              if(error is FirebaseAuthException){
                                Fluttertoast.showToast(
                                  msg: error.message ?? "OPS! something went wrong.",
                                );
                              }else {
                                Fluttertoast.showToast(
                                    msg: "OPS! something went wrong.");
                              }
                            }
                        );
                      }
                    },
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: const Text(
                      'Don\'t have account?  register now',
                    ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
