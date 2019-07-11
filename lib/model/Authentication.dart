class Authentication {
  int id;
  String authToken;
  String email;
  String nik;
  String name;
  String phoneNumber;
  bool hasBusinessProfile;

  Authentication({
    this.id,
    this.authToken,
    this.email,
    this.nik,
    this.name,
    this.phoneNumber,
    this.hasBusinessProfile
  });
}