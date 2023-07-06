import 'package:fast_drugs/controller/location_cubit/location_cubit.dart';
import 'package:fast_drugs/shared/constants/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LocationCubit()..getMyLocation(),
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            LocationCubit cubit = LocationCubit.get(context);
            return cubit.currentPosition == null
                ? _buildProgressBar()
                : _buildMap(cubit);
          },
        ),
      ),
    );
  }

  GoogleMap _buildMap(LocationCubit cubit) {
    double longitude = cubit.currentPosition!.longitude;
    double latitude = cubit.currentPosition!.latitude;
    return GoogleMap(
      zoomControlsEnabled: false,

      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: LatLng(latitude, longitude),zoom: 20.0),
    );
  }

  Center _buildProgressBar() {
    return const Center(
      child: CircularProgressIndicator(
        color: LightColors.primary,
      ),
    );
  }
}
