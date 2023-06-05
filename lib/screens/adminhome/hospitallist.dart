import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/hospitalprovider.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({super.key});

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  void initState() {
    super.initState();
    Provider.of<HospitalProvider>(context, listen: false).loadHospitals();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<dynamic> d = Provider.of<HospitalProvider>(context).hospitaldata;
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
                                    'assets/images/hospital.png',
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
                              FittedBox(
                                child: Text(
                                  d[index].name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Opens ${d[index].hours}/7',
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
                              Row(
                                children: [
                                  Text(
                                    d[index].rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 230, 227, 227),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Color.fromRGBO(246, 186, 7, 1),
                                  )
                                ],
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
