import 'package:dram1y/src/widgets/buttons/custom_wide_flat_button.dart';
import 'package:flutter/material.dart';

class CustomNameOnboardingPopups extends StatefulWidget {
  @override
  _CustomNameOnboardingPopupsState createState() => _CustomNameOnboardingPopupsState();
}

class _CustomNameOnboardingPopupsState extends State<CustomNameOnboardingPopups> {
  final _controller = TextEditingController();
  Icon _errorIcon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
            child: Column(
              children: <Widget>[
                Text(
                  'Enter your name',
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
                smallSpace,
                Text(
                  'change the amount field with your name',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle.copyWith(),
                ),
                largeSpace,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) => setValue(value),
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: _errorIcon,
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          largeSpace,
          CustomWideFlatButton(
            onPressed: () => setValue(_controller.text),
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.blue.shade900,
          ),
        ],
      ),
    );
  }

  Widget get largeSpace => SizedBox(height: 24);
  Widget get smallSpace => SizedBox(height: 12);

  void setValue(String amountAsString) {
    Icon error = Icon(Icons.error, color: Colors.red);
    if (amountAsString.isEmpty) {
      setState(() {
        _errorIcon = error;
      });
      return;
    }
    String amount = amountAsString;

    Navigator.of(context).pop(amount);
  }
}