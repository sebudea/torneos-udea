import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class ReglamentoView extends StatelessWidget {
  const ReglamentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 16, right: 16, top: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Reglamento",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text(
                AppConstants.reglamentoArticulo1,
              ),
              const SizedBox(height: 16),
              const Text(
                AppConstants.reglamentoArticulo2,
              ),
              const SizedBox(height: 16),
              const Text(
                AppConstants.reglamentoArticulo3,
              ),
              const SizedBox(height: 16),
              Text(
                AppConstants.reglamentoCapitulo2,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                AppConstants.reglamentoArticulo4,
              ),
              const SizedBox(height: 8),
              const Text(
                AppConstants.reglamentoArticulo5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
