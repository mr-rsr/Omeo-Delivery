class OrderDetail {
  OrderDetail({
    required this.ordersList,
    required this.status,
    required this.timeLeft,
    required this.timeStamp,
    required this.totalOrderValue,
    required this.trackNumber,
    required this.userAddress,
    required this.userId,
    required this.associatedOrderId,
    required this.estimatedTime,
    required this.estimatedDistance,
  });
  late final List<OrdersList> ordersList;
  late final int status;
  late final int timeLeft;
  late final int timeStamp;
  late final double totalOrderValue;
  late final int trackNumber;
  late final String userAddress;
  late final String userId;
  late final String associatedOrderId;
  late final double estimatedTime;
  late final double estimatedDistance;

  OrderDetail.fromJson(Map<String, dynamic> json) {
    ordersList = List.from(json['ordersList'])
        .map((e) => OrdersList.fromJson(e))
        .toList();
    status = json['status'];
    timeLeft = json['timeLeft'];
    timeStamp = json['timeStamp'];
    totalOrderValue = json['totalOrderValue'].toDouble();
    trackNumber = json['trackNumber'];
    userAddress = json['userAddress'];
    userId = json['userId'];
    associatedOrderId = json['associatedOrderId'];
    estimatedTime = json['estimatedTime'].toDouble();
    estimatedDistance = json['estimatedDistance'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ordersList'] = ordersList.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['timeLeft'] = timeLeft;
    _data['timeStamp'] = timeStamp;
    _data['totalOrderValue'] = totalOrderValue;
    _data['trackNumber'] = trackNumber;
    _data['userAddress'] = userAddress;
    _data['userId'] = userId;
    _data['associatedOrderId'] = associatedOrderId;
    _data['estimatedTime'] = estimatedTime;
    _data['estimatedDistance'] = estimatedDistance;
    return _data;
  }
}

class OrdersList {
  OrdersList({
    required this.order,
    required this.retailerId,
    required this.retailerLocation,
    required this.updatedAt,
  });
  late final Order order;
  late final String retailerId;
  late final String retailerLocation;
  late final int updatedAt;

  OrdersList.fromJson(Map<String, dynamic> json) {
    order = Order.fromJson(json['order']);
    retailerId = json['retailerId'];
    retailerLocation = json['retailerLocation'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order'] = order.toJson();
    _data['retailerId'] = retailerId;
    _data['retailerLocation'] = retailerLocation;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Order {
  Order({
    required this.address,
    required this.associatedOrderId,
    required this.discount,
    this.endTime,
    required this.fulfillCode,
    required this.itemsCount,
    required this.orderId,
    required this.orderStatusCode,
    required this.paymentMethod,
    required this.prescriptionUrl,
    this.startTime,
    required this.statusCode,
    required this.timeStamp,
    required this.totalAmount,
    required this.userId,
  });
  late final Address address;
  late final String associatedOrderId;
  late final int discount;
  late final Null endTime;
  late final int fulfillCode;
  late final int itemsCount;
  late final String orderId;
  late int orderStatusCode;
  late final String paymentMethod;
  late final String prescriptionUrl;
  late final Null startTime;
  late final int statusCode;
  late final int timeStamp;
  late final double totalAmount;
  late final String userId;

  Order.fromJson(Map<String, dynamic> json) {
    address = Address.fromJson(json['address']);
    associatedOrderId = json['associatedOrderId'];
    discount = json['discount'];
    endTime = null;
    fulfillCode = json['fulfillCode'];
    itemsCount = json['itemsCount'];
    orderId = json['orderId'];
    orderStatusCode = json['orderStatusCode'];
    paymentMethod = json['paymentMethod'];
    prescriptionUrl = json['prescriptionUrl'];
    startTime = null;
    statusCode = json['statusCode'];
    timeStamp = json['timeStamp'];
    totalAmount = json['totalAmount'].toDouble();
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address.toJson();
    _data['associatedOrderId'] = associatedOrderId;
    _data['discount'] = discount;
    _data['endTime'] = endTime;
    _data['fulfillCode'] = fulfillCode;
    _data['itemsCount'] = itemsCount;
    _data['orderId'] = orderId;
    _data['orderStatusCode'] = orderStatusCode;
    _data['paymentMethod'] = paymentMethod;
    _data['prescriptionUrl'] = prescriptionUrl;
    _data['startTime'] = startTime;
    _data['statusCode'] = statusCode;
    _data['timeStamp'] = timeStamp;
    _data['totalAmount'] = totalAmount;
    _data['userId'] = userId;
    return _data;
  }
}

class Address {
  Address({
    required this.address,
    required this.addressId,
    required this.addressTitle,
    required this.landmark,
    required this.location,
  });
  late final String address;
  late final String addressId;

  late final String addressTitle;
  late final String landmark;
  late final String location;

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressId = json['addressId'];

    addressTitle = json['addressTitle'];
    landmark = json['landmark'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address;
    _data['addressId'] = addressId;

    _data['addressTitle'] = addressTitle;
    _data['landmark'] = landmark;
    _data['location'] = location;
    return _data;
  }
}
