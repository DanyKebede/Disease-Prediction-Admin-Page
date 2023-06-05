import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/hospitalprovider.dart';
// import '../../service/Hospital.dart';

class HospitalsPage extends StatefulWidget {
  const HospitalsPage({super.key});

  @override
  State<HospitalsPage> createState() => _HospitalsPageState();
}

class _HospitalsPageState extends State<HospitalsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HospitalProvider>(context, listen: false).loadHospitals();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> d = Provider.of<HospitalProvider>(context).searchResult;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(63, 82, 130, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(63, 82, 130, 1),
          elevation: 1,
          centerTitle: true,
          title: const Text(
            "Hospitals List",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/hospitaladd');
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) =>
                    Provider.of<HospitalProvider>(context, listen: false)
                        .search(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(46, 67, 120, 1),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Ex. Dream Care General",
                  hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: Color.fromRGBO(198, 185, 185, 1)),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: d.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(
                        top: 7,
                        left: 2,
                        right: 2,
                      ),
                      color: const Color.fromRGBO(46, 67, 120, 1),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color.fromRGBO(191, 181, 255, 1)),
                            shape: BoxShape.circle,
                          ),
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipOval(
                                child: d[index].imgurl != ''
                                    ? Image.network(
                                        d[index].imgurl,
                                        fit: BoxFit.cover,
                                        width: 90,
                                        height: 90,
                                      )
                                    : Image.asset(
                                        'assets/images/hospital.png',
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${d[index].name} Hospital',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              d[index].rating.toString(),
                              style: const TextStyle(
                                color: Color.fromRGBO(201, 197, 197, 1),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            )
                          ],
                        ),
                        trailing: PopupMenuButton(
                          child: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                          onSelected: (result) {
                            if (result == 'edit') {
                              Navigator.of(context).pushNamed(
                                '/hospitaladd',
                                arguments: {'HospitalId': d[index].id},
                              );
                            } else if (result == 'delete') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        const Color.fromRGBO(63, 82, 130, 1),
                                    content: const Text("are you sure?"),
                                    actions: [
                                      TextButton(
                                        child: const Text(
                                          'No',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          try {
                                            Provider.of<HospitalProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteHospitalByid(
                                                    d[index].id);
                                            Fluttertoast.showToast(
                                              msg:
                                                  'Hospital Deleted Successfully',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 49, 233, 12),
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print("Delete Failed!");
                                            }
                                          }

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Inter'),
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'Inter',
                              ),
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
