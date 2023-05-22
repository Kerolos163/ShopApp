import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Theme/theme.dart';
import 'package:shop_app/imp_func.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/state.dart';
import '../../model/Homemodel.dart';
import '../../model/categories_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccesschangefavoriteState) {
          if (!state.model.status) {
            ShowToast(txt: state.model.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).homemodel != null &&
              AppCubit.get(context).categoriesmodel != null,
          builder: (context) => buildProductscreen(
              AppCubit.get(context).homemodel!,
              AppCubit.get(context).categoriesmodel!,
              context),
          fallback: (context) => const Center(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildProductscreen(
          HomeModel model, Categoriesmodel categoriesmodel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: model.data.banners.map((e) {
                return Image(
                  image: NetworkImage(e.image),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  height: 200,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.linear)),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Titlestyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BuildProductList(
                          categoriesmodel.data.datamodel[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 8,
                          ),
                      itemCount: categoriesmodel.data.datamodel.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'New Product',
                  style: Titlestyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: .5,
            mainAxisSpacing: 1,
            childAspectRatio: 1 / 1.6,
            children: List.generate(model.data.products.length, (index) {
              return productwidget(model.data.products[index], context);
            }),
          )
        ]),
      );

  Widget BuildProductList(Datamodel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        Container(
            width: 110,
            color: Colors.black.withOpacity(.8),
            child: Text(
              model.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Widget productwidget(ProductsModel model, context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
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
            height: 10,
          ),
          Text(
            model.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(height: 1.3, fontSize: 15),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  "${model.price}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                    fontSize: 15,
                    color: primaryClr,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    "${model.old_price}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.3,
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      AppCubit.get(context).changeFavorites(model.id);
                    },
                    icon: Icon(
                      AppCubit.get(context).favorites![model.id] == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 22,
                      color: AppCubit.get(context).favorites![model.id] == true
                          ? Colors.red
                          : Colors.grey,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
