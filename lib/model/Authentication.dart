class Authentication {
  int id;
  int balance;
  String authToken;
  String email;
  String nik;
  String name;
  String phoneNumber;
  bool hasBusinessProfile;

  Authentication({
    this.id,
    this.balance,
    this.authToken,
    this.email,
    this.nik,
    this.name,
    this.phoneNumber,
    this.hasBusinessProfile
  });
}