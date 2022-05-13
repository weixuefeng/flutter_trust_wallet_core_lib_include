/*
 * @Author: pony@diynova.com
 * @Date: 2022-05-12 22:15:31
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-05-13 11:58:24
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/network/rpc_ethereum.dart
 * @Description: 
 */
import 'dart:async';

import 'package:ethereum/ethereum.dart';
import 'package:ethereum/ethereum_server_client.dart';

import 'rpc_interface.dart';
import 'package:http/http.dart' as http;

class MyEthereumServerHTTPAdapter implements EthereumINetworkAdapter {
  /// Mime type
  static const String jsonMimeType = 'application/json';

  /// Processes the HTTP request returning the  HTTP response as
  /// a map
  @override
  Future<Map<dynamic, dynamic>> httpRequest(
      Uri? uri, Map<String, dynamic> request) {
    print("request");
    // final client = HttpClient();
    // final completer = Completer<Map<dynamic, dynamic>>();
    // client.postUrl(uri!).then((HttpClientRequest req) {
    //   final dynamic payload = json.encode(request);
    //   req.headers.add(HttpHeaders.contentTypeHeader, jsonMimeType);
    //   req.contentLength = payload.length;
    //   req.write(payload);
    //   req.close().then((HttpClientResponse resp) {
    //     resp.listen(
    //       (dynamic data) {
    //         final Map<dynamic, dynamic>? payload =
    //             json.decode(String.fromCharCodes(data));
    //         completer.complete(payload);
    //       },
    //       onError: print,
    //     );
    //   });
    // }, onError: print);
    // return completer.future;

    // http.post(uri)
    final completer = Completer<Map<dynamic, dynamic>>();
    print(request);
    return completer.future;
  }
}

class RpcEthereum extends RpcInterface {
  final mClient = EthereumServerClient();

  final mDefaultBlock = EthereumDefaultBlock();

  RpcEthereum() {
    mClient.httpAdapter = MyEthereumServerHTTPAdapter();
    mClient.connectParameters("http", "101.32.170.145", 8801);
  }

  @override
  Future<BigInt?> getBalance(String address) async {
    EthereumAddress formatAddress = EthereumAddress.fromString(address);
    return await mClient.eth!.getBalance(formatAddress, mDefaultBlock);
  }

  @override
  Future<int?> getTransactionCount(String address) async {
    EthereumAddress formatAddress = EthereumAddress.fromString(address);
    return await mClient.eth!.getTransactionCount(formatAddress, mDefaultBlock);
  }

  @override
  Future<int?> estimateGas(String? address, String? from, int? gas,
      int? gasPrice, int? value, EthereumData? data) async {
    EthereumAddress formatToAddress = EthereumAddress.fromString(address!);
    EthereumAddress formatFromAddress = EthereumAddress.fromString(from!);
    return await mClient.eth!.estimateGas(
        address: formatToAddress,
        from: formatFromAddress,
        gas: gas,
        gasPrice: gasPrice,
        value: value,
        data: data);
  }

  @override
  Future<int?> gasPrice() async {
    return await mClient.eth!.gasPrice();
  }

  @override
  Future<EthereumData?> sendRawTransaction(
      EthereumData? signedTransaction) async {
    return await mClient.eth!.sendRawTransaction(signedTransaction);
  }
}
