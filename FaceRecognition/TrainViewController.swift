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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subImageView: UIImageView!
    
    var train:Train!
    var delegate: TrainViewControllerDelegate?
    let semaphore = DispatchSemaphore(value: 0)
    var alert:UIAlertController!
    var name:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        train = Train(viewController: self, andImageView: imageView, andSubImageView: subImageView)
        name=""
        initAlert()
    }
    
    func getName() -> String {
        DispatchQueue.main.async {
            self.present(self.alert, animated: true, completion: nil)
        }
        semaphore.wait()
        return name;
    }
    
    func didFinishTrain() {
        if (self.delegate) != nil{
            delegate?.viewControllerDismissed()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func initAlert(){
        alert = UIAlertController(title: "이름 설정", message: "이름을 입력하세요.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: alertActionHandler)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: alertActionHandler)
        
        alert.addTextField { (textField) in textField.placeholder = "이름 입력"}
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
    }
    
    func alertActionHandler(alertAction:UIAlertAction)
    {
        switch(alertAction.style) {
        case .cancel:
            NSLog("취소")
        case .default:
            NSLog("확인")
            name = self.alert.textFields?[0].text
        default:
            NSLog("애러")
        }
        semaphore.signal()
    }

}

