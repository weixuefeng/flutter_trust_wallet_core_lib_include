/*
 * @Author: pony@diynova.com
 * @Date: 2022-05-11 09:57:24
 * @LastEditors: pony@diynova.com
 * @LastEditTime: 2022-05-16 11:52:39
 * @FilePath: /flutter_trust_wallet_core_lib_include/example/lib/newchain_example.dart
 * @Description: 
 */
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trust_wallet_core/flutter_trust_wallet_core.dart';
import 'package:flutter_trust_wallet_core/trust_wallet_core_ffi.dart';
import 'package:flutter_trust_wallet_core_example/base_example.dart';
import 'package:flutter_trust_wallet_core/protobuf/Ethereum.pb.dart'
    as Ethereum;
import 'package:flutter_trust_wallet_core_example/network/rpc_ethereum.dart';
import 'package:http/http.dart' as http;

const NewChainTest = "https://rpc3.newchain.cloud.diynova.com";
const EthMian = "https://mainnet.infura.io/v3/3e92ec988e004b09ad2ad8a677d5e0ef";
const EthTest = "https://ropsten.infura.io/v3/3e92ec988e004b09ad2ad8a677d5e0ef";

class NewChainExample extends BaseExample {
  final HDWallet wallet;

  const NewChainExample(this.wallet, {Key? key}) : super('NewChain', key: key);

  @override
  _NewChainExampleState createState() => _NewChainExampleState();
}

class _NewChainExampleState extends BaseExampleState<NewChainExample> {
  @override
  void initState() {
    super.initState();
    logger.d("address ${widget.wallet.getAddressForCoin(1642)}");
    logger.d("mnemonic = ${widget.wallet.mnemonic()}");
    print(widget.wallet.mnemonic());
    String privateKeyhex = hex.encode(widget.wallet.getKeyForCoin(1642).data());
    // String privateKey0 = hex.encode(widget.wallet.getDerivedKey(60,0,0,0).data());
    // String privateKey1 = hex.encode(widget.wallet.getDerivedKey(60,0,0,1).data());
    logger.d("privateKeyhex = $privateKeyhex");
    // logger.d("privateKeyhex0 = $privateKey0");
    // logger.d("privateKeyhex1 = $privateKey1");
    logger.d("seed = ${hex.encode(widget.wallet.seed())}");
    final a = StoredKey.importPrivateKey(
        widget.wallet.getKeyForCoin(1642).data(), "", "123", 1642);
    logger.d("keystore a = ${a?.exportJson()}");

    final publicKey =
        widget.wallet.getKeyForCoin(1642).getPublicKeySecp256k1(false);
    final anyAddress = AnyAddress.createWithPublicKey(publicKey, 1642);

    final privakye = widget.wallet.getKey(1642, "m/44'/1642'/0'/0/0");
    final publicKey1 = privakye.getPublicKeySecp256k1(true);
    final address = AnyAddress.createWithPublicKey(publicKey1, 0);

    logger.d("privakye a = ${hex.encode(privakye.data())}");

    Ethereum.SigningInput input = Ethereum.SigningInput(
        chainId: [1007],
        nonce: [100],
        gasPrice: [100],
        gasLimit: [100],
        maxFeePerGas: [0],
        maxInclusionFeePerGas: [0],
        toAddress: "0xfaC5482fffe86d33c3b8ADB24F839F5e60aF99d4",
        privateKey: privakye.data().toList(),
        transaction: Ethereum.Transaction(
            transfer: Ethereum.Transaction_Transfer(
          amount: [0],
        )));
    logger.d("input = ${input}");
    final output = Ethereum.SigningOutput.fromBuffer(
        AnySigner.sign(input.writeToBuffer(), TWCoinType.TWCoinTypeNewChain)
            .toList());
    logger.d("output = ${hex.encode(output.encoded.toList())}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(children: [
          ElevatedButton(
            child: Text("CHECK1"),
            onPressed: () => {check1()},
          ),
        ])));
  }

  void check1() async {
    RpcEthereum rpc = RpcEthereum(NewChainTest);
    print("check1");
    String address = widget.wallet.getAddressForCoin(1642);
    var balance = await rpc.getBalance(address);
    print("balance: $balance");
    var count = await rpc.getTransactionCount(address);
    var gasPrice = await rpc.gasPrice();
    // var gas = await rpc.estimateGas(address, address, gasPrice, gasPrice, 1,
    //     EthereumData.fromString("0x1"));
    print("balance = $balance, count = $count, gasPrice = $gasPrice");
  }

  void check2() {
    var url = Uri.parse('https://www.newtonproject.org/');
    var response = http.post(url, body: {
      'name': 'doodle',
      'color': 'blue'
    }).then((res) => {print(res.body)});
  }
}
