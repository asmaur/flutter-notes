import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/register_view.dart';
import 'package:notes/views/verify_email_view.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
             final user = FirebaseAuth.instance.currentUser;
             if(user != null){
               if(user.emailVerified){
                 return const NotesView();
               }else{
                 return const VerifyEmailView();
               }
             }else{
               return const LoginView();
             }

            default:
              return const CircularProgressIndicator();
          }
        });
  }
}

enum MenuAction {logout}

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async{
              switch (value){

                case MenuAction.logout:
                  final shoudLogOut = await showLogOutDialog(context);
                  devtools.log(shoudLogOut.toString());
                  if(shoudLogOut){
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false
                    );
                  }
                  break;
              }

            },
              itemBuilder: (constext){
                return const [
                    PopupMenuItem(
                      value: MenuAction.logout,
                      child: Text("Log out"),
                  )
                ];
              }
          )
        ],
      ),
      body: const Text("Hello world !"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Sign out"),
        content: const Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")
            ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text("Log out")
            )
          ],
        );
      }
  ).then((value) => value ?? false);
}


