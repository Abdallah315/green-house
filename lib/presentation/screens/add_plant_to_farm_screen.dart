// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/presentation/widgets/app_popup.dart';
import 'package:green_house/store/auth.dart';
import 'package:green_house/store/farms.dart';
import 'package:green_house/utils/constants.dart';
import 'package:provider/provider.dart';

class AddPlantToFarmScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const AddPlantToFarmScreen({Key? key, required this.args}) : super(key: key);
  static const routName = '/add-plant-screen';

  @override
  State<AddPlantToFarmScreen> createState() => _AddPlantToFarmScreenState();
}

class _AddPlantToFarmScreenState extends State<AddPlantToFarmScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {'name': '', 'plantsCount': ''};
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print(_authData);
      String token = await Provider.of<Auth>(context, listen: false).getToken();
      await Provider.of<FarmStore>(context, listen: false)
          .addPlantToFarm(
              context: context,
              plantName: _authData['name'].toString(),
              serialNumber: widget.args['serialNumber'].toString(),
              plantsCount: _authData['plantsCount'].toString(),
              token: token)
          .then((value) {
        if (value) {
          Future.wait([
            Provider.of<FarmStore>(context, listen: false)
                .getAllFarmPlants(context, token, widget.args['serialNumber']!),
            Provider.of<FarmStore>(context, listen: false)
                .getAllFarms(context, token)
          ]).then((value) => Navigator.of(context).pop());
        }
        setState(() {
          _isLoading = false;
        });
      });
    } catch (e) {
      AppPopup.showMyDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: getWidth(context),
          height: getHeight(context),
          decoration: BoxDecoration(
            color: myDarkGreen,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: getHeight(context) * 0.05,
                ),
                SvgPicture.asset(
                  'assets/icons/logo 1.svg',
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: getHeight(context) * 0.05,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          TextFormField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: myDarkGreen),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(.45),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 3,
                                  )),
                              hintText: 'Plant Name',
                              prefixIcon: Icon(
                                Icons.email,
                                color: myDarkGreen,
                                size: 28,
                              ),
                              hintStyle: TextStyle(color: myDarkGreen),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 0,
                                  )),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the plant name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['name'] = value.toString();
                            },
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          TextFormField(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: myDarkGreen),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(.45),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 3,
                                  )),
                              hintText: 'Plants Count',
                              prefixIcon: Icon(
                                Icons.email,
                                color: myDarkGreen,
                                size: 28,
                              ),
                              hintStyle: TextStyle(color: myDarkGreen),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 0,
                                  )),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please fill the field';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['plantsCount'] = value.toString();
                            },
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.1,
                          ),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            GestureDetector(
                              // ! ADD submit here
                              onTap: _submit,
                              child: Container(
                                width: getWidth(context),
                                height: getHeight(context) * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: myYellow),
                                child: const Center(
                                  child: Text(
                                    'Add Plant',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
