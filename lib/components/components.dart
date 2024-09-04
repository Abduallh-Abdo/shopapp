import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/models/get_favorites_model.dart';
import 'package:shopapp/models/search_model.dart';

Widget defuaLtFormField({
  required TextEditingController controller,
  required dynamic validate,
  required String labelText,
  required TextInputType type,
  required IconData prefix,
  IconData? suffix,
  bool obscureText = false,
  Function()? suffixPressed,
  Function(String)? onSubmit,
  Function(String)? onChanged,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: obscureText,
    validator: validate,
    onFieldSubmitted: onSubmit,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: labelText,
      prefix: Icon(
        prefix,
      ),
      suffix: suffix != null
          ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget defaultButton({
  required String text,
  required VoidCallback onPressed,
  Color color = Colors.blueAccent,
  double width = double.infinity,
  double height = 40,
  double radius = 0,
  bool isUppercase = true,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: color,
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        isUppercase ? text.toUpperCase() : text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    ),
  );
}

Widget defaultTextButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.lightGreen,
      ),
    ),
  );
}

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Future<bool?> defaultToast({
  required msg,
  required ToastStates state,
}) async {
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: changeToastState(state: state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastState({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.lightGreen;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget dafaultCatoItem({
  required FavoriteProductModel  model,
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
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image.network(
              height: 150,
              width: 150,
              // fit: BoxFit.cover,
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
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.name.toString(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      height: 1.3,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    model.price.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.lightGreen,
                        ),
                  ),
                  model.discount == 0
                      ? Container()
                      : Text(
                          model.oldPrice.toString(),
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .changeFavorites(productId: model.id!);
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
        )
      ],
    ),
  );
}

Widget dafaultSearchItem({
  required ListSeacrhDataModel model,
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
    child: Row(
      children: [
        Image.network(
          height: 150,
          width: 150,
          // fit: BoxFit.cover,
          model.image == null
              ? 'assets/images/error.jpg'
              : model.image.toString(),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.name.toString(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      height: 1.3,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    model.price.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.lightGreen,
                        ),
                  ),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .changeFavorites(productId: model.id!);
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
        )
      ],
    ),
  );
}
