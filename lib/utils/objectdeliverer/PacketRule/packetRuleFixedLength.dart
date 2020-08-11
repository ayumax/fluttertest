// Copyright (c) 2020 ayuma_x. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.
import 'dart:math';
import 'dart:typed_data';

import 'packetRuleBase.dart';
import '../Utils/growBuffer.dart';

class PacketRuleFixedLength extends PacketRuleBase {
  final GrowBuffer bufferForSend = GrowBuffer();

  int fixedSize = 128;

  @override
  int get wantSize => this.fixedSize;

  PacketRuleFixedLength.fromParam(this.fixedSize);

  @override
  void initialize() {
    this.bufferForSend.setBufferSize(this.fixedSize);
  }

  @override
  Uint8List makeSendPacket(Uint8List bodyBuffer) {
    this.bufferForSend.clear();

    Uint8List sendPacketSpan =
        bodyBuffer.take(min(bodyBuffer.length, this.fixedSize));
    this.bufferForSend.copyFrom(sendPacketSpan);

    return this.bufferForSend.memoryBuffer;
  }

  @override
  Iterable<Uint8List> makeReceivedPacket(Uint8List dataBuffer) sync* {
    if (this.wantSize > 0 && dataBuffer.length != this.wantSize) return;

    yield dataBuffer;
  }

  @override
  PacketRuleBase clone() => PacketRuleFixedLength.fromParam(this.fixedSize);
}
