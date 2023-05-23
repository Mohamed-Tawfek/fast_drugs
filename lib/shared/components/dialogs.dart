import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

Future showProgressDialog(context) {
 return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            content: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
                backgroundColor: Colors.grey.withOpacity(0.5),
              ),
            ),
          ));
}

showErrorDialog({required BuildContext context, required String message}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Oops...',
    text: message,
   confirmBtnColor: Colors.green,
  );
}

Future showSuccessDialog(
    {required BuildContext context, required String message}) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    text: message,
  );
}

showConfirmDialog(
        {required BuildContext context,
        required void Function()? onPressedOK,
        required String message}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    text: message,
    confirmBtnText: 'Yes',
    cancelBtnText: 'No',
    confirmBtnColor: Colors.green,
    onConfirmBtnTap: (){
      onPressedOK;
    },
    onCancelBtnTap: (){
      Navigator.pop(context);
    }
  );
}
