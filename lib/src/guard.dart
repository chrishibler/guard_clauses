/// Entry point to guard clauses.
class Guard {
  static final Guard _instance = Guard._construct();
  Guard._construct();

  /// Entry point to guard clauses.
  static Guard get against => _instance;
}
