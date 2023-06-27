import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'John', age: 20, emoji: '🙋🏻‍♂️'),
  Person(name: 'Jane', age: 21, emoji: '👸🏽'),
  Person(name: 'Jack', age: 22, emoji: '🧔🏿‍♂️'),
];

class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home page",
        ),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(person: person),
                ),
              );
            },
            title: Text(
              person.name,
            ),
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            subtitle: Text("${person.age} years old"),
          );
        },
      ),
    );
  }
}

///
/// Detail page.
///
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(begin: 0, end: 1.0).chain(
                          CurveTween(
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      child: fromHeroContext.widget),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: toHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
