import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/authorObject.dart';

import '../Network/network_request.dart';

final authorStateFuture = FutureProvider<List<Data>>((ref) async {
  return fetchAuthors();
});