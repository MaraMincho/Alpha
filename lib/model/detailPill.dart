class DetailPillModel {
  String? entpName;
  String? itemName;
  String? itemSeq;
  String? efcyQesitm;
  String? useMethodQesitm;
  String? atpnWarnQesitm;
  String? atpnQesitm;
  String? intrcQesitm;
  String? seQesitm;
  String? depositMethodQesitm;

  DetailPillModel(
      {this.entpName,
        this.itemName,
        this.itemSeq,
        this.efcyQesitm,
        this.useMethodQesitm,
        this.atpnWarnQesitm,
        this.atpnQesitm,
        this.intrcQesitm,
        this.seQesitm,
        this.depositMethodQesitm});

  DetailPillModel.fromJson(Map<String, dynamic> json) {
    entpName = json['entpName'];
    itemName = json['itemName'];
    itemSeq = json['itemSeq'];
    efcyQesitm = json['efcyQesitm'];
    useMethodQesitm = json['useMethodQesitm'];
    atpnWarnQesitm = json['atpnWarnQesitm'] == null? json['atpnWarnQesitm'] : "없음";
    atpnQesitm = json['atpnQesitm'];
    intrcQesitm = json['intrcQesitm'];
    seQesitm = json['seQesitm'];
    depositMethodQesitm = json['depositMethodQesitm'];
    efcyQesitm = efcyQesitm?.replaceAll("&lt;p&gt;", "");
    efcyQesitm = efcyQesitm?.replaceAll("&lt;/p&gt;", "");
    useMethodQesitm = useMethodQesitm?.replaceAll("&lt;p&gt;", "");
    useMethodQesitm = useMethodQesitm?.replaceAll("&lt;/p&gt;", "");
    intrcQesitm = intrcQesitm?.replaceAll("&lt;p&gt;", "");
    intrcQesitm = intrcQesitm?.replaceAll("&lt;/p&gt;", "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entpName'] = this.entpName;
    data['itemName'] = this.itemName;
    data['itemSeq'] = this.itemSeq;
    data['efcyQesitm'] = this.efcyQesitm;
    data['useMethodQesitm'] = this.useMethodQesitm;
    data['atpnWarnQesitm'] = this.atpnWarnQesitm;
    data['atpnQesitm'] = this.atpnQesitm;
    data['intrcQesitm'] = this.intrcQesitm;
    data['seQesitm'] = this.seQesitm;
    data['depositMethodQesitm'] = this.depositMethodQesitm;
    return data;

  }
}