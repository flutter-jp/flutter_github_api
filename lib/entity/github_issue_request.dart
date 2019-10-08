import 'package:flutter_github_api/flutter_github_api.dart';

class GithubIssueRequest extends IssueRequest {
  GithubIssueRequest(String title,
      {String body,
      List<String> labels,
      String assignee,
      String state,
      int milestone});
}
