import 'dart:typed_data';
import 'package:co_safe/controller/local_notify_manager.dart';
import 'package:co_safe/controller/notification_data.dart';
import 'package:co_safe/models/notifications.dart';
import 'package:co_safe/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:provider/provider.dart';

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  late bool _stop;
  String _userName = "";
  Set<String> _devicesConnectedBefore = {};
  final Strategy _strategy = Strategy.P2P_STAR;
  late final LocalNotificationManager _localNotificationManager;
  @override
  void initState() {
    _userName = Provider.of<UserProvider>(context, listen: false).id;
    _localNotificationManager = LocalNotificationManager();
    _localNotificationManager.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 6.5,
      child: Switch(
        value: Provider.of<UserProvider>(context, listen: true).optIn,
        onChanged: (value) async {
          Provider.of<UserProvider>(context, listen: false).toggleOptIn(value);
          if (Provider.of<UserProvider>(context, listen: false).optIn) {
            if (!await Nearby().checkLocationPermission()) {
              await Nearby().askLocationPermission();
            }
            if (!await Nearby().checkLocationEnabled()) {
              await Nearby().enableLocationServices();
            }
            _stop = false;
            if (Provider.of<UserProvider>(context, listen: false).isInfected) {
              startDiscovery();
            } else {
              startAdvertising();
            }
          } else {
            _stop = true;
            await Nearby().stopAdvertising();
            await Nearby().stopDiscovery();
            _devicesConnectedBefore.clear();
          }
        },
      ),
    );
  }

  void showSnackBar(dynamic a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a.toString()),
    ));
  }

  void sendData(String receivingDeviceId) {
    String data = "infected";
    Nearby().sendBytesPayload(
        receivingDeviceId, Uint8List.fromList(data.codeUnits));
  }

  void startDiscovery() async {
    if (!_stop) {
      try {
        await Nearby().startDiscovery(
          _userName,
          _strategy,
          onEndpointFound: (id, name, serviceId) async {
            await Nearby().stopDiscovery();
            if (!_devicesConnectedBefore.contains(name)) {
              _devicesConnectedBefore.add(name);
              await Future.delayed(Duration(seconds: 2));
              Nearby().requestConnection(
                _userName,
                id,
                onConnectionInitiated: discoveryOnConnectionInit,
                onConnectionResult: (id, status) async {
                  if (status == Status.CONNECTED) sendData(id);
                  if (status == Status.REJECTED) {
                    _devicesConnectedBefore.add(name);
                    await Future.delayed(Duration(seconds: 2));
                    startDiscovery();
                  }
                },
                onDisconnected: (id) async {
                  await Future.delayed(Duration(seconds: 2));
                  startDiscovery();
                },
              );
            } else {
              await Future.delayed(Duration(seconds: 2));
              startDiscovery();
            }
          },
          onEndpointLost: (id) {},
        );
      } catch (e) {
        showSnackBar(e);
      }
    } else {
      await Nearby().stopDiscovery();
      _devicesConnectedBefore.clear();
    }
  }

  void startAdvertising() async {
    if (!_stop) {
      try {
        await Nearby().startAdvertising(
          _userName,
          _strategy,
          onConnectionInitiated: advertisingOnConnectionInit,
          onConnectionResult: (id, status) {},
          onDisconnected: (id) async {
            await Future.delayed(Duration(seconds: 2));
            startAdvertising();
          },
        );
      } catch (exception) {
        showSnackBar(exception);
      }
    } else {
      await Nearby().stopAdvertising();
      _devicesConnectedBefore.clear();
    }
  }

  void advertisingOnConnectionInit(String id, ConnectionInfo info) async {
    await Nearby().stopAdvertising();
    await Future.delayed(Duration(seconds: 2));
    if (!_devicesConnectedBefore.contains(info.endpointName)) {
      _devicesConnectedBefore.add(info.endpointName);
      Nearby().acceptConnection(
        id,
        onPayLoadRecieved: (endId, payload) async {
          String data = String.fromCharCodes(payload.bytes!);
          if (data == 'infected') {
            await _localNotificationManager.showNotification();
            Notifications notification = Notifications(
              date: DateTime.now().toString(),
              title: 'Warning',
              message: 'there is an infected person around you',
              userId: _userName,
            );
            await NotificationData().pushNotification(notification);
          }
        },
        onPayloadTransferUpdate: (endId, payloadTransferUpdate) async {
          if (payloadTransferUpdate.status == PayloadStatus.IN_PROGRESS) {
            print(payloadTransferUpdate.bytesTransferred);
          } else if (payloadTransferUpdate.status == PayloadStatus.FAILURE) {
            print("failed");
            showSnackBar("FAILED to transfer file");
          } else if (payloadTransferUpdate.status == PayloadStatus.SUCCESS) {
            await Future.delayed(Duration(seconds: 1));
            await Nearby().stopAllEndpoints();
          }
        },
      );
    } else {
      await Nearby().rejectConnection(id);
      await Future.delayed(Duration(seconds: 2));
      startAdvertising();
    }
  }

  void discoveryOnConnectionInit(String id, ConnectionInfo info) async {
    await Future.delayed(Duration(seconds: 2));
    Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endId, payload) {},
      onPayloadTransferUpdate: (endId, payloadTransferUpdate) {},
    );
  }
}
