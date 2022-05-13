/*
 * @Author: pony@diynova.com
 * @Date: 2022-05-12 22:15:03
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-05-13 11:49:16
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/network/rpc_interface.dart
 * @Description: 
 */
import 'package:ethereum/ethereum.dart';

abstract class RpcInterface {
  Future<BigInt?> getBalance(String address);

  Future<int?> getTransactionCount(String address);

  Future<int?> gasPrice();

  Future<int?> estimateGas(String? address, String? from, int? gas,
      int? gasPrice, int? value, EthereumData? data);

  Future<EthereumData?> sendRawTransaction(EthereumData? signedTransaction);
}
