import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/cubit.dart';
import 'package:shop_app/Screen/search/cubit/cubit.dart';

import '../../Theme/theme.dart';
import 'cubit/state.dart';

class SearchScreen extends StatelessWidget {
  var searchcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10 ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          SearchCubit.get(context).Search(Text: value);
                        },
                        cursorColor: primaryClr,
                        obscureText: false,
                        controller: searchcontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Search',
                          labelStyle: Titlestyle,
                          hintStyle: Body2lestyle,
                          suffixIcon: const Icon(Icons.search),
                          suffixIconColor: primaryClr,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: primaryClr,
                                width: 1,
                              )),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    // const SizedBox(height: 15,),
                    if (state is SeacrLoadingState)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: LinearProgressIndicator(),
                      ),

                    ConditionalBuilder(
                      condition: SearchCubit.get(context).model != null,
                      builder: (context) {
                        return Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  buildfavoirteitem(
                                      context,
                                      SearchCubit.get(context)
                                          .model!
                                          .data!
                                          .data![index]),
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey[300],
                                    thickness: .6,
                                    indent: 40,
                                    endIndent: 40,
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length),
                        );
                      },
                      fallback: (context) => Container(),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget buildfavoirteitem(context, model) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image as String,
                    ),
                    width: 120,
                    height: 120,
                  ),
                  // if (model.discount != 0)
                  //   RotationTransition(
                  //     turns: const AlwaysStoppedAnimation(15 / 360),
                  //     child: Container(
                  //       padding: const EdgeInsets.all(3.0),
                  //       decoration: BoxDecoration(
                  //           color: primaryClr.withOpacity(.6),
                  //           borderRadius: BorderRadius.circular(5)),
                  //       child: const Text(
                  //         "Discount",
                  //         style: TextStyle(fontSize: 11),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${model.name}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.3, fontSize: 15),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.price}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            height: 1.3,
                            fontSize: 17,
                            color: primaryClr,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // if (model.discount != 0)
                        //   Text(
                        //     "${model.oldPrice}",
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: const TextStyle(
                        //         height: 1.3,
                        //         fontSize: 15,
                        //         color: Colors.grey,
                        //         decoration: TextDecoration.lineThrough),
                        //   ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppCubit.get(context).changeFavorites(model.id as int);
                  },
                  icon: Icon(
                    AppCubit.get(context).favorites![model.id as int] == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 22,
                    color: AppCubit.get(context).favorites![model.id as int] ==
                            true
                        ? Colors.red
                        : Colors.grey,
                  ))
            ],
          ),
        ),
      );
}
