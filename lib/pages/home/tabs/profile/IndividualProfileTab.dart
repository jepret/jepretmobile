import 'package:flutter/material.dart';
import 'package:jepret/components/JepretTextField.dart';
import 'package:jepret/components/OutlinedPrimaryButton.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class IndividualProfileTab extends StatefulWidget {
  IndividualProfileTabState createState() => IndividualProfileTabState();
}

class IndividualProfileTabState extends State<IndividualProfileTab> {
  FocusNode _focus_name = new FocusNode();
  FocusNode _focus_mobile = new FocusNode();
  FocusNode _focus_nik = new FocusNode();

  TextEditingController _controller_name = new TextEditingController();
  TextEditingController _controller_mobile = new TextEditingController();
  TextEditingController _controller_nik = new TextEditingController();

  Widget build(BuildContext context) {
    return FormKeyboardActions(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        actions: [
          KeyboardAction(focusNode: _focus_name),
          KeyboardAction(focusNode: _focus_mobile),
          KeyboardAction(focusNode: _focus_nik),
        ],
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                      child: IntrinsicHeight(
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _renderTextFields(),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        _renderBottomButtons()
                                      ],
                                    ),
                                  )
                                ],
                          )
                      )
                  )
              );
            }
        )
    );
  }

  Widget _renderTextFields() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
      child: Column(
        children: <Widget>[
          JepretTextField(
            label: "Nama Lengkap",
            focusNode: _focus_name,
            controller: _controller_name,
            icon: Icon(Icons.person_outline),
            hasFloatingPlaceholder: true,
          ),
          Container(height: 16),
          JepretTextField(
            label: "Nomor Telepon Seluler",
            focusNode: _focus_mobile,
            controller: _controller_mobile,
            icon: Icon(Icons.phone),
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.phone,
          ),
          Container(height: 16),
          JepretTextField(
            label: "Nomor Induk Kependudukan (NIK)",
            focusNode: _focus_nik,
            controller: _controller_nik,
            icon: Icon(Icons.account_balance),
            hasFloatingPlaceholder: true,
            keyboardType: TextInputType.number,
          )
        ],
      )
    );
  }

  Widget _renderBottomButtons() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlinedPrimaryButton(
              text: "Simpan",
              onPressed: () {},
            )
          ],
        )
    );
  }
}