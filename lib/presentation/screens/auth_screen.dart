import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../bussiness_logic/auth.dart';

enum AuthMode { signUp, login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FocusNode firstName = FocusNode();
  FocusNode lastName = FocusNode();
  FocusNode phoneNumber = FocusNode();
  FocusNode country = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    firstName.addListener(() {
      setState(() {});
    });
    lastName.addListener(() {
      setState(() {});
    });
    phoneNumber.addListener(() {
      setState(() {});
    });
    country.addListener(() {
      setState(() {});
    });
    passwordFocus.addListener(() {
      setState(() {});
    });
    confirmPasswordFocus.addListener(() {
      setState(() {});
    });
    emailFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    country.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    emailFocus.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.signUp;
  final Map<String, String> _authData = {
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'country': '',
    'email': '',
    'password': '',
    'confirmPassword': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false).login(
            context: context,
            email: _authData['email'].toString(),
            password: _authData['password'].toString());
      } else {
        await Provider.of<Auth>(context, listen: false).register(
            context: context,
            firstName: _authData['firstName'].toString(),
            lastName: _authData['lastName'].toString(),
            phoneNumber: _authData['phoneNumber'].toString(),
            country: _authData['country'].toString(),
            email: _authData['email'].toString(),
            password: _authData['password'].toString(),
            confirmPassword: _authData['confirmPassword'].toString());
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
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
              color: myGreen,
              image: const DecorationImage(
                  image: AssetImage('assets/images/background 2.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: getHeight(context) * 0.05,
                ),
                SvgPicture.asset('assets/icons/logo 1.svg'),
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
                          if (_authMode == AuthMode.signUp)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: getWidth(context) / 2.5,
                                  child: TextFormField(
                                    focusNode: firstName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: firstName.hasFocus
                                            ? Colors.black.withOpacity(0.9)
                                            : Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(.45),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(.45))),
                                      hintText: 'First Name',
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: firstName.hasFocus
                                            ? Colors.black.withOpacity(0.9)
                                            : myGreen,
                                        size: 28,
                                      ),
                                      hintStyle: TextStyle(
                                          color: firstName.hasFocus
                                              ? Colors.black.withOpacity(0.9)
                                              : myGreen),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(.45))),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Invalid Name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['firstName'] = value.toString();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(context) / 2.5,
                                  child: TextFormField(
                                    focusNode: lastName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: lastName.hasFocus
                                            ? Colors.black.withOpacity(0.9)
                                            : myGreen),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(.45),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            width: 0,
                                          )),
                                      hintText: 'Last Name',
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: lastName.hasFocus
                                            ? Colors.black.withOpacity(0.9)
                                            : myGreen,
                                        size: 28,
                                      ),
                                      hintStyle: TextStyle(
                                          color: lastName.hasFocus
                                              ? Colors.black.withOpacity(0.9)
                                              : myGreen),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            width: 0,
                                          )),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Invalid Name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _authData['lastName'] = value.toString();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          TextFormField(
                            focusNode: emailFocus,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: emailFocus.hasFocus
                                    ? Colors.black.withOpacity(0.9)
                                    : myGreen),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(.45),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 3,
                                  )),
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: emailFocus.hasFocus
                                    ? Colors.black.withOpacity(0.9)
                                    : myGreen,
                                size: 28,
                              ),
                              hintStyle: TextStyle(
                                  color: emailFocus.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 0,
                                  )),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value.toString();
                            },
                          ),
                          if (_authMode == AuthMode.signUp)
                            SizedBox(
                              height: getHeight(context) * 0.02,
                            ),
                          if (_authMode == AuthMode.signUp)
                            TextFormField(
                              focusNode: phoneNumber,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: phoneNumber.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(.45),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 3,
                                    )),
                                hintText: 'Phone Number',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: phoneNumber.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen,
                                  size: 28,
                                ),
                                hintStyle: TextStyle(
                                    color: phoneNumber.hasFocus
                                        ? Colors.black.withOpacity(0.9)
                                        : myGreen),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 0,
                                    )),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Invalid Number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['phoneNumber'] = value.toString();
                              },
                            ),
                          if (_authMode == AuthMode.signUp)
                            SizedBox(
                              height: getHeight(context) * 0.02,
                            ),
                          if (_authMode == AuthMode.signUp)
                            TextFormField(
                              focusNode: country,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: country.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(.45),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 3,
                                    )),
                                hintText: 'Country',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: country.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen,
                                  size: 28,
                                ),
                                hintStyle: TextStyle(
                                    color: country.hasFocus
                                        ? Colors.black.withOpacity(0.9)
                                        : myGreen),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 0,
                                    )),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Invalid Country';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['country'] = value.toString();
                              },
                            ),
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          TextFormField(
                            focusNode: passwordFocus,
                            obscureText: true,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: passwordFocus.hasFocus
                                    ? Colors.black.withOpacity(0.9)
                                    : myGreen),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(.45),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 3,
                                  )),
                              hintText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: passwordFocus.hasFocus
                                    ? Colors.black.withOpacity(0.9)
                                    : myGreen,
                                size: 28,
                              ),
                              hintStyle: TextStyle(
                                  color: passwordFocus.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    width: 0,
                                  )),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value.toString();
                            },
                          ),
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          if (_authMode == AuthMode.signUp)
                            TextFormField(
                              focusNode: confirmPasswordFocus,
                              obscureText: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: confirmPasswordFocus.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(.45),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 3,
                                    )),
                                hintText: 'Repeat Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: confirmPasswordFocus.hasFocus
                                      ? Colors.black.withOpacity(0.9)
                                      : myGreen,
                                  size: 28,
                                ),
                                hintStyle: TextStyle(
                                    color: confirmPasswordFocus.hasFocus
                                        ? Colors.black.withOpacity(0.9)
                                        : myGreen),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      width: 0,
                                    )),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value.length < 5 ||
                                    value != _passwordController.text) {
                                  return 'Invalid Repeated Password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['confirmPassword'] = value.toString();
                              },
                            ),
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            GestureDetector(
                              onTap: _submit,
                              child: Container(
                                width: getWidth(context),
                                height: getHeight(context) * 0.07,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: myYellow),
                                child: Center(
                                  child: Text(
                                    _authMode == AuthMode.signUp
                                        ? 'Create an Account'
                                        : 'Sign In',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: getHeight(context) * 0.02,
                          ),
                          TextButton(
                            onPressed: _switchAuthMode,
                            child: RichText(
                                text: TextSpan(
                                    text: _authMode == AuthMode.signUp
                                        ? 'Have an Account ? '
                                        : 'Don\'t have an account ? ',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: _authMode == AuthMode.signUp
                                          ? 'Sign In'
                                          : 'Let\'s make one',
                                      style: TextStyle(color: myYellow))
                                ])),
                          )
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
