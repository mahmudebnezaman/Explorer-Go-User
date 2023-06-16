import 'package:explorergocustomer/consts/consts.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(primary),
  );
}