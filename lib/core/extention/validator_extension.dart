extension ValidatorX on String {
  bool get isValidPhone =>
      RegExp(r'^(0|\+84)(3|5|7|8|9)[0-9]{8}$').hasMatch(this);

  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPassword => length >= 6;
}
