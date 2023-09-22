import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:talk_to_gpt/presentation/pages/home_page.dart';

import '../../core/global_methods.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();

  int currentPage = 1;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 10,
            child: PageView(
              onPageChanged: (val){
                print(val);
                currentPage = val + 1;
                setState(() {});
              },
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Vector.png', color: Theme.of(context).iconTheme.color,),
                      const SizedBox(height: 20,),
                      Text('Welcome to ChatGPT', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      Text('Ask anything, get your answer', style: Theme.of(context).textTheme.bodyMedium ,textAlign: TextAlign.center,),
                      // Image.asset('assets/icons/board1.png'),
                      const SizedBox(height: 20,),
                    Icon(Icons.light_mode_outlined, color: Theme.of(context).iconTheme.color,),
                      Text('Examples', style: Theme.of(context).textTheme.displaySmall ,textAlign: TextAlign.center,),
                      card('“Explain quantum computing in simple terms”'),
                      const SizedBox(height: 20,),
                      card('“Got any creative ideas for a 10 year old’s birthday?”'),
                      const SizedBox(height: 20,),
                      card('“How do I make an HTTP request in Javascript?”'),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Vector.png', color: Theme.of(context).iconTheme.color,),
                      const SizedBox(height: 20,),
                      Text('Welcome to ChatGPT', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      Text('Ask anything, get your answer', style: Theme.of(context).textTheme.bodyMedium ,textAlign: TextAlign.center,),
                      // Image.asset('assets/icons/board1.png'),
                      const SizedBox(height: 20,),
                      Icon(Icons.electric_bolt, color: Theme.of(context).iconTheme.color,),
                      Text('Capabilities', style: Theme.of(context).textTheme.displaySmall ,textAlign: TextAlign.center,),
                      card('Remembers what user said earlier in the conversation'),
                      const SizedBox(height: 20,),
                      card('Allows user to provide follow-up corrections'),
                      const SizedBox(height: 20,),
                      card('Trained to decline inappropriate requests'),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/Vector.png', color: Theme.of(context).iconTheme.color,),
                      const SizedBox(height: 20,),
                      Text('Welcome to ChatGPT', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      Text('Ask anything, get your answer', style: Theme.of(context).textTheme.bodyMedium ,textAlign: TextAlign.center,),
                      // Image.asset('assets/icons/board1.png'),
                      const SizedBox(height: 20,),
                    Icon(Icons.warning_amber_outlined, color: Theme.of(context).iconTheme.color,),
                      Text('Limitations', style: Theme.of(context).textTheme.displaySmall ,textAlign: TextAlign.center,),
                      card('May occasionally generate incorrect information'),
                      const SizedBox(height: 20,),
                      card('May occasionally produce harmful instructions or biased content'),
                      const SizedBox(height: 20,),
                      card('Limited knowledge of world and events after 2021'),

                    ],
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect:  WormEffect(
                    dotWidth: 50,
                    dotHeight: 5,
                    dotColor: Theme.of(context).dividerColor ,
                    activeDotColor:  const Color(0xFF10A37F)
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: ()async {
              if(currentPage == 3) {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('opened', true);

                if(!mounted) return;
                GlobalMethods.navigateReplace(context, HomePage());
              }
              else{
                controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 50),
              backgroundColor: const Color(0xFF10A37F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            child: Text(currentPage == 3 ?'Let’s Chat ': 'Next', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
          ),
          const SizedBox(height: 10,)

        ],
      ),
    );
  }

  Widget card(String txt){
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Text(txt, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
    );
  }
}
