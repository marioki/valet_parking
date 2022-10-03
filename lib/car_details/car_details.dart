import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valet_parking/car_details/bloc/car_details_bloc.dart';
import 'package:intl/intl.dart';

class CarDetialsPage extends StatelessWidget {
  const CarDetialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CarDetailsBloc, CarDetailsState>(
          builder: (context, state) {
            if (state is LoadCarDetailsState) {
              print('New build...');
              return SizedBox(
                width: screenSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Placa: ${state.carDetails.plateNumber}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    Text('Conductor: ${state.carDetails.owner}'),
                    const SizedBox(height: 16),
                    Text(
                        'Hora de entrada: ${DateFormat.Hms().format(state.carDetails.checkInDate)}'),
                    state.carDetails.isCheckedOut
                        ? Column(
                            children: [
                              Text(
                                  'Hora de Salida: ${DateFormat.Hms().format(state.carDetails.checkOut!)}'),
                              Text(
                                  'Tiempo transcurrido ${state.carDetails.checkInDate.difference(state.carDetails.checkOut!).inMinutes}'),
                              // Text('Saldo a pagar: ${}')
                            ],
                          )
                        : Container(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (() {
                              print('button pressed');
                              BlocProvider.of<CarDetailsBloc>(context).add(
                                  CarCheckOutEvent(
                                      state.carDetails.key, state.carDetails));
                            }),
                            child: const Text('CHECK OUT'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Cargando datos...'),
            );
          },
        ),
      ),
    );
  }
}
