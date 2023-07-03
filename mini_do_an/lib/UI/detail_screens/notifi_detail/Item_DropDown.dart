import 'package:flutter/material.dart';

class ItemDropDown extends StatefulWidget {
  ItemDropDown({
    super.key,
    required this.listOptions,
    required this.getValue,
    required this.valueDefault,
  });
  List<String> listOptions;
  Function getValue;
  String? valueDefault;
  @override
  State<ItemDropDown> createState() => _ItemDropDownState();
}

class _ItemDropDownState extends State<ItemDropDown> {
  late String selectedOption;
  // late String myOption;
  @override
  void initState() {
    super.initState();
    selectedOption = widget.valueDefault!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      color: Colors.white.withOpacity(.4),
      child: DropdownButton<String>(
        value: selectedOption,
        items: widget.listOptions.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Container(
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(.2),
                // color: Colors.grey[300],
              ),
              child: Center(
                  child: Text(
                option,
                style: const TextStyle(fontSize: 16),
              )),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
            widget.getValue(selectedOption);
          });
        },
      ),
    );
  }
}
