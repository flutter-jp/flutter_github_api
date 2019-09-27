import 'package:flutter_github_api/flutter_github_api.dart';

class Example {
  static final github = createGitHubClient();
  static final slug = RepositorySlug('houko', 'flutter_github_api');

  static Stream<Issue> listIssuesByRepository() {
    Stream<Issue> issueStream = github.issues.listByRepo(slug);
    issueStream.listen((data) {
      print(data);
      // do something
    });
    return issueStream;
  }

  static Stream<Repository> listRepository() {
    Stream<Repository> repositoryStream =
        github.repositories.listRepositories(type: 'houko');

    repositoryStream.listen((data) {
      print(data);
      // do something
    });

    return repositoryStream;
  }
}
