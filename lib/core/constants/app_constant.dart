Map<String, dynamic> header({required String authToken}) {
  return {
    'Authorization': authToken,
  };
}