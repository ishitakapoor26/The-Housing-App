import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:housingapp/view/widgets/text_input_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.account_circle_outlined), title: Text("Agent 1")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            sentMessage("Hello Agent"),
            SizedBox(
              height: 5,
            ),
            receivedMessage("Hello Builder"),
            SizedBox(
              height: 5,
            ),
            receivedMessage("Hello Builder"),
            SizedBox(
              height: 5,
            ),
            // TextInputField(icon: IconData(),),
            // TextInput()
            TextFieldInput(
              hintText: 'Message',
              textInputType: TextInputType.text,
              textEditingController: _messageController,
              prefixIcon: Image.asset(
                "assets/vectors/call_calling.png",
                height: 10.0,
                width: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedMessage(message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: Text(message),
        ),
      ],
    );
  }

  Widget sentMessage(message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: Text(message),
        ),
      ],
    );
  }
}
