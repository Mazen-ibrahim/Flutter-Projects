
import 'package:flutter/material.dart';
import '../data/dtb.dart';

class AddFridge extends StatefulWidget {
  const AddFridge({super.key});

  @override
  State<AddFridge> createState() => _AddFridgeState();
}

class _AddFridgeState extends State<AddFridge> {
  final TextEditingController _fridgeid = TextEditingController();

  final TextEditingController _initialstatus = TextEditingController();

  final TextEditingController _mincabintemp = TextEditingController();

  final TextEditingController _maxcabintemp = TextEditingController();

  final TextEditingController _minfreezertemp = TextEditingController();

  final TextEditingController _maxfreezertemp = TextEditingController();

  final TextEditingController _mincabincurrent = TextEditingController();

  final TextEditingController _maxcabincurrent = TextEditingController();

  final TextEditingController _minfreezercurrent = TextEditingController();

  final TextEditingController _maxfreezercurrent = TextEditingController();

  void _addfridge() {
    final String fridgeid = _fridgeid.text;
    final String initialstatus = _initialstatus.text;
    final double mincabintemp = double.parse(_mincabintemp.text);
    final double maxcabintemp = double.parse(_maxcabintemp.text);
    final double minfreezertemp = double.parse(_minfreezertemp.text);
    final double maxfreezertemp = double.parse(_maxfreezertemp.text);
    final double mincabincurrent = double.parse(_mincabincurrent.text);
    final double maxcabincurrent = double.parse(_maxcabincurrent.text);
    final double minfreezercurrent = double.parse(_minfreezercurrent.text);
    final double maxfreezercurrent = double.parse(_maxfreezercurrent.text);

    if (fridgeid.isNotEmpty &&
        initialstatus.isNotEmpty &&
        !mincabintemp.isNaN &&
        !maxcabintemp.isNaN &&
        !minfreezertemp.isNaN &&
        !maxfreezertemp.isNaN &&
        !mincabincurrent.isNaN &&
        !maxcabincurrent.isNaN &&
        !minfreezercurrent.isNaN &&
        !maxfreezercurrent.isNaN) {
      bool checkcabintemp = true;
      bool checkcabincurrent = true;
      bool checkfreezertemp = true;
      bool checkfreezercurrent = true;

      if (mincabintemp > maxcabintemp) {
        checkcabintemp = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Warning: Min Cabin Temp greater than Max Cabin Temp")));
      }

      if (mincabincurrent > maxcabincurrent ||
          maxcabincurrent.isNegative ||
          mincabincurrent.isNegative) {
        checkcabincurrent = false;
        if (mincabincurrent > maxcabincurrent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text("Warning: Min Cabin Current greater than Max Cabin Current")));
        } else if (maxcabincurrent.isNegative || mincabincurrent.isNegative) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Warning: Cabin Current can't be a Negative Value in Both Field")));
        }
      }

      if (minfreezertemp > maxfreezertemp) {
        checkfreezertemp = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Warning: Min Freezer Temp greater than Max Freezer Temp")));
      }

      if (minfreezercurrent > maxfreezercurrent ||
          maxfreezercurrent.isNegative ||
          minfreezercurrent.isNegative) {
        checkfreezercurrent = false;
        if (minfreezercurrent > maxfreezercurrent) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "Warning: Min Freezer Current greater than Max Freezer Current")));
        } else if (maxfreezercurrent.isNegative ||
            minfreezercurrent.isNegative) {
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
            id: fridgeid,
            status: initialstatus,
            cabinTemp: mincabintemp,
            cabinCurrent: mincabincurrent,
            freezerTemp: minfreezertemp,
            freezerCurrent: minfreezercurrent,
            mincabincurrent: mincabincurrent,
            maxcabincurrent: maxcabincurrent,
            mincabintemp: mincabintemp,
            maxcabintemp: maxcabintemp,
            minfreezercurrent: minfreezercurrent,
            maxfreezercurrent: maxfreezercurrent,
            minfreezertemp: minfreezertemp,
            maxfreezertemp: maxfreezertemp);

        _fridgeid.text = "";
        _initialstatus.text = "";
        _mincabintemp.text = "";
        _maxcabintemp.text = "";
        _minfreezertemp.text = "";
        _maxfreezertemp.text = "";
        _mincabincurrent.text = "";
        _maxcabincurrent.text = "";
        _minfreezercurrent.text = "";
        _maxfreezercurrent.text = "";

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Fridge Added Successfully")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Check Missing Fields & Not a Value Field")));
    }
  }

  void _cleardata() {
    _fridgeid.text = "";
    _initialstatus.text = "";
    _mincabintemp.text = "";
    _maxcabintemp.text = "";
    _minfreezertemp.text = "";
    _maxfreezertemp.text = "";
    _mincabincurrent.text = "";
    _maxcabincurrent.text = "";
    _minfreezercurrent.text = "";
   _maxfreezercurrent.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    _fridgeid.dispose();
    _initialstatus.dispose();
    _mincabintemp.dispose();
    _maxcabintemp.dispose();
    _mincabincurrent.dispose();
    _maxcabincurrent.dispose();
    _minfreezertemp.dispose();
    _maxfreezertemp.dispose();
    _minfreezercurrent.dispose();
    _maxfreezercurrent.dispose();
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
                    controller: _fridgeid,
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
                    controller: _initialstatus,
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
                        controller: _mincabintemp,
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
                        controller: _maxcabintemp,
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
                        controller: _mincabincurrent,
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
                        controller: _maxcabincurrent,
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
                        controller: _minfreezertemp,
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
                        controller: _maxfreezertemp,
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
                        controller: _minfreezercurrent,
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
                        controller: _maxfreezercurrent,
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
