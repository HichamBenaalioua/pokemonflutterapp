import 'package:flutter/material.dart';
import 'package:pokimonapp/services/pokiapiservice.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> names = [];

  void loadNames() async {
    PokiApi p = PokiApi();
    await p.requestNames();
    names = p.pokinames!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Center(child: Text("PokéDex")),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 4 / 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            itemCount: names.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 7,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: {"id": index, "name": names[index]['name']});
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${index + 1}.png"),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${names[index]['name'].toString().toUpperCase()}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              letterSpacing: 2),
                        )
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
