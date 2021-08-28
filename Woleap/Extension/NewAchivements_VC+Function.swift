//  File.swift
//  Woleap

//  Created by iOS-Appentus on 24/July/2019.
//  Copyright © 2019 appentus. All rights reserved.


import Foundation
import UIKit
import AVKit
import MobileCoreServices


extension NewAchivementsViewController {
    @IBAction func switch_work_personal(_ sender:UISwitch) {
       
        
    }
    
    @IBAction func btn_upload_documents(_ sender:UIButton) {
        func_ChooseImage()
    }
    
    @IBAction func btn_save(_ sender:UIButton) {
     
        if is_from_long_gesture {
            if !func_validation() {
                return
            }
        }
        
       pop_single()
        
//
//        Model_New_Achievement.shared.title = TitleTxtFld.text!
//        Model_New_Achievement.shared.date = setDateLbl.text!
//        Model_New_Achievement.shared.category = str_category
//        Model_New_Achievement.shared.impact_rating = str_impact_rating
//        Model_New_Achievement.shared.difficulty_level = str_dificuilt_rating
//        Model_New_Achievement.shared.status = str_status
//        Model_New_Achievement.shared.operating_level = str_operating_level
//
//        Model_New_Achievement.shared.comment = txt_coment.text!
//        if txt_coment.text == "Add additional details..." {
//            Model_New_Achievement.shared.comment = ""
//        }
//
//        Model_New_Achievement.shared.archievement_skills.removeAll()
//        for model in arr_tech_skils {
//            Model_New_Achievement.shared.archievement_skills.append(model.name)
//        }
//
//        Model_New_Achievement.shared.archievement_business_benefits.removeAll()
//        for model in arr_business_skills {
//            Model_New_Achievement.shared.archievement_business_benefits.append(model.name)
//        }
//
//        if is_from_long_gesture {
//            func_create_archievement()
//        } else {
//            func_update_archievement()
//        }
        
    }
    
    
    
    func func_validation() -> Bool {
        var is_valid = false
        
        if TitleTxtFld.text!.isEmpty {
            func_ShowHud_Error(with: "Add your title")
            is_valid = false
        } else if setDateLbl.text == "SET DATE" {
            func_ShowHud_Error(with: "Set your date")
            is_valid = false
        } else if str_status.isEmpty {
            func_ShowHud_Error(with: "Select your status")
            is_valid = false
        } else if str_category.isEmpty {
            func_ShowHud_Error(with: "Select your category")
            is_valid = false
        } else if str_operating_level.isEmpty {
            func_ShowHud_Error(with: "Select your operating level")
            is_valid = false
        } else if str_impact_rating.isEmpty {
            func_ShowHud_Error(with: "Select your impact rating")
            is_valid = false
        } else if str_dificuilt_rating.isEmpty {
            func_ShowHud_Error(with: "Select your dificuilt rating")
            is_valid = false
        } else if str_dificuilt_rating.isEmpty {
            func_ShowHud_Error(with: "Select your dificuilt rating")
            is_valid = false
        } else {
            is_valid = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_HideHud()
        }
        
        return is_valid
    }
    
    @objc func func_get_archievement_data() {
        
    }
    
    
    
    @objc func func_get_archievement_by_id() {
        
    }
    
    
    
    @IBAction func btn_done_techPopUp(_ sender: UIButton) {
        techpopView.isHidden = true
        
      
        self.height_container_view.constant = 855+self.height_tech.constant+self.height_business.constant+400
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}



extension NewAchivementsViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func func_camera_permission(completion:@escaping (Bool)->()) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if !granted {
                DispatchQueue.main.async {
                    let alert = UIAlertController (title: "Woleap would like to access the camera", message: "Woleap needs Camera and PhotoLibrary to complete achievement,goals and list", preferredStyle: .alert)
                    let yes = UIAlertAction(title: "Don't allow", style: .default) { (yes) in
                        
                    }
                    
                    let no = UIAlertAction(title: "Allow", style: .default) { (yes) in
                        DispatchQueue.main.async {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    }
                    
                    alert.addAction(yes)
                    alert.addAction(no)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            completion(granted)
        }
    }
    
    func func_ChooseImage() {
        
        let alert = UIAlertController(title: "", message: "Please select!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenCamera()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenGallary()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Documents", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.clickFunction()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func func_OpenCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera))
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate=self
            
            func_camera_permission { (is_permission) in
                if is_permission {
                    DispatchQueue.main.async {
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
            }
        }
        else
        {
            let alert  = UIAlertController(title: "Warning!", message: "You don't have camera in simulator", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func func_OpenGallary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate=self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if #available(iOS 11.0, *) {
                lbl_attached_file_name.text = "Your attachment \(info[UIImagePickerController.InfoKey.referenceURL] ?? "URL is nil")"
            } else {
                lbl_attached_file_name.text = "Version Problem"
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func clickFunction() {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }

    
    
}



extension NewAchivementsViewController: UIDocumentMenuDelegate,UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
    }
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
}
