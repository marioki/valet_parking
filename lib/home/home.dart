import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:valet_parking/car_details/bloc/car_details_bloc.dart';
import 'package:valet_parking/car_details/car_details.dart';
import 'package:valet_parking/home/bloc/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController plateTextController = TextEditingController();
  final TextEditingController carOwnerTextController = TextEditingController();
  final TextEditingController rateTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valet App'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showAddCarDialog(context),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeShowCarsState) {
            return state.cars.isNotEmpty
                ? ListView(
                    children: state.cars
                        .map(
                          (e) => ListTile(
                            onTap: () {
                              BlocProvider.of<CarDetailsBloc>(context)
                                  .add(ShowCarDetailsEvent(e.key));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CarDetialsPage(),
                                ),
                              );
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.plateNumber),
                                Text('Tarifa: \$${e.rate}')
                              ],
                            ),
                            subtitle: Text(e.owner),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('check in:'),
                                Text(DateFormat.Hms().format(e.checkInDate)),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                : const Center(
                    child: Text('No hay vehiculos registrados...'),
                  );
          }
          return Container();
        },
      ),
    );
  }

  clearTextControllers() {
    plateTextController.clear();
    carOwnerTextController.clear();
    rateTextController.clear();
  }

  showAddCarDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar Vehiculo'),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                controller: plateTextController,
                decoration: const InputDecoration(
                  label: Text('Numero de Placa'),
                ),
              ),
              TextFormField(
                controller: carOwnerTextController,
                decoration: const InputDecoration(
                  label: Text('Nombre del dueño/a'),
                ),
              ),
              TextFormField(
                controller: rateTextController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  label: Text('Tarifa'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              clearTextControllers();
              Navigator.pop(context);
            },
            child: const Text('cancelar'),
          ),
          TextButton(
            onPressed: () {
              var currentDateTime = DateTime.now();
              BlocProvider.of<HomeBloc>(context).add(
                HomeAddCar(
                  carPlate: plateTextController.text,
                  carOwner: carOwnerTextController.text,
                  checkInTime: currentDateTime,
                  rate: double.parse(rateTextController.text),
                ),
              );
              BlocProvider.of<HomeBloc>(context)
                  .add(const UpdateCarsListEvent());
              Navigator.of(context).pop();
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
