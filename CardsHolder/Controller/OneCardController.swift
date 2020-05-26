//
//  OneCardController.swift
//  CardsHolder
//
//  Created by Рома on 23.01.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import UIKit
import MessageUI

class OneCardController: UITableViewController {
    
    //MARK: - Propertya
    var card: VisitCard?
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var addPhotoLabel: UILabel!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.delegate = self
        textFieldPhone.delegate = self
        textFieldEmail.delegate = self
        
        if let card = card {
            textFieldName.text = card.name
            textFieldEmail.text = card.email
            textFieldPhone.text = card.phone
            
            if card.image != nil {
                imageView.image = card.image
                addPhotoLabel.text = ""
            }
            
            navigationItem.title = card.name
        }
    }
    
    //MARK: - Actions
    @IBAction func pushSaveAction(_ sender: Any) {
        //выводим alert если поле "имя" пустое
        if textFieldName.text == "" {
            let alert = UIAlertController(title: "", message: "Введите имя", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            
            if let card = card {
                card.name = textFieldName.text!
                card.email = textFieldEmail.text!
                card.phone = textFieldPhone.text!
                
                card.image = imageView.image
                Model.saveData()
            } else {
                //если визитка пустая, создаем новую
                let newCard = VisitCard(name: textFieldName.text!, email: textFieldEmail.text!, phone:
                    textFieldPhone.text!)
                //добавляем новую визитку на 1-е место
                dataArray.insert(newCard, at: 0)
                newCard.image = imageView.image
                Model.saveData()
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func callButtonAction(_ sender: Any) {
        if textFieldPhone.text != "" {
            let str = "tel://\(textFieldPhone.text!)"
            
            let url = URL(string: str)
            if url != nil {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            
        } else {
            let alertController = UIAlertController(title: "", message: "Неверный телефонный формат", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    var mailController: MFMailComposeViewController?
    @IBAction func sendEmailButtonAction(_ sender: Any) {
        mailController = MFMailComposeViewController()
        mailController?.mailComposeDelegate = self
        
        if textFieldEmail.text != "" {
            mailController?.setToRecipients([textFieldEmail.text!])
        } else {
            let alertController = UIAlertController(title: "Введите email", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
        present(mailController!, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {

        if imageView.image != nil && textFieldName.text != "" && textFieldPhone.text != "" && textFieldEmail.text != "" {
            let activityController = UIActivityViewController(activityItems: [imageView.image!, "Имя контакта: " + textFieldName.text!, "Номер телефона: " + textFieldPhone.text!, "Email: " + textFieldEmail.text!], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Заполните все поля", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - UIImagePickerController
    //ставим картинку по нажатию на 0-ю ячейку
    let imagePicker = UIImagePickerController()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            imagePicker.delegate = self
            
            //откуда загружаем картинку
            let alertController = UIAlertController(title: "Добавить фото", message: "", preferredStyle: .actionSheet)
            let actionCamera = UIAlertAction(title: "Камера", style: .default) { (action) in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                self.addPhotoLabel.text = ""
            }
            let actionPhotoLibrary = UIAlertAction(title: "Галерея", style: .default) { (action) in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
                self.addPhotoLabel.text = ""
            }
            let actionSavedPhotos = UIAlertAction(title: "Сохраненные фото", style: .default) { (action) in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
                self.addPhotoLabel.text = ""
            }
            let actionCancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
            
            alertController.addAction(actionCamera)
            alertController.addAction(actionPhotoLibrary)
            alertController.addAction(actionSavedPhotos)
            alertController.addAction(actionCancel)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

//MARK: - Extension UIImagePickerControllerDelegate
extension OneCardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //здесь лежит картинка
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Extension MFMailComposeViewControllerDelegate
extension OneCardController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extension UITextFieldDelegate
extension OneCardController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldName {
            self.textFieldPhone.becomeFirstResponder()
        } else if textField == textFieldPhone {
            self.textFieldEmail.becomeFirstResponder()
        } else {
            textFieldEmail.resignFirstResponder()
        }
        
        return true
    }
}
