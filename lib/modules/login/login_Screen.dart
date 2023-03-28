

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/language/appLocalizations.dart';
import 'package:hotel_booking/utils/validator.dart';
import 'package:hotel_booking/widgets/common_appbar_view.dart';
import 'package:hotel_booking/widgets/common_button.dart';
import 'package:hotel_booking/widgets/common_textfield.dart';
import 'package:hotel_booking/widgets/remove_focuse.dart';

import '../../routes/route_names.dart';
import 'facebook_twitter_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _errorEmail ='';
  TextEditingController _emailController = TextEditingController();

  String _errorPassword ='';
  TextEditingController _passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back_ios_new,
                titleText: AppLocalizations(context).of('login'),
                onBackClick: (){
                Navigator.pop(context);
                }),
            Expanded(
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 32, left: 16 ,right: 16,bottom: 16),
                        child: FaceBookTwitterButtonView(),
                      ),
                      Padding(
                          padding: EdgeInsets.all(16),
                        child: Text(
                          AppLocalizations(context).of('log_with mail'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor),
                        ),
                      ),
                       CommonTextFieldView(
                         controller: _emailController,
                         errorText: _errorEmail,
                         titleText: AppLocalizations(context).of('your_mail'),
                         padding: EdgeInsets.only(
                           left: 24,
                           right: 24,
                         ),
                         hintText: AppLocalizations(context).of('enter_your_email'),
                         keyboardType: TextInputType.emailAddress,
                         onChanged: (String txt) {},
                       ),
                      CommonTextFieldView(
                        controller: _passWordController,
                        errorText: _errorPassword,
                        titleText: AppLocalizations(context).of('password'),
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 16,
                        ),
                        hintText: AppLocalizations(context).of('enter_password'),
                        keyboardType: TextInputType.text,
                        isObsecureText: true,
                        onChanged: (String txt) {},
                      ),
                      _forgotYourPassorUI(),
                      CommonButton(
                        padding: EdgeInsets.only(left: 24,right: 24,bottom: 16),
                        buttonText: AppLocalizations(context).of('login'),
                        onTap: () {
                          if (allValidation())
                            NavigationServices(context).gotoBottomTabScreen();
                        },
                      )
                    ],
                  ),
                ) )
          ],
        ),
      ),
    );
  }


 _forgotYourPassorUI() {
  return Padding(padding: EdgeInsets.only(top: 8,right: 16,left: 16,bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: (){
                  NavigationServices(context).gotoForgotPasswordScreen();
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    AppLocalizations(context).of('forgot_your_Password'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).disabledColor
                      ),
                    ),
                  ),
                ),
            ],
          ),
  );
}

  bool allValidation() {
    bool isVaild = true;
    if(_emailController.text.trim().isEmpty) {
      _errorEmail = AppLocalizations(context).of('email_cannot_empty');
      isVaild = false;
    }else if (!Validator.validateEmail(_emailController.text.trim())){
      _errorEmail = AppLocalizations(context).of('enter_valid_email');
      isVaild = false;
    } else {
      _errorEmail = '';
    }

    if(_passWordController.text.trim().isEmpty) {
      _errorPassword = AppLocalizations(context).of('password_cannot_empty');
      isVaild = false;
    }else if (_passWordController.text.trim().length < 6){
      _errorPassword = AppLocalizations(context).of('valid_password');
      isVaild = false;
    } else {
      _errorPassword = '';
    }
    setState(() {

    });
    return isVaild;
  }
}
