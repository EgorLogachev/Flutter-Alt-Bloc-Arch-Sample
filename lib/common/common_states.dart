class ProgressState {
  final bool inProgress;

  ProgressState._(this.inProgress);

  factory ProgressState.show() => ProgressState._(true);

  factory ProgressState.hide() => ProgressState._(false);
}
