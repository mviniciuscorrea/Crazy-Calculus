import 'dart:math';

class Calc {
  final Map<int, String> listaOper = {
    0: '+',
    1: '-',
    2: '*',
    3: '/',
  };

  List<int> raffleNumber() {
    return [
      Random().nextInt(19) + 1,
      Random().nextInt(19) + 1,
    ];
  }

  int raffleSimbolIndex() {
    return Random().nextInt(listaOper.length);
  }

  num calcTotal({required int indexSimbol, required List<int> numbers}) {
    num _total = 0;

    switch (indexSimbol) {
      case 0:
        _total = numbers[0] + numbers[1];
        break;
      case 1:
        _total = numbers[0] - numbers[1];
        break;
      case 2:
        _total = numbers[0] * numbers[1];
        break;
      case 3:
        _total = numbers[0] / numbers[1];

        break;
    }

    return _total;
  }
}
