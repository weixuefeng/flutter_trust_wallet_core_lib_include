/*
 * @Author: pony@diynova.com
 * @Date: 2022-05-11 09:57:24
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-06-01 21:11:35
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/uint8list.dart
 * @Description: 
 */
import 'dart:typed_data';

import 'package:convert/convert.dart';

class Utils {
  static string2Uint8List(String input) {
    List<int> data = hex.decode(input);
    return Uint8List.fromList(data);
  }

  static number2Uint8List(BigInt number) {
    String numStr = number.toRadixString(16);
    if (numStr.length % 2 != 0) {
      numStr = "0" + numStr;
    }
    print("number: ${numStr}");
    return string2Uint8List(numStr);
  }
}
