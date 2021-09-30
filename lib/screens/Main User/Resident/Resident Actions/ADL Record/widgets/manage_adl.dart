import 'package:auto_size_text/auto_size_text.dart';
import 'package:caregiver_max/Models/Resident/Adl/manage_adl_models.dart';
import 'package:caregiver_max/Models/Resident/resident.dart';
import 'package:caregiver_max/screens/Main%20User/Resident/Resident%20Actions/ADL%20Record/Provider/provider.dart';
import 'package:caregiver_max/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageDailyAdlExpansionTile extends StatefulWidget {
  final Resident? resident;
  const ManageDailyAdlExpansionTile({Key? key, this.resident})
      : super(key: key);

  @override
  _ManageDailyAdlExpansionTileState createState() =>
      _ManageDailyAdlExpansionTileState();
}

class _ManageDailyAdlExpansionTileState
    extends State<ManageDailyAdlExpansionTile> {
  String? recordDropDown;

  List<SelectedHeader> allSelectedHeaderFromSetupAdl = [];
  List<SelectedHeader> previousRecordedData = [];

  List<SavedAdlRecord> allSavedAdlRecords = [];
  List savedRecordList = ['New Record'];

  fetchData() async {
    await Provider.of<AdlRecordProvider>(context, listen: false).getAllStatus();

    await Provider.of<AdlRecordProvider>(context, listen: false)
        .getAllDetails();

    await Provider.of<AdlRecordProvider>(context, listen: false)
        .getHeadersWithOptions(widget.resident!.id!);

    await Provider.of<AdlRecordProvider>(context, listen: false)
        .getAllSavedRecords(residentId: widget.resident!.id!);

    setRecordDropDownList();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  setRecordDropDownList() {
    //we are using this function to convert the object list to string to display on record
    //dropDown menu

    savedRecordList = ['New Record'];

    allSavedAdlRecords = Provider.of<AdlRecordProvider>(context, listen: false)
        .allSavedAdlRecords;

    print('adl record length');
    print(allSavedAdlRecords.length);

    allSavedAdlRecords.forEach((element) {
      savedRecordList.add(element.time);
    });

    //DateFormat.yMd().format(DateTime.parse(element.time!))

    print(savedRecordList.length);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    allSelectedHeaderFromSetupAdl =
        Provider.of<AdlRecordProvider>(context).allSelectedHeader;
    previousRecordedData =
        Provider.of<AdlRecordProvider>(context).previousRecordHeaders;

    print('---TEST-----------');
    previousRecordedData.forEach((header) {
      header.selectedDetails!.forEach((element) {
        print(element.selectedStatus!.remarks);
        print(element.selectedStatus!.id);
      });
    });
    print('---TEST-----------');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainGrey.withOpacity(0.3),
      ),
      child: ExpansionTile(
        leading: Icon(Icons.border_horizontal_rounded),
        title: Text(
          'Manage Daily ADL',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 20),
                            focusColor: Theme.of(context).primaryColor,
                            hintText: recordDropDown == null
                                ? 'New Record'
                                : recordDropDown!,
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          items: savedRecordList.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                recordDropDown = val.toString();
                              },
                            );

                            Provider.of<AdlRecordProvider>(context,
                                    listen: false)
                                .resetStatusOptions();

                            if (recordDropDown != 'New Record') {
                              Provider.of<AdlRecordProvider>(context,
                                      listen: false)
                                  .configureRecordHeaderList(recordDropDown!);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    (recordDropDown == null || recordDropDown == 'New Record')
                        ? GestureDetector(
                            onTap: () async {
                              await Provider.of<AdlRecordProvider>(context,
                                      listen: false)
                                  .saveAdlData(residentId: widget.resident!.id);

                              await Provider.of<AdlRecordProvider>(context,
                                      listen: false)
                                  .getAllSavedRecords(
                                      residentId: widget.resident!.id);

                              setRecordDropDownList();

                              print('Updated');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Saved Successfully'),
                                duration: Duration(
                                  seconds: 1,
                                ),
                              ));
                            },
                            child: Icon(
                              Icons.save,
                              size: 50,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await Provider.of<AdlRecordProvider>(context,
                                      listen: false)
                                  .updateAdlData(
                                residentId: widget.resident!.id,
                                time: recordDropDown,
                              );

                              print('Updated');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Updated Successfully'),
                                duration: Duration(
                                  seconds: 1,
                                ),
                              ));
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // allSelectedHeaderFromSetupAdl[0]
                    //     .selectedDetails!
                    //     .forEach((element) {
                    //   print(element.);
                    // });
                  },
                  child: Text(
                    'ADL Record',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //DISPLAYING THE RECORD DATA OR NEW HEADER DATA

                if (recordDropDown == 'New Record' || recordDropDown == null)
                  ...allSelectedHeaderFromSetupAdl.map((e) => Column(
                        children: [
                          DetailBox(
                            selectedHeader: e,
                            displayRecordData: false,
                            headerIndex: null,
                          ),
                          SizedBox(height: 20),
                        ],
                      )),
                if (recordDropDown != 'New Record' && recordDropDown != null)
                  ...previousRecordedData.map((e) => Column(
                        children: [
                          DetailBox(
                            selectedHeader: e,
                            displayRecordData: true,
                            headerIndex: previousRecordedData.indexOf(e),
                            residentId: widget.resident!.id,
                            time: recordDropDown,
                          ),
                          SizedBox(height: 20),
                        ],
                      )),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DetailBox extends StatelessWidget {
  final SelectedHeader? selectedHeader;
  final bool? displayRecordData;
  final int? headerIndex;
  final String? residentId;
  final String? time;
  const DetailBox({
    this.selectedHeader,
    this.displayRecordData,
    this.headerIndex,
    this.residentId,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return (selectedHeader!.selectedDetails!.length > 0)
        ? Container(
            color: Colors.blue.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedHeader!.header!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (displayRecordData == false)
                    ...selectedHeader!.selectedDetails!.map(
                      (e) => ManageAdlStatusOptions(
                        headerId: selectedHeader!.headerId,
                        detailTitle: e.title,
                        detailId: e.id,
                        statusList: e.statuses,
                        headerName: selectedHeader!.header,
                      ),
                    ),
                  if (displayRecordData == true)
                    ...selectedHeader!.selectedDetails!.map((e) {
                      print('04843');
                      print(e.selectedStatus!.title);
                      print(e.selectedStatus!.remarks);

                      return DisplayRecordedStatuses(
                        headerId: selectedHeader!.headerId,
                        headerName: selectedHeader!.header,
                        detailTitle: e.title,
                        detailId: e.id,
                        statusList: e.statuses,
                        selectedStatus: e.selectedStatus!.title,
                        remarks: e.selectedStatus!.remarks,
                      );
                    }),
                ],
              ),
            ),
          )
        : Container();
  }
}

class ManageAdlStatusOptions extends StatefulWidget {
  final String? headerId;
  final String? detailTitle;
  final String? detailId;
  final String? headerName;
  final List<Status>? statusList;

  const ManageAdlStatusOptions({
    this.detailTitle,
    this.headerName,
    this.statusList,
    this.detailId,
    this.headerId,
  });

  @override
  State<ManageAdlStatusOptions> createState() => _ManageAdlStatusOptionsState();
}

class _ManageAdlStatusOptionsState extends State<ManageAdlStatusOptions> {
  String? status;
  TextEditingController remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //String? uid = FirebaseAuth.instance.currentUser!.uid;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          widget.detailTitle!,
          minFontSize: 14,
          maxFontSize: 16,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20),
              focusColor: Theme.of(context).primaryColor,
              hintText: status == null ? 'Select>>' : status!,
            ),
            isExpanded: true,
            iconSize: 30.0,
            items: widget.statusList!.map(
              (val) {
                return DropdownMenuItem(
                  value: val.title,
                  child: Text(val.title!),
                );
              },
            ).toList(),
            onChanged: (val) {
              FocusScope.of(context).requestFocus(FocusNode());

              setState(
                () {
                  status = val.toString();
                },
              );

              final aa = status;

              Provider.of<AdlRecordProvider>(context, listen: false)
                  .addSelectedOptions(
                AdlRecordInfo(
                    addedBy: '',
                    headerName: widget.headerName,
                    headerId: widget.headerId,
                    detailsId: widget.detailId,
                    statusId: widget.statusList!
                        .firstWhere((element) => element.title == aa)
                        .id,
                    remarks: remarksController.text),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              maxLines: 3,
              controller: remarksController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Remark',
              ),
              onChanged: (v) {
                final aa = status;

                Provider.of<AdlRecordProvider>(context, listen: false)
                    .addSelectedOptions(
                  AdlRecordInfo(
                      addedBy: '',
                      headerName: widget.headerName,
                      headerId: widget.headerId,
                      detailsId: widget.detailId,
                      statusId: widget.statusList!
                          .firstWhere((element) => element.title == aa)
                          .id,
                      remarks: remarksController.text),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class DisplayRecordedStatuses extends StatefulWidget {
  final String? headerId;
  final String? detailTitle;
  final String? detailId;
  final List<Status>? statusList;
  final String? selectedStatus;
  final String? remarks;
  final String? headerName;

  const DisplayRecordedStatuses({
    this.detailTitle,
    this.statusList,
    this.detailId,
    this.headerName,
    this.headerId,
    this.selectedStatus,
    this.remarks,
  });

  @override
  State<DisplayRecordedStatuses> createState() =>
      _DisplayRecordedStatusesState();
}

class _DisplayRecordedStatusesState extends State<DisplayRecordedStatuses> {
  String? status;
  List<Status>? list;
  TextEditingController remarksController = TextEditingController();

  setii() {
    status = widget.selectedStatus;
    list = widget.statusList;
    remarksController.text = widget.remarks!;

    print('seeted');
  }

  @override
  void didUpdateWidget(covariant DisplayRecordedStatuses oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print('updated Widget');
    status = widget.selectedStatus;
    remarksController.text = widget.remarks!;
    list = [];
    list = widget.statusList;

    list!.forEach((element) {
      print(element.title);
    });

    setState(() {});
  }

  @override
  void initState() {
    setii();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          widget.detailTitle!,
          minFontSize: 14,
          maxFontSize: 16,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20),
              focusColor: Theme.of(context).primaryColor,
              hintText: status == null ? 'Select>>' : status!,
            ),
            isExpanded: true,
            iconSize: 30.0,
            onChanged: (val) {
              FocusScope.of(context).requestFocus(FocusNode());

              final selectedStatus = val.toString();

              Provider.of<AdlRecordProvider>(context, listen: false)
                  .addSelectedOptions(
                AdlRecordInfo(
                    addedBy: '',
                    headerName: widget.headerName,
                    headerId: widget.headerId,
                    detailsId: widget.detailId,
                    statusId: list!
                        .firstWhere(
                            (element) => element.title == selectedStatus)
                        .id,
                    remarks: remarksController.text),
              );
            },
            items: list!.map(
              (val) {
                return DropdownMenuItem(
                  value: val.title,
                  child: Text(val.title!),
                );
              },
            ).toList(),
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              maxLines: 3,
              controller: remarksController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Remark',
              ),
              onChanged: (v) {
                final aa = status;

                Provider.of<AdlRecordProvider>(context, listen: false)
                    .addSelectedOptions(
                  AdlRecordInfo(
                      addedBy: '',
                      headerName: widget.headerName,
                      headerId: widget.headerId,
                      detailsId: widget.detailId,
                      statusId: widget.statusList!
                          .firstWhere((element) => element.title == aa)
                          .id,
                      remarks: remarksController.text),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
