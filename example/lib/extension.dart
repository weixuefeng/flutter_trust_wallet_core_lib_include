/*
 * @Author: pony@diynova.com
 * @Date: 2022-06-01 21:19:36
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-06-01 21:37:43
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/extension.dart
 * @Description: 
 */
import 'dart:typed_data';

import 'package:convert/convert.dart';

extension intExtension on int {
  toUint8List() {
    String numStr = this.toRadixString(16);
    if (numStr.length % 2 != 0) {
      numStr = "0" + numStr;
    }
    return numStr.toUint8List();
  }
}

extension BigintExtension on BigInt {
  toUint8List() {
    String numStr = this.toRadixString(16);
    if (numStr.length % 2 != 0) {
      numStr = "0" + numStr;
    }
    return numStr.toUint8List();
  }
}

extension stringExtension on String {
  toUint8List() {
    List<int> data = hex.decode(this);
    return Uint8List.fromList(data);
  }
}
