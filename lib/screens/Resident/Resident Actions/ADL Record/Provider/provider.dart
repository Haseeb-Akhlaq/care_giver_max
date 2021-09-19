import 'package:caregiver_max/Models/Resident/Adl/manage_adl_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdlRecordProvider extends ChangeNotifier {
  List<Status> allStatus = [];
  List<Detail> allDetails = [];

  List<SelectedHeader> allSelectedHeader = [];
  List<SelectedHeader> previousRecordHeaders = [];

  List<AdlRecordInfo> selectedStatusOption = [];

  List<AdlWithHeader> selectedOptionWithHeader = [];

  List<SavedAdlRecord> allSavedAdlRecords = [];

  getAllStatus() async {
    allStatus = [];

    final statues =
        await FirebaseFirestore.instance.collection('Config ADL Status').get();

    statues.docs.forEach((element) {
      allStatus.add(Status.fromMap(element.data()));
    });
  }

  getAllDetails() async {
    allDetails = [];

    final details =
        await FirebaseFirestore.instance.collection('Config ADL Details').get();

    details.docs.forEach((element) {
      allDetails.add(Detail.fromMap(element.data()));
    });

    print('Here are the details');

    //ADDING THE STATUS LIST OF OBJECT TO DETAIL OBJECT
    allDetails.forEach((detailItem) {
      detailItem.statusIds!.forEach((statusId) {
        detailItem.statuses!
            .add(allStatus.firstWhere((element) => element.id == statusId));
      });
    });
  }

  Future getHeadersWithOptions(String residentId) async {
    allSelectedHeader = [];
    selectedStatusOption = [];

    final selectedHeaders = await FirebaseFirestore.instance
        .collection('Resident Action ADL')
        .doc(residentId)
        .collection('Headers')
        .get();

    selectedHeaders.docs.forEach((element) {
      //CONVERTING THE DETAILS iDS TO DETAIL OBJECT
      List<Detail> selectedDetails = [];

      List<String> selectedDetailsIds = [...element.data()['selectedDetails']];

      selectedDetailsIds.forEach((detailId) {
        selectedDetails
            .add(allDetails.firstWhere((element) => element.id == detailId));
      });

      //CONVERTING THE DETAILS iDS TO DETAIL OBJECT

      allSelectedHeader.add(
        SelectedHeader(
          header: element.data()['headerName'],
          headerId: element.data()['id'],
          selectedDetails: selectedDetails,
        ),
      );
    });

    print('FECTEDED');

    print(allSelectedHeader[2].selectedDetails!.length);
    notifyListeners();
  }

  addSelectedOptions(AdlRecordInfo optionData) {
    //CHECKING IF THE RECORD ALREADY EXISTS AND REMOVING THEM

    List indexesToRemove = [];

    selectedStatusOption.forEach((element) {
      if (element.detailsId == optionData.detailsId &&
          element.headerId == optionData.headerId) {
        indexesToRemove.add(selectedStatusOption.indexOf(element));
      }
    });
    indexesToRemove.forEach((element) {
      selectedStatusOption.removeAt(element);
    });

    selectedStatusOption.add(optionData);

    selectedStatusOption.forEach((element) {
      print(element.headerId);
    });

    print('selected Options');
    print(selectedStatusOption.length);
  }

  saveAdlData({String? residentId}) async {
    selectedOptionWithHeader = [];
    selectedStatusOption.forEach((option) {
      int indexToAdd = selectedOptionWithHeader
          .indexWhere((element) => element.headerId == option.headerId);

      print('index');
      print(indexToAdd);

      if (indexToAdd == -1) {
        print('Added to External List');
        print('----------------------------');
        selectedOptionWithHeader.add(AdlWithHeader(
            headerId: option.headerId,
            list: [option],
            headerName: option.headerName));
      } else {
        selectedOptionWithHeader[indexToAdd].list!.add(option);
      }

      if (selectedOptionWithHeader.isEmpty) {
        selectedOptionWithHeader.add(
          AdlWithHeader(headerId: option.headerId, list: [option]),
        );
      }
    });

    print('-----');
    print(selectedOptionWithHeader.length);

    final time = DateTime.now();

    if (selectedOptionWithHeader.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Resident Action ADL Data')
          .doc(residentId)
          .collection('date')
          .doc(time.toString())
          .set({
        'time': time,
        'Data': selectedOptionWithHeader
            .map((e) => {
                  'headerId': e.headerId,
                  'headerName': e.headerName,
                  'data': e.list!
                      .map((e) => {
                            'headerId': e.headerId,
                            'detailId': e.detailsId,
                            'statusId': e.statusId,
                            'remarks': e.remarks,
                            'addedBy': e.addedBy,
                          })
                      .toList(),
                })
            .toList(),
      });
    }
    selectedOptionWithHeader = [];
    selectedStatusOption = [];
  }

  getAllSavedRecords({String? residentId}) async {
    //GETTING RECORDS FROM FIREBASE AND CONVERTING IT TO OBJECT

    allSavedAdlRecords = [];

    final savedRecords = await FirebaseFirestore.instance
        .collection('Resident Action ADL Data')
        .doc(residentId)
        .collection('date')
        .get();

    savedRecords.docs.forEach((element) {
      List<AdlWithHeader> newRecordedData = [];

      element.data()['Data'].forEach((dataWithHeaderInfo) {
        List<AdlRecordInfo> records = [];

        dataWithHeaderInfo['data'].forEach((recordData) {
          records.add(AdlRecordInfo.fromMap(recordData));
        });

        newRecordedData.add(
          AdlWithHeader(
              headerId: dataWithHeaderInfo['headerId'],
              list: records,
              headerName: dataWithHeaderInfo['headerName']),
        );
      });
      allSavedAdlRecords.add(
        SavedAdlRecord(
            time: Timestamp.fromMillisecondsSinceEpoch(
                    element.data()['time'].millisecondsSinceEpoch)
                .toDate()
                .toString(),
            records: newRecordedData),
      );
    });
    notifyListeners();
  }

  configureRecordHeaderList(String recordTime) {
    //GETTING LIST OF DATA FOR SPECIFIC TIME FROM RECORD DROPDOWN

    previousRecordHeaders = [];

    final SavedAdlRecord s =
        allSavedAdlRecords.firstWhere((element) => element.time == recordTime);

    List<Detail> detailsInData = [];

    s.records!.forEach((recordWithHeader) {
      detailsInData = [];
      recordWithHeader.list!.forEach((element) {
        print('ewf');

        final detail =
            allDetails.firstWhere((details) => details.id == element.detailsId);
        final selectedStatus =
            allStatus.firstWhere((status) => status.id == element.statusId);
        selectedStatus.remarks = element.remarks;
        detail.selectedStatus = selectedStatus;
        detailsInData.add(detail);
      });

      previousRecordHeaders.add(
        SelectedHeader(
            header: recordWithHeader.headerName,
            headerId: recordWithHeader.headerId,
            selectedDetails: detailsInData),
      );
    });
    notifyListeners();
  }
}
