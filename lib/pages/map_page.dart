import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_sport/models/address.dart';
import 'package:find_sport/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../bloc/map/map_bloc.dart';
import '../bloc/sign_up/sign_up_bloc.dart';
import '../map/location_model.dart';
import '../map/map_utils.dart';
import '../translations/locale_keys.g.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapController = Completer<YandexMapController>();
  var _locationModel = LocationModel();
  var locationName = '';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    handleLocationPermission();
    super.initState();
  }

  Future<void> getCameraPos() async {
    (await mapController.future).getCameraPosition().then((value) {
      getPlaceMark(value.target.latitude, value.target.longitude);
    });
  }

  Future<void> move() async {
    var controller = await mapController.future;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      controller.moveCamera(
          animation:
          const MapAnimation(type: MapAnimationType.linear, duration: 1),
          CameraUpdate.newCameraPosition(CameraPosition(
              target: Point(
                  latitude: position.latitude,
                  longitude: position.longitude))));
    }).catchError((e) {
      //
    });
    getCameraPos();
  }

  Future<void> getPlaceMark(double lat, double long) async {
    getAddressFromLatLong(lat, long, (locationModel) {
      _locationModel = locationModel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    locationName =
    _locationModel.countryName.isEmpty ? '' : '${_locationModel.countryName}, ${_locationModel.regionName}, ${_locationModel.cityName}';
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 10,
            toolbarHeight: 45,
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.close_rounded)),
            title: Text(LocaleKeys.map_title.tr()),
            actions: [
              Builder(
                  builder: (context) {
                    if (state.status == EnumStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    }
                    if (state.status == EnumStatus.fail) {
                      Fluttertoast.showToast(msg: state.message);
                    }
                    if (state.status == EnumStatus.success) {
                      Fluttertoast.showToast(msg: state.message);
                      titleController.clear();
                      descriptionController.clear();
                      locationController.clear();
                    }
                    return IconButton(onPressed: () {
                      final address = Address(title: titleController.text, description: descriptionController.text, lat: _locationModel.lat, long: _locationModel.long);
                      debugPrint('${_locationModel.lat} ==== ${_locationModel.long}');
                      BlocProvider.of<MapBloc>(context).add(PostAddress(address: address));
                    }, icon: const Icon(CupertinoIcons.arrow_right, color: Colors.blue,));
                  }
              ),
              const SizedBox(width: 15)
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(title: LocaleKeys.address_title.tr(), hint: LocaleKeys.address_title_hint.tr(), controller: titleController),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text(LocaleKeys.address_description.tr(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15))],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: descriptionController,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    isDense: true,
                    fillColor: Colors.grey.shade400,
                    hintText: LocaleKeys.address_description_hint.tr(),
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    const Divider(color: Colors.black, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(LocaleKeys.change_location.tr()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  title: LocaleKeys.address_by_location.tr(),
                  hint: LocaleKeys.address_by_location_hint.tr(),
                  controller: locationController,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: Stack(
                    children: [
                      YandexMap(
                        onCameraPositionChanged: (cameraPosition, reason, finished) {
                          if (finished) {
                            getCameraPos();
                            locationController.text = locationName;
                          }
                        },
                        onMapCreated: (controller) {
                          mapController.complete(controller);
                          move();
                        },
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Icon(Icons.location_on, color: Colors.red, size: 40),
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
