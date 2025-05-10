import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class ReglamentoView extends StatelessWidget {
  const ReglamentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Reglamento"),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppConstants.reglamentoArticulo1,
              ),
              Text(
                AppConstants.reglamentoArticulo2,
              ),
              Text(
                AppConstants.reglamentoArticulo3,
              ),
              Column(
                children: [
                  Text(
                    AppConstants.reglamentoNumeral1,
                  ),
                  Text(
                    AppConstants.reglamentoNumeral2,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
