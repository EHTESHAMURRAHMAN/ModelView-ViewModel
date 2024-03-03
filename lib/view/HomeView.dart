import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/model/movies_Model.dart';
import 'package:mvvm/utils/routes/routesName.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/Home_View_Model.dart';
import 'package:mvvm/view_model/User_View_Model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    super.initState();
    homeViewViewModel.fetchMoviesListApi();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
                onTap: () {
                  userPreferences.remove().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: const Text('Logout'))
          ],
        ),
        body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
            builder: (context, value, _) {
              switch (value.moviesList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());

                case Status.ERROR:
                  return Center(
                      child: Text(value.moviesList.message.toString()));

                case Status.COMPLETED:
                  return ListView.builder(
                    itemCount: value.moviesList.data!.movies!.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        leading: Image.network(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          value.moviesList.data!.movies![index].posterurl
                              .toString(),
                          errorBuilder: (context, error, stackTrace) {
                            return (const Icon(Icons.error, color: Colors.red));
                          },
                        ),
                        title: Text(value.moviesList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value
                            .moviesList.data!.movies![index].year
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averagerating(value
                                    .moviesList.data!.movies![index].ratings!)
                                .toStringAsFixed(1)),
                            Icon(
                              Icons.star,
                              color: Colors.yellow.shade900,
                            )
                          ],
                        ),
                      ));
                    },
                  );
                default:
              }
              return Container();
            },
          ),
        ));
  }
}
