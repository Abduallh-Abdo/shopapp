import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';
import 'package:shopapp/models/categories_model.dart';

class CatagoriesScreen extends StatelessWidget {
  const CatagoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: appCubit.categoriesModel != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: appCubit.categoriesModel!.data!.data.length,
              itemBuilder: (context, index) => dafaultCatoItem(
                context: context,
                model: appCubit.categoriesModel!.data!.data[index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget dafaultCatoItem({required ListDataModel model, required context}) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.lightGreen,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            model.image.toString(),
            height: 120,
            width: 120,
          ),
          Text(
            model.name.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
