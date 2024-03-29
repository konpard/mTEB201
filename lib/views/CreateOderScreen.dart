import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:order_processing_app/utils/constants.dart';

import 'HomeScreen.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {

  TextEditingController productNameController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientAddressController = TextEditingController();
  TextEditingController clientContactController = TextEditingController();
  TextEditingController buyPriceController = TextEditingController();
  TextEditingController sellPriceController = TextEditingController();
  TextEditingController sellDateController = TextEditingController();

  User? user =  FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      hintText: "Название компании перевозок",
                      labelText: "Название компании перевозок",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller:  clientNameController,
                  decoration: InputDecoration(
                      hintText: "Имя клиента",
                      labelText: "Имя клиента",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: clientAddressController,
                  decoration: InputDecoration(
                      hintText: "Адрес клиента",
                      labelText: "Адрес клиента",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: clientContactController,
                  decoration: InputDecoration(
                      hintText: "Телефон клиента",
                      labelText: "Телефон клиента",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: buyPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Цена",
                      labelText: "Цена",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: sellPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Количество груза",
                      labelText: "Количество груза",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: sellDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                        hintText: "Дата отгрузки",
                      labelText: "Дата отгрузки",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              ElevatedButton(onPressed: () async {

                EasyLoading.show();
                var profit = int.parse(sellPriceController.text.trim()) - int.parse(buyPriceController.text.trim());

                Map<String,dynamic> userOrderMap = {
                  'userId': user?.uid,
                  'productName':  productNameController.text.trim(),
                  'clientName': clientNameController.text.trim(),
                  'clientAddress':  clientAddressController.text.trim(),
                  'clientContact': clientContactController.text.trim(),
                  'buyPrice': buyPriceController.text.trim(),
                  'sellPrice': sellPriceController.text.trim(),
                  'sellDate': sellDateController.text.trim(),
                  'date': DateTime.now(),
                  'profit': profit,
                  'status': "Ожидание"
              };
                await FirebaseFirestore.instance.collection('Заказы').doc().set(userOrderMap);

                Fluttertoast.showToast(msg: "Заказ успешно создан");
                Get.to(const HomeScreen());
                EasyLoading.dismiss();

              }, child: const Text("Создать заказ перевозки")),

            ],
          ),
        ),
      ),
    );
  }
}
