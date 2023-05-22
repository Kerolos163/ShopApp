import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit.dart';
import '../../Helper/Share_Pref.dart';
import '../../imp_func.dart';
import '../../widgets/text_field.dart';
import '../LogIn/Cubit/Cubit.dart';
import '../LogIn/LoginScreen.dart';
import '../ShopLayout.dart';
import 'Cubit/Cubit.dart';
import 'Cubit/State.dart';

class RegisterScreen extends StatelessWidget {
  var email = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            print(state.model.message);
            if (state.model.status == true) {
              print(state.model.data!.token);
              Token = state.model.data!.token;
              Sharepref.savedata(key: 'Token', value: state.model.data!.token)
                  .then((value) {
                go_toAnd_finish(context, LoginScreen());
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
          if (state is ShopRegisterErrorState) {
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
                          "REGISTER",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black, fontSize: 35),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TEXTFIELD(
                            name,
                            TextInputType.emailAddress,
                            "Name",
                            "PLease Enter Name",
                            const Icon(
                              Icons.person_3,
                              color: Colors.black,
                            ),
                            false),
                        const SizedBox(
                          height: 10,
                        ),
                        TEXTFIELD(
                            email,
                            TextInputType.emailAddress,
                            "Email",
                            "PLease Enter Email",
                            const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            false),
                        const SizedBox(
                          height: 10,
                        ),
                        TEXTFIELD(
                            phone,
                            TextInputType.emailAddress,
                            "Phone",
                            "PLease Enter Phone",
                            const Icon(
                              Icons.phone_android_outlined,
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
                                ShopRegisterCubit.get(context).Isvisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility), () {
                              ShopRegisterCubit.get(context)
                                  .ChangeVisiability();
                            }),
                            !ShopRegisterCubit.get(context).Isvisible),
                        const SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        email: email.text,
                                        password: password.text,
                                        name: name.text,
                                        phone: phone.text);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "REGISTER",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ));
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
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
