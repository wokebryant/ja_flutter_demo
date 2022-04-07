
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Flutter中，screen和page都叫做路由(Route)
/// 路由也是widget，通过Navigator来控制路由通信

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Route Widget",
      // home: FirstRoute()
      // home: TodoScreen(),
      // home: const HomeScreen(),
      // 定义路由命名
      initialRoute: "/",
      routes: {
        "/": (context) => const FirstScreen(),
        "/second": (context) => const SecondScreen()
      },
    );
  }
}

/// Route间跳转
class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Route"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // push会添加一个Route对象到导航器到堆栈上
              // 通过MaterialPageRoute可以构建一个Route对象
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute())
              );
            },
            child: const Text("Open Route")
        ),
      ),
    );
  }
}


class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // pop()方法移除导航器上的Route对象
            Navigator.pop(context);
          },
          child: const Text("Go Back"),
        ),
      ),
    );

  }
}


/// Route间传递数据
/// 两种传递方式
/// 1. 通过构造器传值
/// 2. 使用RouteSetting传递参数
class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoListView = ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(todos[index].title),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(/*todo: todos[index]*/),
                settings: RouteSettings(
                  arguments: todos[index]
                )
              )
          );
        },
      ),
      itemCount: todos.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: todoListView,
    );
  }
}

class DetailScreen extends StatelessWidget {
  // final Todo todo;

  const DetailScreen({
    Key? key,
    // required this.todo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // 2. 读取RouteSettings参数
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.desc),
      ),
    );
  }

}


class Todo {
  final String title;
  final String desc;

  const Todo(this.title, this.desc);
}

final todos = List.generate(
    20,
        (index) => Todo(
        "Todo $index",
        "A description of what needs to be done for Todo $index"
    )
);


/// Route间回传数据
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Returning Data Demo"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => _navigateAndDisplaySelection(context),
            child: const Text("Pick an option, any option!")
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelectionScreen())
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }


}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick an option"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Yep!");
                },
                child: const Text("Yep!"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Nope!");
                },
                child: const Text("Nope."),
              ),
            )
          ],
        ),
      ),
    );
  }
}


/// 命名路由
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // push会添加一个Route对象到导航器到堆栈上
              // 通过MaterialPageRoute可以构建一个Route对象
              Navigator.pushNamed(
                context,
                "/second",
                arguments: ScreenArguments(
                    title: "Extract Arguments Screen",
                    message: "This message is extracted in the build method."
                )
              );
            },
            child: const Text("Launch Screen")
        ),
      ),
    );
  }
}


class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // pop()方法移除导航器上的Route对象
            Navigator.pop(context);
          },
          child: Text(args.message),
        ),
      ),
    );

  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments({
    required this.title,
    required this.message
  });
}




