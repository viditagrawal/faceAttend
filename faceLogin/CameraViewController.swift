//
//  CameraViewController.swift
//  faceLogin
//
//  Created by Vidit Agrawal on 3/22/19.
//  Copyright © 2019 Vidit Agrawal. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import ProjectOxfordFace

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var moveRight: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var cameraView: UIView!
    
    
    var imagePerson: UIImage!
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var storageRef: StorageReference!
    var storageRef2: StorageReference!
    var person = "None";
    
    @IBOutlet weak var viditLabel: UILabel!
    var faceFromPhoto: MPOFace!
    var faceFromFirebase: MPOFace!
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = Storage.storage().reference().child("IMG_3779.JPG")
       
        

        // Do any additional setup after loading the view.
    }
    @IBAction func takePicture(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType, kCVPixelBufferWidthKey as String: 160, kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        sessionOutput.capturePhoto(with: settings, delegate: self)
        print("hi")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if let sampleBuffer = photoSampleBuffer, let previewBuffer  = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer)
        {
            self.imagePerson = UIImage(data: dataImage)
            storageRef.downloadURL(completion: {(url, error) in
                if(error != nil)
                {
                    print(error!)
                    return
                }
                self.verify(withURL: url!.absoluteString)
                print(url)
            })
            
        }
    }
    func verify(withURL url :String)
    {
        print("hi")
        let client = MPOFaceServiceClient(endpointAndSubscriptionKey: "https://westcentralus.api.cognitive.microsoft.com/face/v1.0", key: "21e79bf188994126bdc40706f2e2d7c0")
        
        let data = imagePerson.jpegData(compressionQuality: 0.8)
        
        client?.detect(with: data, returnFaceId: true, returnFaceLandmarks: true, returnFaceAttributes: [], completionBlock: { (faces, error) in
            if(error != nil)
            {
                print(error!)
                return
            }
            if(faces!.count) > 1 || (faces!.count) == 0{
                print("too many or not enough")
                self.viditLabel.text = "Present: Unknown Person"
                self.button.tintColor = .red
                return
            }
            self.faceFromPhoto = faces![0]
            client?.detect(withUrl: url, returnFaceId: true, returnFaceLandmarks: true, returnFaceAttributes: [], completionBlock: { (faces, error) in
                if(error != nil)
                {
                    print(error!)
                    return
                }
                self.faceFromFirebase = faces![0]
                client?.verify(withFirstFaceId: self.faceFromPhoto.faceId, faceId2: self.faceFromFirebase.faceId, completionBlock: { (result, error) in
                    if(error != nil)
                    {
                        print(error!)
                        return
                    }
                    if(result!.isIdentical)
                    {
                        print("logged in")
                        self.viditLabel.isHidden = false
                        self.button.tintColor = .green

                        self.view.bringSubviewToFront(self.viditLabel)
                     
                        return
                        
                    }
                    else
                    {
                        print("not logged in")
                        self.viditLabel.isHidden = false
                        self.viditLabel.text = "Unknown Person"
                        self.button.tintColor = .red

                        self.view.bringSubviewToFront(self.viditLabel)
                        return
                    }
                })
            })
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDuoCamera,.builtInTelephotoCamera,.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        
        for device in (deviceSession.devices) {
            
            if device.position == AVCaptureDevice.Position.front {
                
                do {
                    
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if captureSession.canAddInput(input){
                        captureSession.addInput(input)
                        
                        if captureSession.canAddOutput(sessionOutput){
                            captureSession.addOutput(sessionOutput)
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                            previewLayer.connection?.videoOrientation = .portrait
                            
                            cameraView.layer.addSublayer(previewLayer)
                            cameraView.addSubview(button)
                            cameraView.addSubview(moveRight)
                            previewLayer.position = CGPoint (x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
                            previewLayer.bounds = cameraView.frame
                            
                            captureSession.startRunning()
                            
                        }
                    }
                    
                    
                } catch let avError {
                    print(avError)
                }
                
                
            }
            
        }
        
    }

     // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
