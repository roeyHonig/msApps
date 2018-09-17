//
//  QRScannerViewController.swift
//  msApps
//
//  Created by hackeru on 8 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var video = AVCaptureVideoPreviewLayer() // will display for the user (on device screen), what the camera is showing
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // creating session
        let session = AVCaptureSession()
        
        // define capture device (the iphone the user is holding)
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        // the input for our session will come from the capture device
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("Error")
        }
        
        // output from the session
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
    }

    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            // there's a metaDataObject
            let metaDataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            if metaDataObj.type == AVMetadataObject.ObjectType.qr {
                // it is a QR code
                
                getMovieHeaderFromJSONText(FromJSONText: metaDataObj.stringValue!, callback: { (resultedMovieHeader) in
                    
                    self.showInputDialog(withMessage: resultedMovieHeader.title)
                })
                
                
            }
        }
    }
    
    func showInputDialog(withMessage str: String?) {
        let alertController = UIAlertController(title: "Adding a movie to your list", message: str, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (uiAlertAction) in
           // upon completion
            print("ok was pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (uiAlertAction) in
            
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            // upon completion
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
