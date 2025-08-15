enum WorkStatus { PENDING, RUNNING, COMPLETED }

extension WorkStatusX on WorkStatus {
  bool get isPending => this == WorkStatus.PENDING;
  bool get isRunning => this == WorkStatus.RUNNING;
  bool get isCompleted => this == WorkStatus.COMPLETED;
}

extension WorkStatusString on String {
  WorkStatus toWorkStatus() {
    switch (this) {
      case 'PENDING':
        return WorkStatus.PENDING;
      case 'RUNNING':
        return WorkStatus.RUNNING;
      case 'COMPLETED':
        return WorkStatus.COMPLETED;
      default:
        throw Exception('Invalid work status: $this');
    }
  }
}
