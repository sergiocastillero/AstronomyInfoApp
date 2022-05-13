import 'package:flutter/material.dart';
import 'package:flutterapi/ApiService/ApiService.dart';
import 'package:flutterapi/ApiService/ApodList.dart';
import 'package:flutterapi/screens/DetailsScreen/detailsSceen.dart';
import 'package:http/http.dart' as http;

final ApiService apiService = ApiService();

class ListSceen extends StatelessWidget {
  const ListSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch Data Example",
      home: FutureBuilder<List<ApodList>>(
        future: apiService.getListData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white, strokeWidth: 4));
            case ConnectionState.done:
              if (snapshot.hasData) {
                return MyListPage(snapshot: snapshot);
              } else {
                return Text('${snapshot.error}');
              }
          }
        },
      ),
    );
  }
}

class MyListPage extends StatefulWidget {
  AsyncSnapshot<List<ApodList>> snapshot;
  MyListPage({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: widget.snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, index) => Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              data: widget.snapshot.data![index])));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.5,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.snapshot.data![index].url),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            "${widget.snapshot.data![index].title}",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.snapshot.data![index].date}",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]);
  }
}
