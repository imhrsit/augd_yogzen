import 'package:flutter/material.dart';
import 'package:yogzen_v_1/global/color.dart';
import 'package:yogzen_v_1/screens/auth/login_screen.dart';
import 'package:yogzen_v_1/screens/auth/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/auth';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  late TabController _tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();

    //tabbar
    _tabController = TabController(length: 2, vsync: this);
    void setActiveTabIndex() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    }

    _tabController.addListener(setActiveTabIndex);

    //image animation
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = Tween<double>(
      begin: -30,
      end: 30,
    ).animate(controller!)
      ..addListener(() {
        setState(() {});
        if (controller!.isCompleted) {
          controller!.reverse();
        }
        if (controller!.isDismissed) {
          controller!.forward();
        }
      });

    controller!.forward();
    // The looping is done via listener.
  }

  @override
  void dispose() {
    controller!.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: klightBlue,
      ),
      backgroundColor: klightBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1500),
              transform: Transform.translate(
                offset: Offset(0, animation!.value),
              ).transform,
              child: Hero(
                tag: "welcome",
                child: Image.asset(
                  'assets/welcome.png',
                  scale: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      surfaceVariant: Colors.transparent,
                    ),
              ),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: activeTabIndex == 0 ? kdarkBlue : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: activeTabIndex == 0
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: activeTabIndex == 1 ? kdarkBlue : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: activeTabIndex == 1
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: kdarkBlue,
                ),
                controller: _tabController,
                isScrollable: true,

                // labelPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Signup(
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController),
                Login(
                    emailController: emailController,
                    passwordController: passwordController),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       width: double.infinity,
          //       height: 50,
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.black),
          //         borderRadius: BorderRadius.circular(16),
          //         color: Colors.white,
          //       ),
          //       child: const Center(
          //         child: Text(
          //           "Log In with Google",
          //           style: TextStyle(),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 40,
          // ),
        ],
      ),
    );
  }
}
