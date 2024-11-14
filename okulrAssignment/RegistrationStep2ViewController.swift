import UIKit
import PhotosUI

class RegistrationStep2ViewController: UIViewController, UITextViewDelegate, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var uploadPicturesButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var pinCode: String = ""
    var bioText: String = ""
    var selectedImages: [UIImage] = []
    
    let placeholderText = "Write about yourself here within 350 characters"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = "Hi \(firstName), this is the final step for registration"
        bioTextView.layer.borderColor = UIColor.gray.cgColor
        bioTextView.layer.borderWidth = 1.0
        bioTextView.layer.cornerRadius = 8
        bioTextView.delegate = self
        bioTextView.text = placeholderText
        bioTextView.textColor = .lightGray
    }
    
    // MARK: - Upload Pictures
    @IBAction func uploadPicturesTapped(_ sender: UIButton) {
        if selectedImages.count >= 5 {
            showAlert(message: "You have already selected 5 pictures.")
            return
        }
        presentPHPicker()
    }
    
    func presentPHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 5 - selectedImages.count // Allow up to 5 images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard !results.isEmpty else { return }
        
        let dispatchGroup = DispatchGroup()
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                dispatchGroup.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let uiImage = image as? UIImage {
                        self?.selectedImages.append(uiImage)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if self.selectedImages.count >= 5 {
                self.showAlert(message: "You have selected 5 images.")
            }
        }
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        } else {
            bioText = textView.text
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 350 {
            textView.text = String(textView.text.prefix(350))
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - Navigation
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if selectedImages.count < 5 {
            showAlert(message: "Please upload at least 5 pictures.")
            return
        }
        navigateToProfileScreen()
    }
    
    func navigateToProfileScreen() {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.firstName = firstName
        profileVC.lastName = lastName
        profileVC.phoneNumber = phoneNumber
        profileVC.pinCode = pinCode
        profileVC.bioText = bioText
        profileVC.selectedImages = selectedImages
        navigationController?.pushViewController(profileVC, animated: true)
        print(selectedImages.count)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
