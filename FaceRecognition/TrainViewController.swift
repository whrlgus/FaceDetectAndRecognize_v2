//
//  ViewController.swift
//  FaceRecognition
//
//  Created by 조기현 on 05/07/2019.
//  Copyright © 2019 none. All rights reserved.
//


import UIKit

protocol TrainViewControllerDelegate {
    func viewControllerDismissed()
}

class TrainViewController: UIViewController,TrainDelegate {
    
    var train:Train!
    var delegate: TrainViewControllerDelegate?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        train = Train(viewController: self, andImageView: imageView, andSubImageView: subImageView)
    }
    
    func didFinishTrain() {
        if (self.delegate) != nil{
            delegate?.viewControllerDismissed()
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}

