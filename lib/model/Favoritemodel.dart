class Favoritemodel
{
  late bool status;
  late String message;
  Favoritemodel.fromJson(Map<String ,dynamic> Json)
  {
    status=Json["status"];
    message=Json["message"];
  }
}