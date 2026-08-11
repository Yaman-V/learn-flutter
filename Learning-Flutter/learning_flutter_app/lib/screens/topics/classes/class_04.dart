import 'package:flutter/material.dart';

class Class04 extends StatefulWidget {
  const Class04({super.key});

  @override
  State<Class04> createState() => _Class04State();
}

class _Class04State extends State<Class04> with SingleTickerProviderStateMixin {
  // double xPosition = 0;
  // double yPosition = 0;
  // bool isTextSelected = false;
  // bool isIconSelected = false;
  // bool isRedSelected = false;

  late AnimationController animationController;
  late Animation<Offset>
  animation; // the <Type> depends on the animation we are using. e.g. if routation takes double
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation =
        Tween<Offset>(
          begin: const Offset(0, 1.0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOutBack,
          ),
        );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: const Text('Alass_04 : Animations')),
      body: Center(
        child: SlideTransition(
          position: animation,
          child: Container(
            width: 330,
            // usually we dont define the hieght if the container cover all the page
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.shade700,
                  blurRadius: 20,
                  offset: const Offset(2, 2),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min, // this is new
                //spacing: 30,
                children: [
                  Icon(Icons.lock, size: 80, color: Colors.blue),
                  SizedBox(height: 25),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_clock_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),

                  SizedBox(
                    // Contain the btn with SizeBox becuase we want to change the width and it does not have it.
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Lec_18 : Animations'),
    //     backgroundColor: Colors.pink,
    //   ),
    //   body: Stack(
    //     children: [
    //       Positioned(
    //         left: xPosition,
    //         top: yPosition,
    //         child: GestureDetector(
    //           onPanUpdate: (details) {
    //             setState(() {
    //               xPosition += details.delta.dx;
    //               yPosition += details.delta.dy;
    //             });
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.all(20),
    //             child: Container(
    //               color: Colors.lightBlue,
    //               width: 100,
    //               height: 100,
    //             ),
    //           ),
    //         ),
    //       ),

    //       Positioned(
    //         top: 180,
    //         left: 20,
    //         child: AnimatedDefaultTextStyle(
    //           duration: const Duration(seconds: 1),
    //           style: isTextSelected
    //               ? const TextStyle(color: Colors.green)
    //               : const TextStyle(color: Colors.purple),
    //           child: GestureDetector(
    //             onTap: () {
    //               setState(() {
    //                 isTextSelected = !isTextSelected;
    //               });
    //             },
    //             child: const Text(
    //               'Animated Text',
    //               style: TextStyle(fontSize: 20),
    //             ),
    //           ),
    //         ),
    //       ),

    //       Positioned(
    //         top: 220,
    //         left: 20,
    //         child: GestureDetector(
    //           onTap: () {
    //             setState(() {
    //               isIconSelected = !isIconSelected;
    //             });
    //           },
    //           child: AnimatedCrossFade(
    //             firstChild: Icon(Icons.home, size: 40),
    //             secondChild: Icon(Icons.star, size: 40),
    //             crossFadeState: isIconSelected
    //                 ? CrossFadeState.showFirst
    //                 : CrossFadeState.showSecond,

    //             duration: Duration(seconds: 1),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: 280,
    //         left: 20,
    //         child: GestureDetector(
    //           onTap: () {
    //             setState(() {
    //               isRedSelected = !isRedSelected;
    //             });
    //           },
    //           child: AnimatedAlign(
    //             alignment: isRedSelected
    //                 ? Alignment.topLeft
    //                 : Alignment.bottomLeft,
    //             duration: Duration(seconds: 2),
    //             child: Container(width: 100, height: 100, color: Colors.red),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
