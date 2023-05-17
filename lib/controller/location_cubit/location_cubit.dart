import 'package:bloc/bloc.dart';
import 'package:fast_drugs/helpers/location_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
static  LocationCubit get(context)=>BlocProvider.of(context);
  Position? currentPosition;
Future<void>  getMyLocation()async{

    currentPosition= await  LocationHelper.getCurrentLocation();
    emit(GetMyLocationState());
  }
}
