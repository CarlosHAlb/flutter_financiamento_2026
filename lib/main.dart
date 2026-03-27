import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double valor = 0.0;
  double taxa = 0.0;
  int parcelas = 0;
  double taxasExtras = 0.0;

  double total = 0.0;
  double parcela = 0.0;

  String resultado = "Resultado";

  void calcular() {
    setState(() {
      double taxaDecimal = taxa / 100;

      
      double fator =
          (taxaDecimal * pow(1 + taxaDecimal, parcelas)) /
          (pow(1 + taxaDecimal, parcelas) - 1);

      parcela = valor * fator;

      total = (parcela * parcelas) + taxasExtras;

      resultado =
          "Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}\n"
          "Valor total: R\$ ${total.toStringAsFixed(2)}";
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(resultado),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Simulador de Financiamento"),
          backgroundColor: const Color.fromARGB(255, 118, 71, 54),
        ),  
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Valor do financiamento",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    valor = double.parse(value);
                  },
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Taxa de juros ao mês (%)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    taxa = double.parse(value);
                  },
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Número de parcelas",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    parcelas = int.parse(value);
                  },
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Taxas extras (R\$)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    taxasExtras = double.parse(value);
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: calcular,
                  child: const Text("Calcular"),
                ),

                const SizedBox(height: 20),

                Text("Valor total: R\$ ${total.toStringAsFixed(2)}"),
                Text("Valor da parcela: R\$ ${parcela.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}