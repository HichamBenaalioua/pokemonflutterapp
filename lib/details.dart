import 'package:flutter/material.dart';
import 'package:pokimonapp/services/pokiapiservice.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map data = {};
  List<Map> types = [];
  List<Widget> widgets = [];
  String description = "↻";

  int rebuild = 0;
  void loadTypes(data) async {
    PokiApi p = PokiApi();
    await p.requestTypes(data);
    types = p.types!;
    widgets = types
        .map((item) => Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(int.parse(item["color"])),
            ),
            child: Center(
                child: Text(
              item["name"].toString().toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 2),
            ))))
        .toList();

    if (!mounted) return;
    if (rebuild <= 1) {
      setState(() {
        rebuild++;
      });
    }
  }

  void loadDescription(data) async {
    PokiApi p = PokiApi();
    await p.requesDescription(data);
    description = p.description!;
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;

    loadTypes((data["id"] + 1).toString());
    loadDescription((data["id"] + 1).toString());

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("${data['name'].toString().toUpperCase()} DETAILS")),
          backgroundColor: Colors.deepPurple[300],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${data['id'] + 1}.png"),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  description.replaceAll("\n", " "),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Type",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widgets),
              ],
            ),
          ),
        ));
  }
}
