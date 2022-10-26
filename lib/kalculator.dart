import 'dart:math';

class CalculatorBrain{
  CalculatorBrain({required this.height, required this.weight});

  final double height;
  final double weight;
  double _bmi=0;


  String calculateBMI(){
    _bmi=weight/pow(height,2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if (_bmi>=40){
      return 'Otyłość III stopnia';
    }
    else if(_bmi>=35.0){
      return 'Otyłość II stopnia';
    }
    else if(_bmi>=30.0){
      return 'Otyłość I stopnia';
    }
    else if(_bmi>=25.0){
      return 'nadwaga';
    }
    else if(_bmi>=18.5){
      return 'Waga prawidłowa';
    }
    else if(_bmi>=17.0){
      return 'Niedowaga';
    }
    else if(_bmi>=16.0){
      return 'Wychudzenie';
    }
    else{
      return 'Wygłodzenie';
    }
  }


}