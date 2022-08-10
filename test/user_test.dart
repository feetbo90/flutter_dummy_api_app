

import 'package:flutter_logique/data/api/api_services.dart';
import 'package:flutter_logique/data/model/response/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'user_test.mocks.dart';
@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  var apiService = ApiService(client);
  test('returns an posts if the http call completes successfully',
          () async {

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(client.get(Uri.parse('https://dummyapi.io/data/v1/post')))
            .thenAnswer((_) async => http.Response(
            "{\"data\": [{\"id\": \"60d21bf367d0d8992e610e88\",\"image\": \"https://img.dummyapi.io/photo-1564849444446-f876dcef378e.jpg\",\"likes\": 40,\"tags\": [\"plant\",\"mammal\",\"pet\"],\"text\": \"A feral cat short-fur gray and orange cat on green...\",\"publishDate\": \"2020-05-20T18:51:23.478Z\",\"owner\": {\"id\": \"60d0fe4f5311236168a109f4\",\"title\": \"mr\",\"firstName\": \"Benjamin\",\"lastName\": \"Holland\",\"picture\": \"https://randomuser.me/api/portraits/med/men/58.jpg\"}}],\"total\": 873,\"page\": 0,\"limit\": 20}",
            200));

        expect(await apiService.getPosts(0, 20), isA<Posts>());
      });
}