import 'package:flutter_test/flutter_test.dart';

import 'calculator.dart';

void main(){

group("i want to test calculator ", () {


  test('i want to test addition of 2 numbers',(){
    Calculator calc = Calculator();

    int result = calc.add(5, 8);

    expect(result, 13);
    expect(result, isNot(10));
  });

  test('i want to test subtraction of 2 numbers',(){
    Calculator calc = Calculator();

    int result = calc.sub(10, 8);

    expect(result, 2);
    expect(result, isNot(10));
  });
  test('i want to test multiplication of 2 numbers',(){
    Calculator calc = Calculator();

    int result = calc.mul(5, 8);

    expect(result, 40);
    expect(result, isNot(60));
  });
  test('i want to test division of 2 numbers',(){
    Calculator calc = Calculator();

    double result = calc.div(15, 3);

    expect(result, 5);
    expect(result, isNot(3));
  });
});

}