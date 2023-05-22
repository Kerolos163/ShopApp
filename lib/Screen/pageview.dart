import 'package:flutter/material.dart';
import 'package:shop_app/Screen/LogIn/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Helper/Share_Pref.dart';
import '../imp_func.dart';

class pview_item {
  String image;
  String title;
  String body;
  pview_item({required this.image, required this.title, required this.body});
}

class pageview extends StatelessWidget {
  var p_controller = PageController();
  bool islast = false;
  List<pview_item> Items = [
    pview_item(
        image: 'lib/img/img1.jpg',
        title: "On board 1 Title",
        body: "On board 1 Body"),
    pview_item(
        image: 'lib/img/img2.jpg',
        title: "On board 2 Title",
        body: "On board 2 Body"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
          TextButton(
              onPressed: () {
                Sharepref.savedata(key: 'pageview', value: true);
                go_toAnd_finish(context, LoginScreen());
              },
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 20),
              )),
          const SizedBox(
            width: 10,
          )
        ]),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: p_controller,
                    onPageChanged: (value) {
                      if (value == Items.length - 1) {
                        islast = true;
                      } else {
                        islast = false;
                      }
                    },
                    itemBuilder: (context, index) => bageviewItem(Items[index]),
                    itemCount: Items.length,
                  ),
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: p_controller, // PageController
                        count: Items.length,
                        effect: SwapEffect(
                            activeDotColor: Theme.of(context)
                                .primaryColor), // your preferred effect
                        onDotClicked: (index) {}),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (islast) {
                          Sharepref.savedata(key: 'pageview', value: true);
                          go_toAnd_finish(context, LoginScreen());
                        } else {
                          p_controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget bageviewItem(pview_item item) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(item.image))),
          Text(
            item.title,
            style: const TextStyle(fontSize: 35),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            item.body,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      );
}
