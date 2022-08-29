import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneotest/state/state_manager.dart';
import 'Model/authorObject.dart';

void main() {
  //longOperationMethod();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}


// Method name should be in lowerCamelCas always.
String longOperationMethod(){
  var counting = 0;
  for( var i = 1; i<=1000000000; i++){
    counting = i;
  }
  return '$counting! times I print the value';
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tata Neo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  List<int> index = [0];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Data>> coins = ref.watch(authorStateFuture);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Tata Neo Test')),
      ),
      body: coins.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('$err+Error')),
        data: (coins) {
          return ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      index == 0 ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.pie_chart,
                              color: Colors.amberAccent,
                            ),
                            Text(
                              'Show Authors',
                              style: TextStyle(
                                  color: Colors.amberAccent, fontSize: 20),
                            ),
                            Spacer(),
                            Text(
                              'Count '+coins.length.toString(),
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 20),
                            ),
                          ],
                        ),
                      ) : SizedBox.shrink(),

                      Container(
                        height: 90,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  coins[index].author.toString(),
                                  style: TextStyle(
                                      color: Colors.amberAccent, fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),

    );
  }
}
