import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import '../../widgets/myTextFormField.dart';
import '../../widgets/my_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  static const  routeName='register screen route name';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  bool isPasswordObscure=true;
  final formKey =GlobalKey<FormState>();
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
                  controller: nameController,
                  labelText: 'Name',
                ),
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
                  label: 'Register',
                  onPressed: (){
                    if(formKey.currentState?.validate()==true){
                      FirebaseUtils.register(
                        nameController.text,
                          emailController.text,
                          passwordController.text,
                      ).then((newUser) {
                        Provider.of<UserProvider>(context,listen: false).changeUser(newUser);
                        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName).catchError(
                                (error){
                              if(error is FirebaseAuthException){
                                Fluttertoast.showToast(
                                  msg: error.message ?? "OPS! something went wrong.",
                                );
                              }else {
                                Fluttertoast.showToast(
                                    msg: "OPS! something went wrong.");
                              }
                              return null;
                            }
                        );
                      });
                    }
                  },
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Already have an account?  login now',
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
