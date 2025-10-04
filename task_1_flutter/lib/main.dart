import 'dart:io';

void main() {
  // Take name and age
  print("Enter your name: ");
  String? name = stdin.readLineSync();

  print("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!);

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return; // stop program
  }

  // Ask how many numbers
  print("How many numbers do you want to enter?");
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];

  for (int i = 0; i < n; i++) {
    print("Enter number ${i + 1}: ");
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  int sumEven = 0;
  int sumOdd = 0;
  int largest = numbers[0];
  int smallest = numbers[0];

  for (int num in numbers) {
    if (num % 2 == 0) {
      sumEven = sumEven + num;
    } else {
      sumOdd = sumOdd + num;
    }

    if (num > largest) {
      largest = num;
    }
    if (num < smallest) {
      smallest = num;
    }
  }

  print("Sum of even numbers: $sumEven");
  print("Sum of odd numbers: $sumOdd");
  print("Largest number: $largest");
  print("Smallest number: $smallest");
}
