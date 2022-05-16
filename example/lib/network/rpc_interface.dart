/*
 * @Author: pony@diynova.com
 * @Date: 2022-05-12 22:15:03
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-05-16 11:23:57
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/network/rpc_interface.dart
 * @Description: 
 */

import 'dart:typed_data';

import 'package:web3dart/web3dart.dart';

abstract class RpcInterface {
  Future<BigInt?> getBalance(String address);

  Future<int> getTransactionCount(String address);

  Future<BigInt?> gasPrice();

  // Future<int?> estimateGas(String? address, String? from, int? gas,
  //     int? gasPrice, int? value, EthereumData? data);

  Future<BigInt> estimateGas({
    EthereumAddress? sender,
    EthereumAddress? to,
    EtherAmount? value,
    BigInt? amountOfGas,
    EtherAmount? gasPrice,
    EtherAmount? maxPriorityFeePerGas,
    EtherAmount? maxFeePerGas,
    Uint8List? data,
    @Deprecated('Parameter is ignored') BlockNum? atBlock,
  });

  Future<String> sendRawTransaction(Uint8List signedTransaction);
}
