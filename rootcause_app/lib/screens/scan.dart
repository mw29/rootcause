import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}


class _ScanScreenState extends State<ScanScreen> {
  bool _isLoading = false; // CHANGE THIS TO TRUE
  bool _permissionDenied = false; // ALSO CHANGE THIS TO FALSE

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  void dispose(){
    this.dispose();
  }

  void _requestPermissions() async {
    print("Requesting Camera Permissions...");
    setState(() {
      _isLoading = true;
    });
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildCameraContent() {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: 15),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  "_loadingMessage will go here",
                  key: ValueKey<String>("_loadingMessage will go here"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (_permissionDenied) return _buildPermissionDeniedView();
    return Scaffold(body: Center(child: Text("Camera Screen Will Go Here")));
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_photography, size: 80, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'Camera Access Required',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Please enable camera access in your device settings to use this feature',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton.icon(
            icon: Icon(Icons.settings),
            label: Text('Open Settings'),
            onPressed: () => openAppSettings(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _buildCameraContent());
  }
}
