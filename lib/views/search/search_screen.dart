import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/views/search/search_cubit/search_cubit.dart';
import 'package:shopapp/views/search/search_cubit/search_state.dart';
import 'package:shopapp/views/shop_layout.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit searchCubit = SearchCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      navigateAndFinish(context: context, widget: const ShopLayout());
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: Form(
                key: searchCubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      defuaLtFormField(
                        controller: searchCubit.textController!,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (text) {
                          if (searchCubit.formKey.currentState!.validate()) {
                            searchCubit.search(text: text);
                          }
                        },
                        labelText: 'Search',
                        type: TextInputType.text,
                        prefix: Icons.search,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) => dafaultSearchItem(
                              context: context,
                              model: searchCubit.searchModel!.data!.data[index],
                            ),
                          ),
                        ),
                    ],
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
