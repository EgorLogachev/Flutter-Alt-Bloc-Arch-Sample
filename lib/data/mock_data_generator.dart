import 'dart:math';

class MockDataGenerator {
  const MockDataGenerator(this.options);

  final List<Option> options;

  dynamic next() {
    var weightsSum = 0;
    options.forEach((item) => weightsSum += item.weight);
    var randomWeight = Random().nextInt(weightsSum);
    for (var item in options) {
      randomWeight -= item.weight;
      if (randomWeight < 0) {
        return item.value;
      }
    }
    return null;
  }
}

class Option {
  const Option(this.value, {this.weight = 1});

  final dynamic value;
  final int weight;
}
