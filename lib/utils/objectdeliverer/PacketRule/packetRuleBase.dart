// Copyright (c) 2020 ayuma_x. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

abstract class PacketRuleBase {
  int get wantSize;

  PacketRuleBase clone();

  void initialize();

  Uint8List makeSendPacket(Uint8List bodyBuffer);

  Iterable<Uint8List> makeReceivedPacket(Uint8List dataBuffer);
}
