//
//  ViewController.swift
//  imagePicker
//
//  Created by R&W on 01/12/21.
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
        openImagePicker()
    }
    var imagePicker: UIImagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    private func initialSetup() {
        selectPhotoButton.layer.cornerRadius = 10
        selectPhotoButton.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    private func openImagePicker() {
        let alert: UIAlertController = UIAlertController(title: "Profile", message: "choose your Profile picture", preferredStyle: .actionSheet)
        let cameraButton: UIAlertAction = UIAlertAction(title: "camera", style: .default) {_ in
            print("Camera Button Tapped")
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.configureImagePicker(sourecType: .camera)
            }else{
                self.showAlert(title: "camera", message: "your camera is not availabel. check your camera")
            }
        }
        let photosButton: UIAlertAction = UIAlertAction(title: "photos", style: .default) {_ in
            self.configureImagePicker(sourecType: .photoLibrary)
        }
        let cancelButton: UIAlertAction = UIAlertAction(title: "cancel", style: .cancel) {_ in
            print("cancel Button Tapped")
        }
        alert.addAction(cameraButton)
        alert.addAction(photosButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    private func configureImagePicker(sourecType: UIImagePickerController.SourceType) {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = sourecType
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel Button Tapped")
        dismiss(animated: true, completion: nil)
    }
    private func showAlert(title: String,message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton: UIAlertAction = UIAlertAction(title: "Yes", style: .default) {_ in
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
