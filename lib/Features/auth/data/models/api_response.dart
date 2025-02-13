class ApiResponse {
  bool success;
  String errMessage;
  Object? data;
  ApiResponse({
  this.success = false,
  this.errMessage = "Somthing went wrong, please try again later",
  this.data,
});
  factory ApiResponse.fromJson(dynamic json){
    return ApiResponse(
      success: json["success"],
      errMessage: json["errMessage"],
      data: json["data"]
    );
  }
}
