import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valet_parking/home/bloc/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController plateTextController = TextEditingController();
  final TextEditingController carOwnerTextController = TextEditingController();
  final TextEditingController rateTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showAddCarDialog(context),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return const Center(
              child: Text('No hay carros registrados'),
            );
          }
          if (state is HomeShowCarsState) {
            return ListView(
              children: state.cars
                  .map(
                    (e) => ListTile(
                      title: Text(e.plateNumber),
                      subtitle: Text(e.owner),
                    ),
                  )
                  .toList(),
            );
          }
          return Container();
        },
      ),
    );
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
            onPressed: () {},
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
              BlocProvider.of<HomeBloc>(context).add(UpdateCarsListEvent());
              Navigator.of(context).pop();
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
