class Resident {
  String? id;
  String? status;
  String? propertyName;
  String? propertyId;
  String? residentName;
  String? admissionDate;
  String? primaryLanguage;
  String? admissionForm;
  String? occupation;
  String? placeOfBirth;
  String? address;
  String? telephone;
  String? race;
  String? age;
  String? dateOfBirth;
  String? sex;
  String? martialStatus;
  String? height;
  String? weight;
  String? socialSecurity;
  String? religion;
  String? clergyMan;
  String? churchSynagogue;
  String? telephoneChurch;
  String? addressChurch;
  String? medicare;
  String? medicaid;
  //////////
  String? insurance;
  String? insurancePolicy;
  String? insuranceGroup;
  String? telephoneInsurance;
  String? addressInsurance;
  String? insuranceGroupNo;
  //////////
  String? hospitalPreference;
  String? hospitalTelephone;
  String? hospitalEmail;
  //////////
  String? funeralHomePreference;
  String? funeralTelephone;
  //////////
  String? pharmacyPreference;
  String? pharmacyTelephone;
  //////////
  String? dentist;
  String? dentistTelephone;
  //////////
  String? physician;
  String? physicianAddress;
  String? physicianTelephone;
  //////////
  String? dateOfLastPhysicalExam;
  String? physicalExamYearlyPhysicalDue;
  String? physicalExamDiagnosis;
  String? physicalExamAllergies;
  //////////other Contact Info
  String? responsibleParty;
  String? responsiblePartyRelationship;
  String? responsiblePartyAddress;
  String? responsiblePartyTelephone;
  String? powerOfAttorney;
  String? powerOfAttorneyRelationship;
  String? powerOfAttorneyAddress;
  String? powerOfAttorneyTelephone;
  String? inCaseOfEmergency;
  String? inCaseOfEmergencyRelationship;
  String? inCaseOfEmergencyAddress;
  String? inCaseOfEmergencyTelephone;
  //////////Home health 0r hospice
  String? socialWorker;
  String? rn;
  String? theAid;
  String? phoneNumber;

  Resident({
    this.id,
    this.residentName,
    this.propertyName,
    this.propertyId,
    this.age,
    this.sex,
    this.admissionDate,
    this.admissionForm,
    this.dateOfBirth,
    this.address,
    this.telephone,
    this.telephoneChurch,
    this.height,
    this.addressChurch,
    this.churchSynagogue,
    this.clergyMan,
    this.martialStatus,
    this.medicaid,
    this.medicare,
    this.occupation,
    this.placeOfBirth,
    this.primaryLanguage,
    this.race,
    this.religion,
    this.socialSecurity,
    this.status,
    this.weight,
    this.insurance,
    this.insurancePolicy,
    this.insuranceGroup,
    this.addressInsurance,
    this.telephoneInsurance,
    this.insuranceGroupNo,
    this.hospitalPreference,
    this.hospitalEmail,
    this.hospitalTelephone,
    this.funeralHomePreference,
    this.funeralTelephone,
    this.pharmacyPreference,
    this.pharmacyTelephone,
    this.dentist,
    this.dentistTelephone,
    this.physician,
    this.physicianAddress,
    this.physicianTelephone,
    this.dateOfLastPhysicalExam,
    this.physicalExamAllergies,
    this.physicalExamDiagnosis,
    this.physicalExamYearlyPhysicalDue,
    this.responsibleParty,
    this.responsiblePartyRelationship,
    this.responsiblePartyAddress,
    this.responsiblePartyTelephone,
    this.powerOfAttorney,
    this.powerOfAttorneyRelationship,
    this.powerOfAttorneyAddress,
    this.powerOfAttorneyTelephone,
    this.inCaseOfEmergency,
    this.inCaseOfEmergencyRelationship,
    this.inCaseOfEmergencyAddress,
    this.inCaseOfEmergencyTelephone,
    this.socialWorker,
    this.rn,
    this.theAid,
    this.phoneNumber,
  });

  Resident.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.residentName = map['name'];
    this.propertyName = map['propertyName'];
    this.propertyId = map['propertyId'];
    this.age = map['age'];
    this.sex = map['sex'];
    this.admissionDate = map['admissionDate'];
    this.admissionForm = map['admissionForm'];
    this.dateOfBirth = map['dateOfBirth'];
    this.address = map['address'];
    this.telephone = map['telephone'];
    this.telephoneChurch = map['telephoneChurch'];
    this.height = map['height'];
    this.addressChurch = map['addressChurch'];
    this.churchSynagogue = map['churchSynagogue'];
    this.clergyMan = map['clergyman'];
    this.martialStatus = map['martialStatus'];
    this.medicaid = map['medicaid'];
    this.medicare = map['medicare'];
    this.occupation = map['occupation'];
    this.placeOfBirth = map['placeOfBirth'];
    this.primaryLanguage = map['primaryLanguage'];
    this.race = map['race'];
    this.religion = map['religion'];
    this.socialSecurity = map['socialSecurity'];
    this.status = map['status'];
    this.weight = map['weight'];
    ////
    this.insurance = map['insurance'] ?? '';
    this.insurancePolicy = map['insurancePolicy'] ?? '';
    this.insuranceGroup = map['insuranceGroup'] ?? '';
    this.addressInsurance = map['insuranceAddress'] ?? '';
    this.telephoneInsurance = map['insuranceTelephone'] ?? '';
    this.insuranceGroupNo = map['insuranceGroupNo'] ?? '';
    ////
    this.hospitalPreference = map['hospitalPreference'] ?? '';
    this.hospitalTelephone = map['hospitalTelephone'] ?? '';
    this.hospitalEmail = map['hospitalEmail'] ?? '';
    ////
    this.funeralHomePreference = map['funeralHomePreference'] ?? '';
    this.funeralTelephone = map['funeralTelephone'] ?? '';
    ////
    this.pharmacyPreference = map['pharmacyPreference'] ?? '';
    this.pharmacyTelephone = map['pharmacyTelephone'] ?? '';
    ////
    this.dentist = map['dentist'] ?? '';
    this.dentistTelephone = map['dentistTelephone'] ?? '';
    ////
    this.physician = map['physician'] ?? '';
    this.physicianAddress = map['physicianAddress'] ?? '';
    this.physicianTelephone = map['physicianTelephone'] ?? '';
    ////
    this.dateOfLastPhysicalExam = map['dateOfLastPhysicalExam'] ?? '';
    this.physicalExamYearlyPhysicalDue =
        map['physicalExamYearlyPhysicalDue'] ?? '';
    this.physicalExamDiagnosis = map['physicalExamDiagnosis'] ?? '';
    this.physicalExamAllergies = map['physicalExamAllergies'] ?? '';
    ////Other Contact Info
    this.responsibleParty = map['responsibleParty'] ?? '';
    this.responsiblePartyRelationship =
        map['responsiblePartyRelationship'] ?? '';
    this.responsiblePartyAddress = map['responsiblePartyAddress'] ?? '';
    this.responsiblePartyTelephone = map['responsiblePartyTelephone'] ?? '';
    this.powerOfAttorney = map['powerOfAttorney'] ?? '';
    this.powerOfAttorneyRelationship = map['powerOfAttorneyRelationship'] ?? '';
    this.powerOfAttorneyAddress = map['powerOfAttorneyAddress'] ?? '';
    this.powerOfAttorneyTelephone = map['powerOfAttorneyTelephone'] ?? '';
    this.inCaseOfEmergency = map['inCaseOfEmergency'] ?? '';
    this.inCaseOfEmergencyRelationship =
        map['inCaseOfEmergencyRelationship'] ?? '';
    this.inCaseOfEmergencyAddress = map['inCaseOfEmergencyAddress'] ?? '';
    this.inCaseOfEmergencyTelephone = map['inCaseOfEmergencyTelephone'] ?? '';
    //////////Home health 0r hospice
    this.socialWorker = map['socialWorker'] ?? '';
    this.rn = map['rn'] ?? '';
    this.theAid = map['theAid'] ?? '';
    this.phoneNumber = map['phoneNumber'] ?? '';
  }
}
