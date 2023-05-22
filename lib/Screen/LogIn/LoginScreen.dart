import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/cubit.dart';
import 'package:shop_app/Screen/LogIn/Cubit/Cubit.dart';
import 'package:shop_app/imp_func.dart';
import 'package:shop_app/widgets/text_field.dart';
import '../../Helper/Share_Pref.dart';
import '../../Theme/theme.dart';
import '../Register/register.dart';
import '../ShopLayout.dart';
import 'Cubit/State.dart';

class LoginScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLogInCubit(),
      child: BlocConsumer<ShopLogInCubit, LogInState>(
        listener: (context, state) {
          if (state is ShopLogInSuccessState) {
            AppCubit.get(context).getUserData();
            print(state.model.message);
            if (state.model.status == true) {
              print(state.model.data!.token);
              Token=state.model.data!.token;
              Sharepref.savedata(key: 'Token', value: state.model.data!.token)
                  .then((value) {
                    go_toAnd_finish(context, ShopLayoutScreen());
                  });
              ShowToast(
                txt: state.model.message!,
                state: ToastState.SUCCESS,
              );
            } else {
              ShowToast(
                txt: state.model.message!,
                state: ToastState.ERROR,
              );
            }
          }
          if (state is ShopLogInErrorState) {
            print(state.Error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black, fontSize: 35),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TEXTFIELD(
                            email,
                            TextInputType.emailAddress,
                            "Email",
                            "PLease Enter Email",
                            const Icon(
                              Icons.person_3,
                              color: Colors.black,
                            ),
                            false),
                        const SizedBox(
                          height: 10,
                        ),
                        TEXTFIELD(
                            password,
                            TextInputType.text,
                            "Password",
                            "PLease Enter Password",
                            PassIcon(
                                ShopLogInCubit.get(context).Isvisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility), () {
                              ShopLogInCubit.get(context).ChangeVisiability();
                            }),
                            !ShopLogInCubit.get(context).Isvisible),
                        const SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLogInLoadingState,
                          builder: (context) {
                            return OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ShopLogInCubit.get(context).userLogIn(
                                        email: email.text,
                                        password: password.text);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ));
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I Dont't Have Account",
                              style: Body2lestyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  go_to(context,  RegisterScreen());
                                },
                                child: Text("Register",
                                    style: Body2lestyle.copyWith(
                                        color: primaryClr)))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
