import 'package:flutter/material.dart';

class Class01 extends StatelessWidget {
  const Class01({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Class-01 : Personal Profile',
      // This removes the debug banner
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  /*
Questions: 

*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesonal Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.deepPurple,
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // this get overridden!!
          children: [
            // Split the original Column into two the `action btn` and the rest and wrap the rest with `Expanded` so it pusth the btn to the btn.
            Expanded(
              child: Column(
                // spacing parameter that inserts equal gaps between every child automatically
                spacing: 25,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.deepPurple,
                        backgroundImage: AssetImage('assets/img-1.png'),
                      ),
                      Positioned(
                        right: 5,
                        top: 75,
                        child: Icon(
                          Icons.circle,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(right: 10, top: 80, child: Icon(Icons.edit)),
                    ],
                  ),

                  // This is profile picture with Cointainer.
                  // Container(
                  //   width: 100,
                  //   height: 100,
                  //   margin: EdgeInsets.only(bottom: 20),

                  //   alignment: AlignmentGeometry
                  //       .center, // this for alligning the children of the container.
                  //   decoration: BoxDecoration(
                  //     border: BoxBorder.all(
                  //       color: Colors.lightBlue,
                  //       style: BorderStyle.solid,
                  //     ),
                  //     // borderRadius: BorderRadius.circular(200),
                  //     shape: BoxShape
                  //         .circle, // use this or borderRadius: BorderRadius.circular(200),
                  //   ),
                  //   child: Text('pfp'),
                  // ),
                  Text('name + bio'),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.purple,
                          // the shape param is annoying to remmeber
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(children: [Text('Tasks'), Text('12')]),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.purple,
                          // the shape param is annoying to remmeber
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [Text('Pendding'), Text('0')],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.purple,
                          // the shape param is annoying to remmeber
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(children: [Text('Done'), Text('1')]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text('Action btn', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
