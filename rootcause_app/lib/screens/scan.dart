import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  bool _isLoading = true;
  bool _permissionDenied = false;
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestPermissions();
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  void _requestPermissions() async {
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

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(
        _cameras!.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras!.first,
        ),
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (!mounted) return;

      setState(() => _isLoading = false);
    } on CameraException catch (e) {
      setState(() {
        _isLoading = false;
        _permissionDenied = e.code == 'CameraAccessDenied';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
        _permissionDenied = e.code == 'CameraAccessDenied';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
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
