
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:widgets_practice/resources/colors_fonts.dart';
import 'package:widgets_practice/resources/date_time.dart';
import 'package:widgets_practice/reusable_components.dart';
import 'package:widgets_practice/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'model/model_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



  final searchCTRL = TextEditingController();
 String currentCity = 'Islamabad';
  var data;
  Future<WeatherModelClass> getWeather(String city)async{
  var uri = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=42d5f4f5bd64ebb372d9dccf15ff1f02&units=metric";
  final response = await http.get(Uri.parse(uri));
  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
    return WeatherModelClass.fromJson(data);
  }else{
    return WeatherModelClass.fromJson(data);
  }
}
String getWeatherImage(int temper) {
    if (temper <= 25) {
      return 'assets/weather_storm.png';
    } else if (temper > 25 && temper <= 30) {
      return 'assets/weather_mid.png';
    } else {
      return 'assets/weather_image.png';
    }
  }
  

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    final date = getTimeFormated();
    bool themeSwitch = themeProvider.darkTheme;
    return  WillPopScope(
      onWillPop: () async{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: const ReusableText(content: "Close App"),
            content: const ReusableText(content: "Do you want to close the app?"),
            
            actions: [
              
              TextButton(
                onPressed: (){SystemNavigator.pop();}, 
                child: const ReusableText(content: 'Yes', fontSize: 12,)),
                TextButton(
                onPressed: (){Navigator.pop(context);}, 
                child: const ReusableText(content: 'Cancel', fontSize: 12,)),
              
            ],
          );
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const ReusableText(content: "Weather"),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Consumer<ThemeProvider>(
              builder:(context, value, child)=> Switch(
                value: value.darkTheme,
                focusColor: grey,
                activeColor: lightBlue,
                activeThumbImage: const AssetImage("assets/darkMode.png"),
                inactiveThumbImage: const AssetImage("assets/lightMode.png"),
                inactiveTrackColor: black,
                activeTrackColor: white,
                onChanged:  (_) => value.setDarkTheme(),
              ),
            )
          ],
          ),
    
    
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal : 12.0),
            child: Column(
              children: [
                TextFormField(
                             controller: searchCTRL,
                             keyboardType: TextInputType.name,
                             decoration: InputDecoration(
                              hintText:  'Search for other cities?',
                              label: const ReusableText(content: "Search",fontSize: 12,),
                              prefixIcon:  const Icon(Icons.search, color: grey,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: black),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                             ),
                             onChanged: (value){
                              if(value.isEmpty){
                                setState(() {
                                  currentCity = 'Islamabad';
                                });
                              }else{
                                setState(() {
                                currentCity = value;
                              });
                              }
                              
                             },
                            ),
                Expanded(
                  flex: 1,
                  child: FutureBuilder(
                    future: getWeather(currentCity),
                    builder: (context, snapshot){
                      
                      if(snapshot.hasData){
                        final temperature = snapshot.data!.main!.temp!.round();
                        final weatherData = snapshot.data;
                        
                        return ListView.builder(
                          itemCount: snapshot.data!.weather!.length,
                          itemBuilder: (context, index){
                            return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            SizedBox(height: size.height*.02,),
                            Container(
                  height: size.height * .20,
                  width: size.width * 1,
                  decoration:  BoxDecoration(
                    gradient:  const LinearGradient(colors: [lightBlue,grey]),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                       BoxShadow(color: black, blurRadius: 4, spreadRadius: 1),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableTextRow(textOne: snapshot.data!.name.toString(), textTwo: date),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text('$temperature°C', style:  const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: white, fontFamily: poppins),),
                             Image.asset(
                              getWeatherImage(temperature),
                              fit: BoxFit.cover,
                              height: size.height * .1,
                              ),
                          ],
                        ),
                         
                      ],
                    ),
                  ),
                ),
                
                
                
              SizedBox(height: size.height*.025,),
              ReusableTextRow(textOne: "Feel's like", textTwo: '${weatherData!.main!.feelsLike!.toInt().round()}°C', textOneColor: themeSwitch? white: black,textTwoColor: themeSwitch? white: black,),
              SizedBox(height: size.height*.005,),
              ReusableTextRow(textOne: "Weather Main", textTwo: weatherData.weather![index].main.toString(), textOneColor: themeSwitch? white: black, textTwoColor: themeSwitch? white: black,),
              SizedBox(height: size.height*.005,),
              ReusableTextRow(textOne: "Description", textTwo: weatherData.weather![index].description.toString(), textOneColor: themeSwitch? white: black,textTwoColor: themeSwitch? white: black,),
              SizedBox(height: size.height*.005,),
              ReusableTextRow(textOne: "Country", textTwo: weatherData.sys!.country.toString(), textOneColor: themeSwitch? white: black,textTwoColor: themeSwitch? white: black,),
              SizedBox(height: size.height*.005,),
              ReusableTextRow(textOne: "City", textTwo: weatherData.name.toString(), textOneColor: themeSwitch? white: black,textTwoColor: themeSwitch? white: black,),
                        
                          ],
                        );
                          }
                          );

                        
                      }else{
                        
                        return const Center(child: CircularProgressIndicator(color: grey),);
                      }
                    },
                  ),
                  ),
                
    
              ],
            ),
          ),
      ),
    );
  }
}