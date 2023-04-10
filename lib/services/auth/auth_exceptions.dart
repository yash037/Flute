//login exceptions

class UserNotFoundAuthExceptions implements Exception {}

class WrongPasswordAuthExceptions implements Exception {}


//register exceptions

class WeakPasswordAuthExceptions implements Exception {}

class EmailALreadyInUseAuthExceptions implements Exception {}

class InvalidEmailAuthExceptions implements Exception {}


//generic exceptions

class GenericAuthExceptions implements Exception {}

class UserNotLoggedInAuthExceptions implements Exception{}