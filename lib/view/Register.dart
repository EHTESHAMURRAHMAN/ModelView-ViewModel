import 'package:flutter/material.dart';
import 'package:mvvm/res/Components/round_Button.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/AuthViewModel.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    obsecurePassword.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Email'),
                  focusNode: emailFocusNode,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                ),
                SizedBox(height: height * .02),
                ValueListenableBuilder(
                  valueListenable: obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: password,
                      obscureText: obsecurePassword.value,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          prefixIcon: const Icon(Icons.key),
                          suffixIcon: InkWell(
                              onTap: () {
                                obsecurePassword.value =
                                    !obsecurePassword.value;
                              },
                              child: Icon(obsecurePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: 'password'),
                      focusNode: passwordFocusNode,
                    );
                  },
                ),
                SizedBox(height: height * .05),
                RoundButton(
                  tital: 'Register',
                  loading: authViewModel.registerLoading,
                  onPress: () {
                    if (email.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please Enter Email', context);
                    } else if (password.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please Enter Password', context);
                    } else if (password.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          'Please Enter 6 Digit Password', context);
                    } else {
                      Map data = {
                        'email': email.text.toString(),
                        'password': password.text.toString()
                      };
                      authViewModel.registerApi(data, context);
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
