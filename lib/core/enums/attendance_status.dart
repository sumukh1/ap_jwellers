enum AttendanceStatus { PRESENT, ABSENT, HALF_DAY }

extension AttendanceStatusX on AttendanceStatus {
  bool get isPresent => this == AttendanceStatus.PRESENT;
  bool get isAbsent => this == AttendanceStatus.ABSENT;
  bool get isHalfDay => this == AttendanceStatus.HALF_DAY;
}

extension AttendanceStatusString on String {
  AttendanceStatus toAttendanceStatus() {
    switch (this) {
      case 'PRESENT':
        return AttendanceStatus.PRESENT;
      case 'ABSENT':
        return AttendanceStatus.ABSENT;
      case 'HALF_DAY':
        return AttendanceStatus.HALF_DAY;
      default:
        return AttendanceStatus.ABSENT;
    }
  }
}
