import 'package:flutter_github_api/flutter_github_api.dart';
import 'package:flutter_test/flutter_test.dart';

class Example {
  void main() {
    test('list issues by repository', () {
      final github = createGitHubClient();
      var slug = RepositorySlug('houko', 'flutter_github_api');
      Stream<Issue> issueStream = github.issues.listByRepo(slug);
      issueStream.listen((data) {
        expect(data, data != null);
      });
    });
  }
}
