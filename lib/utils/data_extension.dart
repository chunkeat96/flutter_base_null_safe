extension DateEx on double? {
  int get second {
    if (this == null) {
      return 0;
    }
    return (this! * 60).round();
  }
}
