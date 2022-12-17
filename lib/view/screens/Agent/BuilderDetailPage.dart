import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/calendly/main.dart';
import 'package:housingapp/models/properties.dart';
import '../Builder/PropertydetailScreen.dart';

class BuilderDetailScreen extends StatefulWidget {
  Map<String, dynamic> data;

  BuilderDetailScreen({Key? key, required this.data, }) : super(key: key);

  @override
  State<BuilderDetailScreen> createState() => _BuilderDetailScreenState(data: data);
}

class _BuilderDetailScreenState extends State<BuilderDetailScreen> {
  _BuilderDetailScreenState({required this.data, });
  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyCalendlyApp()));
          },
          icon: Icon(Icons.calendar_month),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                  child: CircleAvatar(
                radius: 80,
              )),

              SizedBox(height: 40,),
              Text('    Name: ${data['name']}'),
              SizedBox(
                height: 10,
              ),

              Text('    Email: ${data['email']}'),
              SizedBox(
                height: 10,
              ),
              Text('    Phone: ${data['ph_no']} '),

              SizedBox(
                height: 10,
              ),
              Text('    Rera: ${data['rera_no']}'),
              SizedBox(
                height: 10,
              ),
              Text('    Company : ${data['company_name']}'),
              SizedBox(
                height: 10,
              ),
              Text('    Company Address: ${data['company_add']}'),
              SizedBox(
                height: 10,
              ),

              Center(child:
              MaterialButton(
              //  animationDuration: Duration(seconds: 5),
                color: Colors.blue,
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AgentBuilderPropertyPage(document: data['uid'],)));
                  },
                  child: Text('Properties'))),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}


class AgentBuilderPropertyPage extends StatefulWidget {
  AgentBuilderPropertyPage({Key? key, required this.document}) : super(key: key);
  String document;
  @override
  State<AgentBuilderPropertyPage> createState() => _AgentBuilderPropertyPage(document: document);
}

class _AgentBuilderPropertyPage extends State<AgentBuilderPropertyPage> {
  _AgentBuilderPropertyPage({required this.document});
  String document;

  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
    FirebaseFirestore.instance.collection('builder').doc(document).collection('properties').snapshots();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 5,right: 5),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                //  final PropertyDetail propertyModel ;
                return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AgentBuilderDetailCard(
                        document: document,
                        usersStream: usersStream, image: data['image'][0], title: data['type'], name: data['projectname'], ),
                    )
                );
              }).toList(),
            );
          },
        ),
      ),

    );
  }
}

class AgentBuilderDetailCard extends StatelessWidget {
  const AgentBuilderDetailCard({
    Key? key,
    required this.usersStream, required this.image, required this.title, required this.name, required this.document,
  }) : super(key: key);
  final Stream<QuerySnapshot> usersStream;
  //final PropertyDetail propertyDetail;
  final String image;
  final String title;
  final DocumentSnapshot document;
  final String name;
  @override
  Widget build(BuildContext context) {

    // var data = (FirebaseFirestore.instance.collection("builder").doc('MSCf9WszspWuvMwOAHQil378woC3').collection('poperties').docs('').get().data() as dynamic)['name'];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PropertyDetailScreen(data:Properties.fromSnap(document),)
          //DetailsPage(propertyDetail: propertyDetail, usersStream: usersStream),
        ),
      ),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                height: 120,
                width: double.infinity,
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffE5CE6A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              " 5 rooms - 2500 square foots - 2 floors",
              style: Theme.of(context).textTheme.caption!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
