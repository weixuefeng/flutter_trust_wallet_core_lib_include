/*
 * @Author: pony@diynova.com
 * @Date: 2022-05-12 22:15:31
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-05-16 11:34:20
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/network/rpc_ethereum.dart
 * @Description: 
 */
import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'rpc_interface.dart';

class RpcEthereum extends RpcInterface {
  final mHttpClient = Client();

  late final Web3Client mWeb3Client;

  RpcEthereum(String url) {
    mWeb3Client = Web3Client(url, mHttpClient);
  }

  @override
  Future<BigInt> estimateGas(
      {EthereumAddress? sender,
      EthereumAddress? to,
      EtherAmount? value,
      BigInt? amountOfGas,
      EtherAmount? gasPrice,
      EtherAmount? maxPriorityFeePerGas,
      EtherAmount? maxFeePerGas,
      Uint8List? data,
      BlockNum? atBlock}) {
    throw UnimplementedError();
  }

  @override
  Future<BigInt?> gasPrice() {
    return mWeb3Client
        .getGasPrice()
        .then((value) => value.getValueInUnitBI(EtherUnit.wei));
  }

  @override
  Future<BigInt?> getBalance(String address) async {
    print("getBalance: $address");
    var b = await mWeb3Client.getBalance(EthereumAddress.fromHex(address));
    print(b);
    return mWeb3Client
        .getBalance(EthereumAddress.fromHex(address))
        .then((value) => value.getValueInUnitBI(EtherUnit.wei));
  }

  @override
  Future<int> getTransactionCount(String address) {
    return mWeb3Client.getTransactionCount(EthereumAddress.fromHex(address));
  }

  @override
  Future<String> sendRawTransaction(Uint8List signedTransaction) {
    throw UnimplementedError();
  }
}
