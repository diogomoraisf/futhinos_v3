class DoubleNoRound {
  static String getNumber(double data, {int decimalPlaces = 1}) {
    List<String> values = data.toString().split('.');
    if (values.length == 2 &&
        values[0] != '0' &&
        values[1].length >= decimalPlaces &&
        decimalPlaces > 0) {
      return '${values[0]}.${values[1].substring(0, decimalPlaces)}';
    } else {
      return data.toString();
    }
  }
}
