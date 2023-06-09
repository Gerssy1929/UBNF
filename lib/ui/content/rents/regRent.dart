import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import 'package:http/http.dart' as http;

import '../../../domain/controllers/Firebase/controllerProp.dart';
import '../../../domain/controllers/Firebase/controllerRent.dart';
import '../../../domain/controllers/Firebase/controllerUser.dart';

class RegRent extends StatefulWidget {
  const RegRent({super.key});

  @override
  State<RegRent> createState() => _RegRentState();
}

class _RegRentState extends State<RegRent> {
  final _formKey = GlobalKey<FormState>();
  //DateTime? fechai;
  //DateTime? fechaf;
  ControlProp controlp = Get.find();
  ControlUserAuth controlu = Get.find();
  ControllerRent controlre = Get.find();

  TextEditingController fechai = TextEditingController();
  TextEditingController fechaf = TextEditingController();
  dynamic args;
  late dynamic propId;
  late dynamic namep;
  late dynamic addp;
  late dynamic cityp;
  late dynamic pricep;
  late dynamic tax;
  late dynamic clean;
  late dynamic picture;
  late dynamic totalPrice;
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    args = Get.arguments;
    propId = args[0];
    namep = args[1];
    addp = args[2];
    cityp = args[3];
    pricep = args[4];
    tax = args[5];
    clean = args[6];
    picture = args[7];
    totalPrice = pricep + tax + clean;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController total = TextEditingController();

    total.text = totalPrice.toString();

    late int visit;
    late int card;
    late int cvv;

    return Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      right: 35,
                      left: 35,
                      top: MediaQuery.of(context).size.height * 0),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 56, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Image(
                                    image: AssetImage('assets/images/logo.png'),
                                    width: 85,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  ))
                            ],
                          )),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text('Ya casi es tuyo...',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: SizedBox(
                          child: Card(
                            margin: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        picture,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          namep,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          addp + "," + cityp,
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          "COP: ${pricep.toString()}",
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                        const SizedBox(height: 16.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        autocorrect: false,
                        controller: fechai,
                        style: const TextStyle(
                            color:
                                Colors.blue, // Cambia el color del texto a azul
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),

                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                            labelText: 'Fecha de inicio',
                            labelStyle: TextStyle(
                                decorationStyle: TextDecorationStyle.solid),
                            hintText: 'Inicio',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            focusColor: Colors.deepPurpleAccent),
                        readOnly: true,
                        onTap: () {
                          _selectDatei();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        maxLines: 1,

                        validator: Validatorless.multiple([
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   fechai = DateTime.parse(value!);
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        autocorrect: false,
                        controller: fechaf,
                        style: const TextStyle(
                            color:
                                Colors.blue, // Cambia el color del texto a azul
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),

                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                            labelText: 'Fecha final',
                            labelStyle: TextStyle(
                                decorationStyle: TextDecorationStyle.solid),
                            hintText: 'Final...',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            focusColor: Colors.deepPurpleAccent),
                        readOnly: true,
                        onTap: () {
                          _selectDatef();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        maxLines: 1,

                        validator: Validatorless.multiple([
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        // onSaved: (value) {
                        //   fechaf = DateTime.parse(value!);
                        // },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Visitantes',
                          hintText: '# de visitantes',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.number("Ingrese un valor"),
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        onSaved: (value) {
                          visit = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: '# Tarjeta',
                          hintText: '# Tarjeta',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.number("Ingrese un valor"),
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        onSaved: (value) {
                          card = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          hintText: 'CVV',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.number("Ingrese un valor"),
                          Validatorless.required('El campo es obligatorio')
                        ]),
                        onSaved: (value) {
                          visit = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 0.0),
                      TextFormField(
                        controller: total,
                        autofocus: false,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Total',
                          hintText: 'Total...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                        readOnly: true,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Por favor, introduce la dirección del lugar';
                        //   }

                        //   return null;
                        // },
                        // onSaved: (value) {
                        //   descri = value!;
                        // },
                      ),
                      const SizedBox(height: 16.0),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       // if (_formKey.currentState!.validate()) {
                      //       //   _formKey.currentState!.save();

                      //       //   Map<String, dynamic> rentData = {
                      //       //     'renter': controlu.userValido!.user!.uid,
                      //       //     'prop': propId,
                      //       //     'name': namep,
                      //       //     'address': addp,
                      //       //     'visit': visit,
                      //       //     'total': total.text,
                      //       //     'fechai': fechai.text,
                      //       //     'fechaf': fechaf.text,
                      //       //   };

                      //       //   controlre.crearRent(rentData);
                      //       //   controlp
                      //       //       .listProp()
                      //       //       .then((value) => Get.toNamed("/places"));
                      //       // }
                      //       await payment();
                      //     },
                      //     style: ButtonStyle(
                      //       minimumSize:
                      //           MaterialStateProperty.all(const Size(10, 40)),
                      //       backgroundColor: MaterialStateProperty.all(Colors
                      //           .blueAccent), // Cambia el color de fondo del botón a rojo
                      //       foregroundColor: MaterialStateProperty.all(Colors
                      //           .white), // Cambia el color del texto del botón a blanco
                      //     ),
                      //     child: const Text('Añadir información de pago')),
                      // const SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              Map<String, dynamic> rentData = {
                                'renter': controlu.userValido!.user!.uid,
                                'prop': propId,
                                'name': namep,
                                'address': addp,
                                'visit': visit,
                                'total': total.text,
                                'fechai': fechai.text,
                                'fechaf': fechaf.text,
                              };

                              controlre.crearRent(rentData);
                              controlp
                                  .listProp()
                                  .then((value) => Get.toNamed("/places"));
                            }
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(10, 40)),
                            backgroundColor: MaterialStateProperty.all(Colors
                                .blueAccent), // Cambia el color de fondo del botón a rojo
                            foregroundColor: MaterialStateProperty.all(Colors
                                .white), // Cambia el color del texto del botón a blanco
                          ),
                          child: const Text('Rentar')),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 8.0),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Get.back(),
                              ),
                            )
                          ])
                    ],
                  )),
            )));
  }

  Future<void> payment() async {
    try {
      paymentIntent = await createPaymentIntent(totalPrice.toString(), 'GBP');
      var gpay = const stripe.PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

      await stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: stripe.SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Abhi',
                  googlePay: gpay))
          .then((value) {});

      displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
      });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future _selectDatei() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));

    if (picked != null) {
      String formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() => {fechai.text = formattedDate});
    }
  }

  Future _selectDatef() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));
    if (picked != null) {
      String formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() => {fechaf.text = formattedDate});
    }
  }
}
