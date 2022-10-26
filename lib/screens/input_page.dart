import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kalkulator_bmi/components/reusable_card.dart';
import'package:kalkulator_bmi/constants.dart';
import 'package:kalkulator_bmi/kalculator.dart';
import 'dart:math';
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}
class _InputPageState extends State<InputPage> {
  String heightUnit='m';
  String weightUnit='kg';
  String bmiResult='15.0';
  String resultText='Wygłodzenie';
  String newHeightUnit='a';
  double cNHeight=1.0;
  double cNWeight=1.0;
  double cHeight=1.0;
  double cWeight=1.0;
  String newWeightUnit='b';
  String newNameUnit='c';
  double cHeight1=1.00;
  double cWeight1=1.00;
  double height=1.5;
  double weight = 60;
  List<String> unitOfMeasure = [
    'Metrical',
    'Imperial'
  ];
  Map <String, dynamic> metricUnits = {'HeightUnit':'m','convert_to_m':1,'WeightUnit':'kg','convert_to_kg':1.0};
  Map <String, dynamic>  imperialUnits={'HeightUnit':'jard','convert_to_m':0.91,'WeightUnit': 'pound','convert_to_kg':0.45};
  String ? currentlySelected='Metrical';
  DropdownButton<String?> androidDropdown(){
    List <DropdownMenuItem<String>> dropdownItems=[];
    for (String unit in unitOfMeasure){
      var newItem=DropdownMenuItem(
        value: unit,
        child: Center(child: Text(unit)),
      );
       dropdownItems.add(newItem);
    }
    return DropdownButton <String?> (
      value: currentlySelected,
      items: dropdownItems,
      isExpanded: true,
      itemHeight: 60,
      menuMaxHeight: 100,
      style: TextStyle(
        fontSize: 15.0,
      ),
      onChanged: (value){
        setState((){
        currentlySelected=value;
        if(currentlySelected=='Metrical'){
          heightUnit=metricUnits['HeightUnit'];
          weightUnit=metricUnits['WeightUnit'];
          cHeight=metricUnits['convert_to_m'];
          cWeight=metricUnits['convert_to_kg'];
          // print(cHeight);
          // print(cWeight);
        }
        else if(currentlySelected=='Imperial'){
          heightUnit=imperialUnits['HeightUnit'];
          weightUnit=imperialUnits['WeightUnit'];
          cHeight=imperialUnits['convert_to_m'];
          cWeight=imperialUnits['convert_to_kg'];
          // print(cHeight);
          // print(cWeight);
        }
        else
          {
            heightUnit=newHeightUnit;
            weightUnit=newWeightUnit;
            cHeight=cNHeight;
            cWeight=cNWeight;
            // print(cHeight);
            // print(cWeight);
          }
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(preferredSize: Size.fromHeight(20.0) ,
        child: AppBar(
        ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex:0,
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: androidDropdown(),
              ),
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    children:[
                      Expanded(
                        child: ReusableCard(
                          colour:kActiveCardColour,
                          cardChild: TextField(
                            cursorHeight: 25.5,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'New Height Unit',
                            ),
                            onChanged: (value){
                              newHeightUnit=value;
                            },
                          ),),
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour:kActiveCardColour,
                          cardChild: TextField(
                            cursorHeight: 25.5,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Convert meter (np 0.9)',
                            ),
                            onChanged: (value){
                              cNHeight=double.parse(value);
                              //print(cNHeight);
                            },
                          ),),
                      ),
                    ]),
                Row(
                    children:[
                      Expanded(
                        child: ReusableCard(
                          colour:kActiveCardColour,
                          cardChild: TextField(
                            cursorHeight: 25.5,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'New Weight Unit',
                            ),
                            onChanged: (value){
                              newWeightUnit=value;
                            },
                          ),),
                      ),
                      Expanded(
                        child: ReusableCard(
                          colour:kActiveCardColour,
                          cardChild: TextField(
                            cursorHeight: 25.5,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Convert to kg (np 1.4)',
                            ),
                            onChanged: (value){
                              cNWeight=double.parse(value);
                              //print(cNWeight);
                            },
                          ),),
                      ),

                    ]),
                Row(
                  children:[
                    Expanded(

                      child: ReusableCard(
                        colour:kActiveCardColour,
                        cardChild: TextField(
                          cursorHeight: 25.5,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Unit name',
                          ),
                          onChanged: (value){
                            newNameUnit=value;
                          },
                        ),),
                    ),
                    Expanded(
                        child: ReusableCard(
                          colour: kActiveCardColour,
                          cardChild: TextButton(
                            onPressed: (){
                            unitOfMeasure.add(newNameUnit);
                            //String newNameUnit1=newNameUnit;
                            //var Map=newMap(newNameUnit1);
                            //print(Map);
                            //Map <String, dynamic> newNameUnit={'HeightUnit':newHeightUnit,'WeightUnit': newWeightUnit};
                            },
                            child:
                            Text('Add Unit'),),
                        ))
                  ]),
              ],
            )),

            Expanded(
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          heightUnit!=null?heightUnit:'default value',
                          style:  kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data:SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFF03A9F4),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0 ),
                        overlayColor: Color(0x2903A9F4),
                      ),
                      child: Slider(
                        value: height,
                        min: 1.0,
                        max: 2.5,
                          onChanged: (double newValue){
                          setState(() {
                            height=double.parse((newValue).toStringAsFixed(2));
                            print(height);
                            // print(height);
                             print(cWeight);
                             print(cHeight);
                            cWeight1=(weight*cWeight);
                            print(cWeight1);
                            cHeight1=(height*cHeight);
                            print(cHeight1);
                            //CalculatorBrain calc=CalculatorBrain(convertedHeight: cHeight1,convertedWeight: cWeight1,height: height, weight: weight, );
                            CalculatorBrain calc=CalculatorBrain(height: cHeight1, weight: cWeight1);
                            bmiResult=calc.calculateBMI();
                            resultText=calc.getResult();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          weightUnit!=null?weightUnit:'default value',
                          style:  kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data:SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        //thumbColor: Color(0xFFEB1555),
                        thumbColor: Color(0xFF03A9F4),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0 ),
                        overlayColor: Color(0x2903A9F4),
                      ),
                      child: Slider(
                        value: weight,
                        min: 40.0,
                        max:350.0,
                        onChanged: (double newValue){
                          setState(() {
                            weight=double.parse((newValue).toStringAsFixed(1));
                             print(weight);
                            print(cWeight);
                             print(cHeight);
                            cWeight1=(weight*cWeight);
                            print(cWeight1);
                            cHeight1=(height*cHeight);
                            print(cHeight1);
                            //CalculatorBrain calc=CalculatorBrain(convertedHeight: cHeight1,convertedWeight: cWeight1,height: height, weight: weight, );
                            CalculatorBrain calc=CalculatorBrain(height: cHeight1, weight: cWeight1 );
                            bmiResult=calc.calculateBMI();
                            resultText=calc.getResult();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),),
            Expanded(
              flex: 1,
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      resultText.toUpperCase(),
                      style: kResultTextStyle,
                    ),
                    Text(
                      bmiResult,
                      style: kBMITextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}


