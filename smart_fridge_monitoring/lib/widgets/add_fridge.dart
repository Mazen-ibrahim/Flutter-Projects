import 'dart:math';

import 'package:flutter/material.dart';
import '../data/dtb.dart';

class AddFridge extends StatefulWidget {
  AddFridge({super.key});

  @override
  State<AddFridge> createState() => _AddFridgeState();
}

class _AddFridgeState extends State<AddFridge> {
  final TextEditingController fridgeid = TextEditingController();

  final TextEditingController initialstatus = TextEditingController();

  final TextEditingController mincabintemp = TextEditingController();

  final TextEditingController maxcabintemp = TextEditingController();

  final TextEditingController minfreezertemp = TextEditingController();

  final TextEditingController maxfreezertemp = TextEditingController();

  final TextEditingController mincabincurrent = TextEditingController();

  final TextEditingController maxcabincurrent = TextEditingController();

  final TextEditingController minfreezercurrent = TextEditingController();

  final TextEditingController maxfreezercurrent = TextEditingController();

  void _addfridge() {
    final String _fridgeid = fridgeid.text;
    final String _initialstatus = initialstatus.text;
    final double _mincabintemp = double.parse(mincabintemp.text);
    final double _maxcabintemp = double.parse(maxcabintemp.text);
    final double _minfreezertemp = double.parse(minfreezertemp.text);
    final double _maxfreezertemp = double.parse(maxfreezertemp.text);
    final double _mincabincurrent = double.parse(mincabincurrent.text);
    final double _maxcabincurrent = double.parse(maxcabincurrent.text);
    final double _minfreezercurrent = double.parse(minfreezercurrent.text);
    final double _maxfreezercurrent = double.parse(maxfreezercurrent.text);

    if (_fridgeid.isNotEmpty &&
        _initialstatus.isNotEmpty &&
        !_mincabintemp.isNaN &&
        !_maxcabintemp.isNaN &&
        !_minfreezertemp.isNaN &&
        !_maxfreezertemp.isNaN &&
        !_mincabincurrent.isNaN &&
        !_maxcabincurrent.isNaN &&
        !_minfreezercurrent.isNaN &&
        !_maxfreezercurrent.isNaN) {
      bool checkcabintemp = true;
      bool checkcabincurrent = true;
      bool checkfreezertemp = true;
      bool checkfreezercurrent = true;

      if (_mincabintemp > _maxcabintemp) {
        checkcabintemp = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Warning: Min Cabin Temp greater than Max Cabin Temp")));
      }

      if (_mincabincurrent > _maxcabincurrent ||
          _maxcabincurrent.isNegative ||
          _mincabincurrent.isNegative) {
        checkcabincurrent = false;
        if (_mincabincurrent > _maxcabincurrent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Warning: Min Cabin Current greater than Max Cabin Current")));
        } else if (_maxcabincurrent.isNegative || _mincabincurrent.isNegative) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Warning: Cabin Current can't be a Negative Value in Both Field")));
        }
      }

      if (_minfreezertemp > _maxfreezertemp) {
        checkfreezertemp = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Warning: Min Freezer Temp greater than Max Freezer Temp")));
      }

      if (_minfreezercurrent > _maxfreezercurrent ||
          _maxfreezercurrent.isNegative ||
          _minfreezercurrent.isNegative) {
        checkfreezercurrent = false;
        if (_minfreezercurrent > _maxfreezercurrent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Warning: Min Freezer Current greater than Max Freezer Current")));
        } else if (_maxfreezercurrent.isNegative ||
            _minfreezercurrent.isNegative) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Warning: Freezer Current can't be a Negative Value in Both Field")));
        }
      }

      if (checkcabintemp &&
          checkcabincurrent &&
          checkfreezertemp &&
          checkfreezercurrent) {
        DataBase.addFridge(
            id: _fridgeid,
            status: _initialstatus,
            cabinTemp: _mincabintemp,
            cabinCurrent: _mincabincurrent,
            freezerTemp: _minfreezertemp,
            freezerCurrent: _minfreezercurrent,
            mincabincurrent: _mincabincurrent,
            maxcabincurrent: _maxcabincurrent,
            mincabintemp: _mincabintemp,
            maxcabintemp: _maxcabintemp,
            minfreezercurrent: _minfreezercurrent,
            maxfreezercurrent: _maxfreezercurrent,
            minfreezertemp: _minfreezertemp,
            maxfreezertemp: _maxfreezertemp);

        fridgeid.text = "";
        initialstatus.text = "";
        mincabintemp.text = "";
        maxcabintemp.text = "";
        minfreezertemp.text = "";
        maxfreezertemp.text = "";
        mincabincurrent.text = "";
        maxcabincurrent.text = "";
        minfreezercurrent.text = "";
        maxfreezercurrent.text = "";

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Fridge Added Successfully")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Check Missing Fields & Not a Value Field")));
    }
  }

  void _cleardata() {
    fridgeid.text = "";
    initialstatus.text = "";
    mincabintemp.text = "";
    maxcabintemp.text = "";
    minfreezertemp.text = "";
    maxfreezertemp.text = "";
    mincabincurrent.text = "";
    maxcabincurrent.text = "";
    minfreezercurrent.text = "";
    maxfreezercurrent.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    fridgeid.dispose();
    initialstatus.dispose();
    mincabintemp.dispose();
    maxcabintemp.dispose();
    mincabincurrent.dispose();
    maxcabincurrent.dispose();
    minfreezertemp.dispose();
    maxfreezertemp.dispose();
    minfreezercurrent.dispose();
    maxfreezercurrent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/addfridge.jpg'),
              fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const SizedBox(
              height: 150,
            ),
            Text(
              "Fridge Data",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: fridgeid,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Fridge ID",
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 200,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: initialstatus,
                    maxLength: 8,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Initial Status( Active | Inactive )",
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cabin Data",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: mincabintemp,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Min Cabin Temperature",
                          border:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: maxcabintemp,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Max Cabin Temperature",
                          border:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: mincabincurrent,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Min Cabin Current",
                          border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: maxcabincurrent,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Max Cabin Current",
                          border:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Freezer Data",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        maxLength: 3,
                        controller: minfreezertemp,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Min Freezer Temperature",
                          border:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: maxfreezertemp,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Max Freezer Temperature",
                          border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: minfreezercurrent,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Min Freezer Current",
                          border:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: maxfreezercurrent,
                        maxLength: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Max Freezer Current",
                          border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _addfridge,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      "Add Fridge",
                      style: TextStyle(fontSize: 30, color: Colors.blue[300]),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _cleardata,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      "Clear",
                      style: TextStyle(fontSize: 30, color: Colors.blue[300]),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
