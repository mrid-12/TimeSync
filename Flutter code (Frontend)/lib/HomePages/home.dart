import 'dart:convert';
import 'package:flutter_margin_widget/flutter_margin_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  const homePage({super.key, required this.UserID});
  final UserID;

  @override
  State<StatefulWidget> createState() => _homePage();
}

class _homePage extends State<homePage> {
  dynamic currevent;
  dynamic allevents;
  dynamic searchedUser;
  List<String> userList = [];
  bool searchComplete = false;
  int count = 0;

  final TextEditingController delete = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController dateEnd = TextEditingController();
  final TextEditingController timeEnd = TextEditingController();

  final TextEditingController userSearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    getEvents();
    getAllEvents(widget.UserID);
  }

  int _selectedIndex = 0;
  late final PageController _pageController = PageController(initialPage: 0);

  Future<void> getEvents() async {
    String id = widget.UserID;
    String allEvents = 'http://10.105.112.198:8080/event/eget/$id';
    String url = 'http://10.0.2.2:8080/event/eget/$id';

    final response = await http.get(Uri.parse(url));

    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        currevent = jsonDecode(response.body);
      });
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "Something went wrong", fontSize: 18);
    }
  }

  Future<void> getAllEvents(id) async {
    String purl = 'http://10.0.0.38:8080/event/egetall/$id';
    String url = 'http://10.0.2.2:8080/event/egetall/$id';

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        allevents = jsonDecode(response.body);
      });
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Something went wrong with getting your events", fontSize: 18);
    }
  }

  Future<void> createEvent(id, title, startTime, endTime) async {
    String createEventsurl = 'http://10.0.0.38:8080/event/ecreate';
    String url = 'http://10.0.2.2:8080/event/ecreate';

    final res = await http.post(Uri.parse(url), body: {
      "userId": id,
      "eventTitle": title,
      "startTime": startTime,
      "endTime": endTime,
      "active": "true",
    });
    Fluttertoast.showToast(msg: res.body);
  }

  Future<void> deleteEvent(title) async {
    String id = widget.UserID;
    String deleteEventsurl = 'http://10.0.0.38:8080/event/edelete';
    String url = 'http://10.0.2.2:8080/event/edelete';

    final res =
        await http.delete(Uri.parse(url), body: {"id": id, "title": title});

    Fluttertoast.showToast(msg: res.body);
  }

  Future<void> userExists(name) async {
    String checkurl = 'http://10.0.0.38:8080/user/getId/$name';
    String url = 'http://10.0.2.2:8080/user/getId/$name';

    final response = await http.get(Uri.parse(url));

    print(response.statusCode);
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      setState(() {
        searchedUser = res[0]["_id"];
        searchComplete = true;
      });
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 59, 59, 59),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 1200,
                height: 1200,
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 20),
                    Card(
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 20,
                      shadowColor: Colors.lightBlue[100],
                      margin:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      clipBehavior: Clip.antiAlias,
                      child: currevent == null
                          ? const Column(children: [
                              SizedBox(height: 20),
                              Text('No events created!'),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                    'Click the + button below to add an event that can show up here'),
                              ),
                            ])
                          : Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.event),
                                  title: Text(currevent['1'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  subtitle: Text(
                                    'Ongoing/Upcoming event',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                const Center(
                                    child: Text("Start time:",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 15))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: Text(
                                    currevent['1st'],
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                                const Center(
                                    child: Text("End time:",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 15))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: Text(
                                    currevent['1et'],
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                    ),
                    Card(
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 20,
                      shadowColor: Colors.lightBlue[100],
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      clipBehavior: Clip.antiAlias,
                      child: allevents == null
                          ? const Column(children: [
                              SizedBox(height: 20),
                              Text('No events created!'),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                    'Click the + button below to add an event that can show up here'),
                              ),
                            ])
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10),
                                const Text("List of Events",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                OutlinedButton(
                                    onPressed: () async {
                                      await getEvents();
                                      await getAllEvents(widget.UserID);
                                    },
                                    child: Text('Refresh')),
                                for (var item in allevents)
                                  ListTile(
                                    title: Text(item['eventTitle'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                    subtitle: Text(
                                      "Starts on:" + item["startTime"],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  )
                              ],
                            ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Margin(
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: FloatingActionButton(
                            backgroundColor: Colors.red,
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.grey[350],
                                  context: context,
                                  builder: (context) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 50),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: TextField(
                                              controller: delete,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.title,
                                                      size: 30,
                                                      color: Colors.black),
                                                  prefixText: 'Event title: ',
                                                  hintText:
                                                      'Enter event you want to delete'),
                                            ),
                                          ),
                                          OutlinedButton(
                                            style: const ButtonStyle(
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.green),
                                            ),
                                            onPressed: () async {
                                              await deleteEvent(delete.text);
                                              await getAllEvents(widget.UserID);
                                              await getEvents();
                                            },
                                            child: const Icon(Icons.check,
                                                size: 30),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom)),
                                        ],
                                      ));
                            },
                            child: const Icon(Icons.restore_from_trash),
                          ),
                        ),
                        Margin(
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: FloatingActionButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.grey[350],
                                  context: context,
                                  builder: (context) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 50),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: TextField(
                                                controller: title,
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.title,
                                                        size: 30,
                                                        color: Colors.black),
                                                    prefixText: 'Event title: ',
                                                    hintText:
                                                        'Enter your title here'),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: TextField(
                                                controller: date,
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.date_range,
                                                        size: 30,
                                                        color: Colors.black),
                                                    prefixText: 'Start Date: ',
                                                    hintText:
                                                        'Hyphenated date yyyy-mm-dd'),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: TextField(
                                                controller: time,
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        size: 30,
                                                        color: Colors.black),
                                                    prefixText: 'Start Time: ',
                                                    hintText:
                                                        'Time of day Hour:Min:Sec'),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: TextField(
                                                controller: dateEnd,
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.date_range,
                                                        size: 30,
                                                        color: Colors.black),
                                                    prefixText: 'End Date: ',
                                                    hintText:
                                                        'Hyphenated date yyyy-mm-dd'),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 20),
                                              child: TextField(
                                                controller: timeEnd,
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        size: 30,
                                                        color: Colors.black),
                                                    prefixText: 'End Time: ',
                                                    hintText:
                                                        'Time of day Hour:Min:Sec'),
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                OutlinedButton(
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.red),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Icon(
                                                      Icons.cancel_outlined,
                                                      size: 30),
                                                ),
                                                const SizedBox(width: 40),
                                                OutlinedButton(
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.green),
                                                  ),
                                                  onPressed: () async {
                                                    await createEvent(
                                                      widget.UserID,
                                                      title.text,
                                                      "${date.text} ${time.text}",
                                                      "${dateEnd.text} ${timeEnd.text}",
                                                    );
                                                    await getAllEvents(
                                                        widget.UserID);
                                                    await getEvents();
                                                  },
                                                  child: const Icon(Icons.check,
                                                      size: 30),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom)),
                                              ],
                                            )
                                          ]));
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.all(30),
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      iconColor: Colors.black,
                    ),
                    controller: userSearch,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        child: const Icon(
                          Icons.send,
                        ),
                        onPressed: () async {
                          await userExists(userSearch.text);
                          print(searchComplete);
                          if (searchComplete) {
                            await getAllEvents(searchedUser);
                            count = 0;
                          }
                        },
                      ),
                      FloatingActionButton(
                        child: const Icon(
                          Icons.arrow_downward_sharp,
                        ),
                        onPressed: () async {
                          await userExists(userSearch.text);
                          if (searchComplete) {
                            setState(() {
                              userList.add(userSearch.text);
                            });
                          }
                        },
                      )
                    ]),
                Row(
                  children: [
                    Container(
                      height: 400,
                      width: 200,
                      child: Card(
                        child: searchedUser == null
                            ? const Column(children: [
                                SizedBox(height: 20),
                                Text('No User searched'),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                      'Press the send button above to search'),
                                ),
                              ])
                            : Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Searched User events',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  for (var item in allevents)
                                    if (count++ < 6)
                                      ListTile(
                                        dense: true,
                                        title: Text(item['eventTitle'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11)),
                                        subtitle: Text(
                                          "Starts on:" + item["startTime"],
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                      )
                                ],
                              ),
                      ),
                    ),
                    Container(
                      height: 400,
                      width: 200,
                      child: Card(
                        child: userList.isEmpty
                            ? const Column(children: [
                                SizedBox(height: 20),
                                Text('No User searched'),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                      'Press the arrow button above to add valid user'),
                                ),
                              ])
                            : Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Searched User events',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  for (var member in userList)
                                    ListTile(
                                        dense: true,
                                        title: Text(member,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11)),
                                        trailing: IconButton(
                                          icon: const Icon(
                                              Icons.restore_from_trash_rounded),
                                          onPressed: () {
                                            setState(() {
                                              userList.remove(member);
                                            });
                                          },
                                        ))
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          child: const Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.grey[350],
                                context: context,
                                builder: (context) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 50),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: TextField(
                                              controller: title,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.title,
                                                      size: 30,
                                                      color: Colors.black),
                                                  prefixText: 'Event title: ',
                                                  hintText:
                                                      'Enter your title here'),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: TextField(
                                              controller: date,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.date_range,
                                                      size: 30,
                                                      color: Colors.black),
                                                  prefixText: 'Start Date: ',
                                                  hintText:
                                                      'Hyphenated date yyyy-mm-dd'),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: TextField(
                                              controller: time,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 30,
                                                      color: Colors.black),
                                                  prefixText: 'Start Time: ',
                                                  hintText:
                                                      'Time of day Hour:Min:Sec'),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: TextField(
                                              controller: dateEnd,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons.date_range,
                                                      size: 30,
                                                      color: Colors.black),
                                                  prefixText: 'End Date: ',
                                                  hintText:
                                                      'Hyphenated date yyyy-mm-dd'),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: TextField(
                                              controller: timeEnd,
                                              decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 30,
                                                      color: Colors.black),
                                                  prefixText: 'End Time: ',
                                                  hintText:
                                                      'Time of day Hour:Min:Sec'),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              OutlinedButton(
                                                style: const ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.red),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Icon(
                                                    Icons.cancel_outlined,
                                                    size: 30),
                                              ),
                                              const SizedBox(width: 40),
                                              OutlinedButton(
                                                style: const ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.green),
                                                ),
                                                onPressed: () async {
                                                  for (String user
                                                      in userList) {
                                                    await userExists(user);
                                                    await createEvent(
                                                      searchedUser,
                                                      title.text,
                                                      "${date.text} ${time.text}",
                                                      "${dateEnd.text} ${timeEnd.text}",
                                                    );
                                                    await getAllEvents(
                                                        widget.UserID);
                                                    await getEvents();
                                                  }
                                                },
                                                child: const Icon(Icons.check,
                                                    size: 30),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom)),
                                            ],
                                          )
                                        ]));
                          })
                    ]),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
        bottomNavigationBar: GNav(
          backgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          tabMargin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
//rippleColor: Colors.grey[800]!, // tab button ripple color when pressed
//hoverColor: Colors.grey[700]!, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 20,
          tabActiveBorder:
              Border.all(color: Colors.red, width: 2), // tab button border
          tabBorder:
              Border.all(color: Colors.black, width: 2), // tab button border
          tabShadow: const [
            BoxShadow(color: Colors.white70, blurRadius: 6)
          ], // tab button shadow
          curve: Curves.fastOutSlowIn, // tab animation curves
          duration: const Duration(milliseconds: 400), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.black26, // unselected icon color
          activeColor: Colors.black, // selected icon and text color
          iconSize: 30, // tab button icon size
// tabBackgroundColor: Colors.yellow[900]!
//     .withOpacity(0.4), // selected tab background color
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
// navigation bar padding

          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.people,
              text: 'Teams',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            )
          ],
          onTabChange: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      )),
    );
  }
}
