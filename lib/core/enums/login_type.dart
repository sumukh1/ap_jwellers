enum LoginType { ADMIN, EMPLOYEE, CUSTOMER }

extension LoginTypeX on LoginType {
  bool get isAdmin => this == LoginType.ADMIN;
  bool get isEmployee => this == LoginType.EMPLOYEE;
  bool get isCustomer => this == LoginType.CUSTOMER;
}

extension LoginTypeString on String {
  LoginType toLoginType() {
    switch (this) {
      case 'ADMIN':
        return LoginType.ADMIN;
      case 'EMPLOYEE':
        return LoginType.EMPLOYEE;
      case 'CUSTOMER':
        return LoginType.CUSTOMER;
      default:
        throw Exception('Invalid Login Type: $this');
    }
  }
}
