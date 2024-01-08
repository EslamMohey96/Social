import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//defaultButton
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.red,
  required Function() function,
  required Widget widget,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: widget,
      ),
    );
// sizeBoxHWidget
Widget sizeBoxH(double x) => SizedBox(
      height: x,
    );
// sizeBoxWWidget
Widget sizeBoxW(double x) => SizedBox(
      width: x,
    );
// textFormField
Widget textFormField({
  var context,
  required TextEditingController controller,
  required TextInputType textInputType,
  String? labelText,
  required Widget prefixIcon,
  required String? Function(String?)? valid,
  bool visible = false,
  bool isClickable = true,
  Widget? suffixIcon,
  Function()? suffixPressed,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  Function()? onTap,
  String? hintText,
}) =>
    TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: textInputType,
      obscureText: visible,
      onFieldSubmitted: onSubmit,
      // onChanged: onChange,
      validator: valid,
      onTap: onTap,
      onChanged: onChange,

      enabled: isClickable,
      cursorColor: Colors.white,
      style: TextStyle(
        color:
            //  onBoardingCubit.get(context).lightMode
            //     ? Colors.black
            // :
            Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          // textDirection: TextDirection.rtl,
          fontSize: 15,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
          icon: suffixIcon ?? Icon(Icons.person),
          onPressed: suffixPressed,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        border: const OutlineInputBorder(),
      ),
    );

Future<bool?> toastMessage({
  required message,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor:
        //  onBoardingCubit.get(context).lightMode
        //     ?
        Colors.white,
    // : Colors.black,
    fontSize: 16.0,
  );
}
