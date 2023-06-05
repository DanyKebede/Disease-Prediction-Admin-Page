import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/doctorprovider.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).loadDoctors();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<dynamic> d = Provider.of<DoctorProvider>(context).doctorData;
    return SizedBox(
      width: size.width,
      height: size.height * 0.37,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: d.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Card(
                  color: const Color.fromRGBO(130, 156, 219, 0.4),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 145,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: d[index].imgurl != ''
                                ? Image.network(
                                    d[index].imgurl,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/doctor.png',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${d[index].title.toUpperCase()}. ${d[index].name}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                d[index].speciality,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              FittedBox(
                                child: Text(
                                  d[index].hospital.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 230, 227, 227),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
