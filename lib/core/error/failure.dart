class Failure  implements Exception {
  final  String mess;

  const Failure(this.mess);
   @override
  String toString() => mess;
}