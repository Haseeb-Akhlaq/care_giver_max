class ComprehensiveAssessment {
  String? time;
  List? sleepPatterns;
  List? behaviorSymptoms;
  List? frequencyOfBehaviorSymptoms;
  List? psychoSocialSignsOrSymptomsOfDepression;

  ComprehensiveAssessment({
    this.time,
    this.sleepPatterns,
    this.behaviorSymptoms,
    this.frequencyOfBehaviorSymptoms,
    this.psychoSocialSignsOrSymptomsOfDepression,
  });
}

class CheckBoxOption {
  String? name;
  bool? checked;

  CheckBoxOption({this.name, this.checked});
}
