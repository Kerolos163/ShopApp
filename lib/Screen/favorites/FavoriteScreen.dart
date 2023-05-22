import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/state.dart';
import '../../Theme/theme.dart';
import '../../model/GetFavoriteModel.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetfavoriteState,
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildfavoirteitem(context,
                    AppCubit.get(context).favoritegetmodel!.data!.data![index]),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[300],
                      thickness: .6,
                      indent: 40,
                      endIndent: 40,
                    ),
                itemCount:
                    AppCubit.get(context).favoritegetmodel!.data!.data!.length);
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildfavoirteitem(context, FavoriteData model) => Padding(
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
                      model.product!.image as String,
                    ),
                    width: 120,
                    height: 120,
                  ),
                  if (model.product!.discount != 0)
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(15 / 360),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: primaryClr.withOpacity(.6),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Discount",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
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
                      "${model.product!.name}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.3, fontSize: 15),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "${model.product!.price}",
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
                        if (model.product!.discount != 0)
                          Text(
                            "${model.product!.oldPrice}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1.3,
                                fontSize: 15,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    AppCubit.get(context)
                        .changeFavorites(model.product!.id as int);
                  },
                  icon: Icon(
                    AppCubit.get(context)
                                .favorites![model.product!.id as int] ==
                            true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 22,
                    color: AppCubit.get(context)
                                .favorites![model.product!.id as int] ==
                            true
                        ? Colors.red
                        : Colors.grey,
                  ))
            ],
          ),
        ),
      );
}
