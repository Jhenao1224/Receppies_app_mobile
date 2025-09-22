import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipes_app/components/primary_button.dart';
import 'package:receipes_app/core/dependecy_injection.dart';
import 'package:receipes_app/firebase_options.dart';
import 'package:receipes_app/presentation/screens/splash_screen.dart';
import 'package:receipes_app/themes/app_themes.dart';
import 'package:receipes_app/providers/theme_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(MultiProvider(providers: DependecyInjection.providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Recipes App',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: 
            themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Row(children: [
                Icon(Icons.light_mode, color: !themeProvider.isDark ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),),
                Switch(
                  value: themeProvider.isDark, 
                  onChanged: (value) =>{themeProvider.toggleTheme()},
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
                Icon(Icons.dark_mode, color: themeProvider.isDark ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),),
              ],);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
          
              Card(
                elevation: 2,
                child: Consumer <ThemeProvider>(
                  builder: (context, themeProvider, child){
                    return ListTile(
                      leading: Icon(
                        themeProvider.isDark 
                        ?Icons.dark_mode 
                        :Icons.light_mode,),
                      title: Text(
                        'Current Theme: ${themeProvider.isDark ? "Dark" : "Light"}'),
                      trailing: Switch(
                        value: themeProvider.isDark, 
                        onChanged: (value) =>{themeProvider.toggleTheme()},
                        activeColor: Theme.of(context).colorScheme.primary,),
                      ); 
                    }
                  ),
                ),
          
                ElevatedButton(onPressed: () {}, child: Text('Primary button')),
                PrimaryButton(onPressed: () {}, title: 'Primary button',),
                // CustomTextField(label: 'Email'),
                // SizedBox(height: 8,),
                // CustomTextField(label: 'Password', isPassword: true),
                // SizedBox(height: 8,),
                // CustomTextField(label: 'Number', keyboardType: TextInputType.number),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
