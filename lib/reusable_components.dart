import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets_practice/resources/colors_fonts.dart';
import 'package:widgets_practice/theme_provider.dart';

class ReusableTextRow extends StatelessWidget {
  final String textOne;
  final Color textOneColor;
  final Color textTwoColor;
  final String textTwo;
  const ReusableTextRow({super.key,
  required this.textOne,
  required this.textTwo,
  this.textOneColor = white,
  this.textTwoColor = white,
  });

  @override
  Widget build(BuildContext context) {
    
    return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(textOne, style:   TextStyle(color: textOneColor, fontWeight: FontWeight.bold, fontSize: 17, fontFamily: poppins,),),
                        Text(textTwo, style:  TextStyle(color: textTwoColor, fontSize: 15, fontFamily: poppins),),
                      ],);
  }
}

class ReusableButton extends StatelessWidget {
  final String name;
  final VoidCallback onPress;
  const ReusableButton({super.key,
  required this.name,
  required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    
  final size = MediaQuery.of(context).size;

    return  GestureDetector(
      onTap: onPress,
      child: Container(
        height: size.height * 0.030,
        width: size.width * 0.25,
        decoration:  BoxDecoration(
          gradient:  const LinearGradient(colors: [lightBlue,grey]),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
                     BoxShadow(color: black, blurRadius: 4, spreadRadius: 1),
                  ]
        ),
        child: Center(child: Text(name, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontFamily: poppins),)),
      ),
    );
  }
}

// Text Reusable

class ReusableText extends StatelessWidget {
  final String content; 
  final double fontSize;
  final Color textColor;
  final FontWeight? weight;
  const ReusableText({super.key,
  required this.content,
  this.fontSize = 18,
  this.textColor = black,
  this.weight,
  });

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context).darkTheme;
    return Text(
      content,
      style: TextStyle(
        fontFamily: poppins,
        fontSize: fontSize,
        color: themeChange? white :textColor ,
        fontWeight: weight
      ),
    );
  }
}

// Reusable Row of Weather detail


