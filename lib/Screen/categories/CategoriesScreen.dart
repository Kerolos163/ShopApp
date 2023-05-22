import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/state.dart';
import '../../Theme/theme.dart';
import '../../model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).categoriesmodel != null,
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => BuildRowCategories(
                    AppCubit.get(context)
                        .categoriesmodel!
                        .data
                        .datamodel[index]),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[300],
                      thickness: .6,
                      indent: 40,
                      endIndent: 40,
                    ),
                itemCount: AppCubit.get(context)
                    .categoriesmodel!
                    .data
                    .datamodel
                    .length);
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget BuildRowCategories(Datamodel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 130,
              height: 130,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              model.name,
              style: SubTitlestyle.copyWith(fontWeight: FontWeight.w300),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
