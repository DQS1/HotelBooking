import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/widgets/common_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class FaceBookTwitterButtonView extends StatelessWidget {
  const FaceBookTwitterButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 24,
          ),
          Expanded(
            child: CommonButton(
              padding: EdgeInsets.zero,
              backgroundColor: Color(0x0FF3C5799),
              buttonTextWidget: _buttonTextUI(),
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            child: CommonButton(
              padding: EdgeInsets.zero,
              backgroundColor: Color(0x0FF05A9F0),
              buttonTextWidget: _buttonTextUI(isFaceBook:false),
            ),
          ),
          SizedBox(
            width: 24,
          )
        ],
      ),
    );
  }
}

Widget _buttonTextUI ({bool isFaceBook: true}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(isFaceBook ? FontAwesomeIcons.facebook : FontAwesomeIcons.twitter ,
      size: 20,
        color: Colors.white,
      ),
      SizedBox(
        width: 20,
),
      Text(isFaceBook ? 'Facebook' :'Twitter' ,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,
      color: Colors.white),)
    ],
  );
}
