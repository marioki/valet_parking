import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valet_parking/car_details/bloc/car_details_bloc.dart';

class CarDetialsPage extends StatelessWidget {
  const CarDetialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles')),
      body: BlocBuilder<CarDetailsBloc, CarDetailsState>(
        builder: (context, state) {
          if (state is LoadCarDetailsState) {
            return Column(
              children: [
                Text('CarPlate: ${state.carDetails.plateNumber}'),
              ],
            );
          }
          return Center(
            child: Text('Cargando datos...'),
          );
        },
      ),
    );
  }
}
