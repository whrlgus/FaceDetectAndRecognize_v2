//
//  PredictViewController.swift
//  FaceRecognition
//
//  Created by 조기현 on 07/07/2019.
//  Copyright © 2019 none. All rights reserved.
//

class PredictViewController: UIViewController,TrainViewControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!

    var predict:Predict!
    var trainViewController:TrainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        predict = Predict(viewController: self, andImageView: imageView, andSubImageView: imageView)
        
    }
    
    func viewControllerDismissed() {
        predict = Predict(viewController: self, andImageView: imageView, andSubImageView: imageView)
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        predict.stop()
        trainViewController = self.storyboard?.instantiateViewController(withIdentifier: "sidTrain") as? TrainViewController
        trainViewController.delegate = self;
        self.present(trainViewController!, animated: true, completion: nil)
    }
}
