import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_thai_moneyshare_project/views/money_result_ui.dart';

class MoneyInputUI extends StatefulWidget {
  const MoneyInputUI({super.key});

  @override
  State<MoneyInputUI> createState() => _MoneyInputUIState();
}

class _MoneyInputUIState extends State<MoneyInputUI> {
  //ตัวแปรใช้กับ Checkbox
  bool isTip = false;

  //ตัวควบคุม TextField
  TextEditingController moneyCtrl = TextEditingController();
  TextEditingController personCtrl = TextEditingController();
  TextEditingController tipCtrl = TextEditingController();

  //เมธอดแสดงข้อความเตือน
  showWarningMSG(context, msg) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'คำเตือน',
          ),
          content: Text(
            msg,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ตกลง',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 197, 249),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'แชร์เงินกันเถอะ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 45.0,
            right: 45.0,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Image.asset(
                  'assets/images/money.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                SizedBox(
                  height: 35.0,
                ),
                TextField(
                  controller: moneyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.moneyBill1Wave,
                      color: Colors.purple,
                    ),
                    hintText: 'ป้อนจำนวนเงิน (บาท)',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                TextField(
                  controller: personCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.purple,
                    ),
                    hintText: 'ป้อนจำนวนคน (คน)',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      onChanged: (paramValue) {
                        //จำไว้นะ โค้ดใดที่มีผลต่อการแสดงผล
                        //ต้องเขียนอยู่ภายใต้ setState()
                        setState(() {
                          isTip = paramValue!;
                          if (isTip == false) {
                            tipCtrl.text = '';
                          }
                        });
                      },
                      value: isTip,
                      activeColor: Colors.purple,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      'ทิปให้พนักงานเสริฟ',
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.0,
                ),
                TextField(
                  controller: tipCtrl,
                  enabled: isTip,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.coins,
                      color: Colors.purple,
                    ),
                    hintText: 'ป้อนจำนวนเงินทิป (บาท)',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    //Validate UI
                    if (moneyCtrl.text.length == 0) {
                      //แจ้งเตือน ป้อนเงินด้วย
                      showWarningMSG(context, 'ป้อนเงินด้วย !!!!');
                    } else if (personCtrl.text.length == 0) {
                      //แจ้งเตือน ป้อนคนด้วย
                      showWarningMSG(context, 'ป้อนคนด้วย !!!!');
                    } else if (isTip == true && tipCtrl.text.length == 0) {
                      //แจ้งเตือน ป้อนทิป
                      showWarningMSG(context, 'ป้อนทิปด้วย !!!!');
                    } else {
                      //คำนวณแล้วส่งไปแสดงผลที่หน้า MoneyResultUI()
                      double money = double.parse(moneyCtrl.text);
                      int person = int.parse(personCtrl.text);
                      double tip =
                          isTip == true ? double.parse(tipCtrl.text) : 0;
                      double moneyShare = (money + tip) / person;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoneyResultUI(
                            money: money,
                            person: person,
                            tip: tip,
                            moneyShare: moneyShare,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'คำนวณ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  'Create by NinniN SAU',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
