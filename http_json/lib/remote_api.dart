import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_json/model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({super.key});

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  Future<List<UserModel>> _getUserList() async {
    try {
      var response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");
      List<UserModel> _userList = [];
      if (response.statusCode == 200) {
        _userList =
            (response.data as List).map((e) => UserModel.fromMap(e)).toList();
      }
      return _userList;
    } on DioException catch (e) {
      return Future.error(e.message as Object);
    }
  }

  late final Future<List<UserModel>> userList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userList = _getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Remote Api'),
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
          future: userList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userList = snapshot.data!;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var user = userList[index];
                  return ListTile(
                    title: Text(user.email),
                    subtitle: Text(user.address.toString()),
                    leading: Text(user.id.toString()),
                  );
                },
                itemCount: userList.length,
              );
            } else if (snapshot.hasError) {
              // Hata durumunda bir Widget döndürmeli
              return Text(snapshot.error.toString());
            } else {
              // Veri beklenirken bir Widget döndürmeli

              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
