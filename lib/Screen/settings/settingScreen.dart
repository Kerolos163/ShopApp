import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/state.dart';
import '../../widgets/text_field.dart';

class SettingScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        namecontroller.text = AppCubit.get(context).UserModel!.data!.name!;
        emailcontroller.text = AppCubit.get(context).UserModel!.data!.email!;
        phonecontroller.text = AppCubit.get(context).UserModel!.data!.phone!;
        return ConditionalBuilder(
          condition: AppCubit.get(context).UserModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpDateState)
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 30),
                            child: LinearProgressIndicator(),
                          ),
                        TEXTFIELD(
                            namecontroller,
                            TextInputType.text,
                            "Name",
                            "Enter Your Name...",
                            const Icon(Icons.person_3_sharp),
                            false),
                        const SizedBox(
                          height: 5,
                        ),
                        TEXTFIELD(
                            emailcontroller,
                            TextInputType.text,
                            "Email",
                            "Enter Your Email...",
                            const Icon(Icons.email_sharp),
                            false),
                        const SizedBox(
                          height: 5,
                        ),
                        TEXTFIELD(
                            phonecontroller,
                            TextInputType.phone,
                            "Phone",
                            "Enter Your Phone...",
                            const Icon(Icons.phone_android_rounded),
                            false),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppCubit.get(context).UpDateUserData(
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  phone: phonecontroller.text);
                            }
                          },
                          child: const Text("UPDATE"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            AppCubit.get(context).logout();
                          },
                          child: const Text("LOGOUT"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
