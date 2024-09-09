import 'package:crud/model/api_model.dart';
import 'package:crud/service/api_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiModel apiData = ApiModel();
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Colors.blue[400],
      ),
      body: FutureBuilder(
        future: apiService.getData(),
        builder: (context, snapshot) {
          //handle network Connection
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          //handle error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          //handle if api has data
          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var data = snapshot.data!;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title ?? 'No title'),
                  subtitle: Text(data[index].subtitle.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await apiService.updataData(data[index].sId);
                            setState(() {});
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await apiService.deleteData(data[index].sId);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                );
              },
            );
          } else {
            // Handle empty data
            return Center(child: Text('No data available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          apiService.addData();
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
