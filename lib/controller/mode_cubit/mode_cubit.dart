import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../helpers/cash_helper.dart';

part 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  ModeCubit() : super(ModeInitial());
  static bool isDark = false;

  static ModeCubit get(context) => BlocProvider.of(context);

  void changeMode() {
    isDark = !isDark;
    CashHelper.setData(key: 'isDark', value: isDark);
    emit(ChangeModeState());
  }
}
