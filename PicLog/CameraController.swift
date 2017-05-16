//
//  CameraController.swift
//  PicLog
//
//  Created by Daniel Catania on 14/4/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let capture = AVCaptureSession()
    var preview:CALayer!
    
    var captureDevice:AVCaptureDevice!
    
    var takePhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepare()
    }
    
    
    func prepare() {
        capture.sessionPreset = AVCaptureSessionPresetPhoto
        
        if #available(iOS 10.0, *) {
            if let availableDevices = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .back).devices {
                captureDevice = availableDevices.first
                beginSession()
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func beginSession () {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            capture.addInput(captureDeviceInput)
            
        }catch {
            print(error.localizedDescription)
        }
        
        
        if let previewLayer = AVCaptureVideoPreviewLayer(session: capture) {
            self.preview = previewLayer
            self.view.layer.addSublayer(self.preview)
            self.preview.frame = self.view.layer.frame
            capture.startRunning()
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)]
            
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if capture.canAddOutput(dataOutput) {
                capture.addOutput(dataOutput)
            }
            
            capture.commitConfiguration()
            
            
            let queue = DispatchQueue(label: "com.brianadvent.captureQueue")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
    
        }
        
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        takePhoto = true
        
    }
    
    /*
    func getImageFromSampleBuffer (buffer:CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
            
        }
        
        return nil
    }
    */
    
    func stopCaptureSession () {
        self.capture.stopRunning()
        
        if let inputs = capture.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.capture.removeInput(input)
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

