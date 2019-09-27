import 'package:flutter_github_api/flutter_github_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });

    test('list issues by repository', () {
      final github = createGitHubClient();
      var slug = RepositorySlug('houko', 'flutter_github_api');
      Stream<Issue> issueStream = github.issues.listByRepo(slug);
      issueStream.listen((data) {
        expect(data, data != null);
      });
    });
}
