//
//  ProfileViewController.swift
//  okulrAssignment
//
//  Created by Sree Lakshman on 14/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var locateMeButton: UIButton!
    @IBOutlet weak var showPhotos: UIButton!
    @IBOutlet weak var showVideos: UIButton!
    
    
    
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var pinCode: String = ""
    var bioText: String = ""
    var selectedImages: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pinCode)
        self.bioLabel.text = bioText
        self.nameLabel.text = "\(firstName) \(lastName)"
        self.profileImage.image = selectedImages.first
        self.profileImage.layer.cornerRadius = 40
        self.profileImage.clipsToBounds = true
        self.profileImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func showLocation(_ sender: Any) {
        self.showLocateMeView()
    }
    
    func showLocateMeView() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocateMeViewController") as! LocateMeViewController
        vc.pinCode = pinCode
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showPhotos(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        vc.selectedImages = selectedImages
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
