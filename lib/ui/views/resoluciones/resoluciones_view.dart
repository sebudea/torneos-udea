import 'package:flutter/material.dart';
import 'package:torneos_udea/constants/app_constants.dart';

class ResolucionesView extends StatelessWidget {
  const ResolucionesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppConstants.resolucionTitulo,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              AppConstants.resolucionFecha,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              AppConstants.resolucionParrafo1,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text(AppConstants.resolucionParrafo2),
            Text(
              AppConstants.resolucionSubtitulo,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Text(AppConstants.resolucionParrafo3),
            const Text(AppConstants.resolucionParrafo4),
            const Text(AppConstants.resolucionParrafo5),
            const Text(AppConstants.resolucionParrafo6),
          ],
        ),
      ),
    );
  }
}
