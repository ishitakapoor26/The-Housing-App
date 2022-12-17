import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AgentVerificationScreen.dart';

class AdminAgentScreen extends StatefulWidget {
  const AdminAgentScreen({Key? key}) : super(key: key);

  @override
  State<AdminAgentScreen> createState() => _AdminAgentScreenState();
}

class _AdminAgentScreenState extends State<AdminAgentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 100),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.verified),
                text: 'Verified',
              ),
              Tab(
                icon: Icon(Icons.pending),
                text: 'Pending',
              ),
              // Tab(icon: Icon(Icons.logout),
              //   text: 'Logout',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Center(child: Text("Verified")),
            // Center(child: Text("Pending"))
            AgentVerifyScreen(),
            AgentPendingScreen()
          ],
        ),
      ),
    );
  }
}

class AgentVerifyScreen extends StatefulWidget {
  @override
  _AgentVerifyScreenState createState() => _AgentVerifyScreenState();
}

class _AgentVerifyScreenState extends State<AgentVerifyScreen> {
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('agent')
      .where('isVerified', isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                print(document);
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgentVerificationScreen(
                                  data: data,
                                )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5.0)),
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Hero(
                            tag: data['uid'],
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(data['profilePhoto']),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Name : ${data['name']}'),
                              Text('Email : ${data['email']}')
                            ],
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class AgentPendingScreen extends StatefulWidget {
  @override
  _AgentPendingScreenState createState() => _AgentPendingScreenState();
}

class _AgentPendingScreenState extends State<AgentPendingScreen> {
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('agent')
      .where('isVerified', isEqualTo: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                print(document);
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgentVerificationScreen(
                                  data: data,
                                )),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5.0)),
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Hero(
                            tag: data['uid'],
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(data['profilePhoto']),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Name : ${data['name']}'),
                              Text('Email : ${data['email']}')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
