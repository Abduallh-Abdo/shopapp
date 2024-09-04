import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessChangeFavoritesState) {
          if (state.model.status == false) {
            defaultToast(
              msg: state.model.message,
              state: ToastStates.error,
            );
          }
          if (state.model.status == true) {
            defaultToast(
              msg: state.model.message,
              state: ToastStates.success,
            );
          }
        }
      },
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition:
                appCubit.homeModel != null && appCubit.categoriesModel != null,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // defaultCarouselSlider(model: appCubit.homeModel),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    height: 50,
                    child: defaultCatagiresList(
                        isDark: appCubit.isDark,
                        model: appCubit.categoriesModel!.data!),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Products',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                    ),
                  ),
                  defaultGridViewBuilder(model: appCubit.homeModel!),
                ],
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget defaultCarouselSlider({required HomeModel model}) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: model.data!.banners.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(color: Colors.amber),
              child: Image.network(
                item.image.toString(),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget defaultProductItemBuilder({
    required ProductModel model,
    required context,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightGreen),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                height: 200,
                model.image == null
                    ? 'assets/images/error.jpg'
                    : model.image.toString(),
              ),
              if (model.discount != 0)
                Container(
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Text(
                    'Discount',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                ),
            ],
          ),

          Text(
            model.name.toString(),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  height: 1.3,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          // Text(appCubit
          //     .homeModel!.data!.products[index].description
          //     .toString()),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                model.price.round().toString(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.lightGreen,
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              model.discount == 0
                  ? Container()
                  : Text(
                      model.oldPrice.round().toString(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeFavorites(productId: model.id!);
                  },
                  icon: Icon(
                    size: 20,
                    color: AppCubit.get(context).favorites[model.id]!
                        ? Colors.lightGreen
                        : Colors.grey,
                    Icons.favorite_outlined,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget defaultGridViewBuilder({
    required HomeModel model,
  }) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
      ),
      itemCount: model.data!.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => defaultProductItemBuilder(
        model: model.data!.products[index],
        context: context,
      ),
    );
  }

  defaultCatagiresList(
      {required CategoriesDataModel model, required bool isDark}) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: model.data.length,
      // separatorBuilder: (context, index) => const SizedBox(
      //   width: 0,
      // ),
      itemBuilder: (context, index) => model.data[index].name != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.lightGreen),
              ),
              child: Text(
                model.data[index].name.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.lightGreen,
                    ),
              ),
            )
          : const Text(''),
    );
  }
}
