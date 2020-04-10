////
////  MemeEditor.swift
////  imagePicker
////
////  Created by Lorenzo Masucci on 09/04/2020.
////  Copyright © 2020 MorningWall. All rights reserved.
////
//
//import UIKit
//
//class MemeEditor: UIViewController {
//    
//    let viewController = ViewController()
//    
//    func save() {
//        
//        _ = Meme(topText: viewController.topTextFieldOutlet.text!, bottomText: viewController.bottomTextFieldOutlet.text!, originalImage: viewController.imagePickerView.image!, memedImage: generateMemedImage())
//    }
//    
//    func generateMemedImage() -> UIImage {
//        
////        Render view to an image
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
//        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        return  memedImage
//    }
//}

