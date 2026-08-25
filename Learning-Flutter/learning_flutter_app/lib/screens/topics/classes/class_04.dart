import 'package:flutter/material.dart';
import 'package:learning_flutter_app/providers/theme_provider.dart';

import 'package:provider/provider.dart';

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

  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  Widget buildUserNameField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'User Name',
      ),
      maxLength: 30,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter user name';
        }
        if (value.length < 5) {
          return 'User name so short (should be 5 char or more)';
        }
        return null;
      },
      onSaved: (newValue) => setState(() {
        userName = newValue!;
      }),
    );
  }

  Widget buildUserEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
      ),
      validator: (value) {
        final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);
        if (value!.isEmpty) {
          return 'Enter an email';
        } else if (!regExp.hasMatch(value)) {
          return 'Enter a valid email';
        } else {
          return null;
        }
      },
      onSaved: (newValue) => setState(() {
        userEmail = newValue!;
      }),
    );
  }

  Widget buildUserPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      maxLength: 20,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter a password';
        // Minimum 8 chars, at least one uppercase, one lowercase, one number and one special char
        final pattern =
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$';
        final regExp = RegExp(pattern);
        if (!regExp.hasMatch(value)) {
          return 'Password must be 8+ chars, include upper, lower, number & special char';
        }
        return null;
      },
      onSaved: (newValue) => setState(() {
        userPassword = newValue!;
      }),
    );
  }

  Widget buildSubmitButton() => SizedBox(
    // Contain the btn with SizeBox becuase we want to change the width and it does not have it.
    width: double.infinity,

    child: ElevatedButton(
      child: Text('Sign in'),
      onPressed: () {
        final isSignInValid = _formKey.currentState!.validate();
        if (isSignInValid) {
          _formKey.currentState!.save();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('All Doe'), duration: Duration(seconds: 1)),
          );
        }
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms & Animations'),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (_) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: themeProvider.isDarkMode ? Colors.black87 : Colors.grey[200],
        child: Center(
          child: Form(
            key: _formKey,
            child: SlideTransition(
              position: animation,
              child: Container(
                width: 330,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade900
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: themeProvider.isDarkMode
                        ? Colors.white24
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (themeProvider.isDarkMode
                                  ? Colors.black
                                  : Colors.grey)
                              .withValues(alpha: 0.2),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, size: 80, color: Colors.blue),
                      const SizedBox(height: 25),

                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),

                      buildUserNameField(),
                      const SizedBox(height: 15),

                      buildUserEmailField(),
                      const SizedBox(height: 15),

                      buildUserPasswordField(),
                      const SizedBox(height: 35),

                      buildSubmitButton(),
                    ],
                  ),
                ),
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
