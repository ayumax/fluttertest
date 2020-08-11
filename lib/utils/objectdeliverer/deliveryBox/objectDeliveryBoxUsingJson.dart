// Copyright (c) 2020 ayuma_x. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.
import 'dart:convert';
import 'dart:typed_data';
import 'deliveryBoxBase.dart';

abstract class IJsonSerializable {
  void fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class ObjectDeliveryBoxUsingJson<T extends IJsonSerializable>
    extends DeliveryBoxBase<T> {
  @override
  Uint8List makeSendBuffer(T message) => utf8.encode(jsonEncode(message));

  @override
  T bufferToMessage(Uint8List buffer) {
    if (buffer.length == 0) return null;
    if (buffer[buffer.length - 1] == 0x00) {
      // Remove the terminal null
      buffer.removeLast();
    }

    T message;
    message.fromJson(jsonDecode(utf8.decode(buffer)));

    return message;
  }
}