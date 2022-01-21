import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);
  // final String targetID;

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      body: ListView(
        children: List.generate(
          _usersProvier.users.length,
          (index) {
            return InkWell(
              onTap: () {
                debugPrint('statement');
                _usersProvier.setUser(_usersProvier.users[index]);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CahtView(),
                  ),
                );
              },
              child: Container(
                color: Colors.grey.shade200,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_usersProvier.users[index].id),
                    Text(_usersProvier.users[index].name),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserModel {
  final String id;
  final String name;

  UserModel({required this.id, required this.name});
}

class CahtView extends StatefulWidget {
  const CahtView({Key? key}) : super(key: key);

  @override
  State<CahtView> createState() => _CahtViewState();
}

class _CahtViewState extends State<CahtView> {
  Socket socket = io("http://127.0.0.1:3000/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  }); //initalize the Socket.IO Client Object

  @override
  void initState() {
    super.initState();
    //--> call the initializeSocket method in the initState of our app.
    initializeSocket();
  }

  @override
  void dispose() {
    super.dispose();
    // --> disconnects the Socket.IO client once the screen is disposed
    socket.disconnect();
  }

  final String ipAddress = '192.168.2.225';
  void initializeSocket() {
    print('initializeSocket');
    try {
      socket = io("http://$ipAddress:5000/", <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });
      //connect the Socket.IO Client to the Server
      socket.connect();
      //SOCKET EVENTS
      // --> listening for connection
      socket.on('connect', (data) {
        print('socket.connected = ${socket.connected}');
      });

      //listen for incoming messages from the Server.
      socket.on('message', (data) {
        print(data); //
      });

      //listens when the client is disconnected from the Server
      socket.on('disconnect', (data) {
        print('socket = ${socket.connected}');
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMessage(String message, String targetID) {
    debugPrint('sendMessage');
    socket.emit(
      "message",
      {
        "id": socket.id,
        "message": message, //--> message to be sent
        "username": targetID,
        "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _usersProvier = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_usersProvier.currentUser.name),
      ),
      body: ListView(
        children: const [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendMessage('hi mohamed', _usersProvier.currentUser.name);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserProvider extends ChangeNotifier {
  var users = <UserModel>[
    UserModel(id: '1', name: 'mohamed'),
    UserModel(id: '2', name: 'syed'),
    UserModel(id: '3', name: 'suliman'),
    UserModel(id: '4', name: 'abbas'),
  ];
  final resetUsers = <UserModel>[
    UserModel(id: '1', name: 'mohamed'),
    UserModel(id: '2', name: 'syed'),
    UserModel(id: '3', name: 'suliman'),
    UserModel(id: '4', name: 'abbas'),
  ];
  //
  UserModel _currentUser = UserModel(id: '', name: '');

  UserModel get currentUser => _currentUser;
  //
  void setUser(UserModel userModel) {
    _currentUser = userModel;
    debugPrint('current user = ${_currentUser.name}');
    removeUser(userModel);
    notifyListeners();
  }

  void removeUser(UserModel userModel) {
    users.remove(userModel);
  }

  void getUsers() {
    users = resetUsers;
    notifyListeners();
  }
}
