//
//  ViewController.swift
//  imagePicker
//
//  Created by Lorenzo Masucci on 08/04/2020.
//  Copyright © 2020 MorningWall. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextFieldOutlet: UITextField!
    @IBOutlet weak var bottomTextFieldOutlet: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let memeTextAttributes : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth : 4
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera
        )
        subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotification()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setText(text: topTextFieldOutlet, textAttribute: memeTextAttributes)
        setText(text: bottomTextFieldOutlet, textAttribute: memeTextAttributes)
        // Perchè lo richiama così il codice
        imagePickerView.contentMode = .scaleAspectFill
        shareButton.isEnabled = false
        
        
        
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    let memeEditor = MemeEditor()
    @IBAction func shareAction(_ sender: Any) {
        
        let imageGenerated = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [imageGenerated], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if completed {
                self.save()
            }
            
        }

    }
    
    
    
    
    
    
// MARK: Image Selection
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    

    
//    Delegate Method ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("didCancel")
        dismiss(animated: true, completion: nil)
    }
    

}


extension ViewController: UITextFieldDelegate {
    
    
//    MARK: Text Attributes
    func setText(text: UITextField, textAttribute: [NSAttributedString.Key : Any] ) {
         text.delegate = self
         text.defaultTextAttributes = textAttribute
        text.textAlignment = .center
     }
    
//    MARK: TextField Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
//    MARK: Keyboard Appearing Rules - (NOTIFICATION CENTER)
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    
}

extension ViewController {
    
        func save() {
            
            let meme = Meme(topText: topTextFieldOutlet.text!, bottomText: bottomTextFieldOutlet.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
            
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
        }
        
        func generateMemedImage() -> UIImage {
            
    //        Render view to an image
            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return  memedImage
        }
}
