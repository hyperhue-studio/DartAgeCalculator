import 'dart:io';

void main() {
  String? birthDateStr;
  DateTime? birthDate;

  // Ask the user for their birth date in the format mm-dd-yyyy
  while (true) {
    stdout.write('Enter your birth date (mm-dd-yyyy): ');
    birthDateStr = stdin.readLineSync();
    if (validateDateFormat(birthDateStr)) {
      List<int> dateParts = birthDateStr!.split('-').map(int.parse).toList();
      if (validateDate(dateParts)) {
        birthDate = DateTime(dateParts[2], dateParts[0], dateParts[1]);
        break;
      } else {
        print('The entered date is not valid.');
      }
    } else {
      print('The entered date format is not valid. Please use mm-dd-yyyy.');
    }
  }

  // Calculate age
  DateTime currentDate = DateTime.now();
  Duration difference = currentDate.difference(birthDate);
  int ageYears = difference.inDays ~/ 365;
  int ageMonths = (difference.inDays % 365) ~/ 30;
  int ageDays = (difference.inDays % 365) % 30;

  // Display age
  print('Your age is: $ageYears years, $ageMonths months, and $ageDays days.');
}

// Validate the date format
bool validateDateFormat(String? date) {
  if (date == null || date.length != 10) return false;
  for (int i = 0; i < date.length; i++) {
    if (i == 2 || i == 5) {
      if (date[i] != '-') return false;
    } else {
      if (!isNumber(date[i])) return false;
    }
  }
  return true;
}

// Validate if the date is valid
bool validateDate(List<int> date) {
  if (date[0] < 1 || date[0] > 12 || date[2] < 1900 || date[2] > 2100)
    return false;
  List<int> daysInMonth = [
    31,
    isLeapYear(date[2]) ? 29 : 28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  if (date[1] < 1 || date[1] > daysInMonth[date[0] - 1]) return false;
  return true;
}

// Check if the year is a leap year
bool isLeapYear(int year) {
  return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

// Check if the character is a number
bool isNumber(String char) {
  return char.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
      char.codeUnitAt(0) <= '9'.codeUnitAt(0);
}
