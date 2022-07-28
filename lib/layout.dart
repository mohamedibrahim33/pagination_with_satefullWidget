import 'package:flutter/material.dart';
import 'package:pagination/api_model.dart';

import 'api_service.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  var scrollController = ScrollController();
  int offset = 0;
  int offsetEnd = 60;
  bool isLoading = true;
  List<Character> characters = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(() {
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        if(offset!=offsetEnd){
          fetchData();
        }
      }
    });
  }

  fetchData() {
    CharactersServices().fetchData(offset).then((value) {
      setState(() {
        characters.addAll(value);
        offset=offset+10;
        isLoading = false;
      });
    }).catchError((error) {
      print('error is $error');
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pagination'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: characters.length+1,
              itemBuilder: (context, index) {
                  if(index==characters.length){
                    if(offset==offsetEnd){
                      return Container();
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                return Card(
                  child: ListTile(
                    leading: Image.network(characters[index].img),
                    title: Text(characters[index].name),
                  ),
                );
              },
            ),
    );
  }
}
