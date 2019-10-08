import 'package:github/server.dart';

class GithubIssueRequest extends IssueRequest {
  GithubIssueRequest(String title,
      {String body,
      List<String> labels,
      String assignee,
      String state,
      int milestone});
}
