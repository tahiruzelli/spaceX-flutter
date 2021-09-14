// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/Bloc/fetch_bloc.dart';
import 'package:spacex/globals/widgets/textButton.dart';
import 'package:spacex/services/fetch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchBloc>(context).add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: BlocBuilder<FetchBloc, FetchState>(
          builder: (context, state) {
            if (state is FetchLoadedState) {
              var lastFlyDatas = state.fetchDatas;
              return Text(
                lastFlyDatas['name'],
                style: const TextStyle(
                  color: Colors.black,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<FetchBloc, FetchState>(
          builder: (context, state) {
            if (state is FetchLoadedState) {
              var lastFlyDatas = state.fetchDatas;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.network(
                            lastFlyDatas['links']['patch']['large'],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            'Uçuş Tarihi: ' +
                                DateTime.parse(lastFlyDatas['date_utc'])
                                    .toString()
                                    .split(' ')[0],
                            style: const TextStyle(
                              backgroundColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Iniş Tipi: ' +
                        lastFlyDatas['cores'][0]['landing_type'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Pencere: ' + lastFlyDatas['window'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Uçuş Numarası: ' +
                        lastFlyDatas['flight_number'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  lastFlyDatas['success']
                      ? const Text(
                          'Uçuş Başarılı',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          'Uçuş Başarısız',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 10),
                  CustomTextButton(
                    'Youtube',
                    'https://www.youtube.com/watch?v=' +
                        lastFlyDatas['links']['youtube_id'],
                  ),
                  const SizedBox(height: 15),
                  CustomTextButton(
                    'Wikipedia',
                    'https://www.youtube.com/watch?v=' +
                        lastFlyDatas['links']['wikipedia'],
                  ),
                  const SizedBox(height: 15),
                  CustomTextButton(
                    'Reddit Campaign',
                    'https://www.youtube.com/watch?v=' +
                        lastFlyDatas['links']['reddit']['campaign'],
                  ),
                ],
              );
            } else if (state is FetchLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
