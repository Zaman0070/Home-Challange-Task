class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://api.todoist.com/rest/v2';
  static const String taskEndPoint = '/tasks';
  static const String commentEndPoint = '/comments';
  // static const String apiToken = 'e1617dc52672d3c64b66d9befc639b80345d973d';
  static const String apiToken = '27eb24f37991eb18059cbc7aef6410b66a219d77';

  static const Duration connectionTimeOut = Duration(milliseconds: 50000);
  static const Duration receiveTimeOut = Duration(milliseconds: 80000);
}
