//
//  ViewController.swift
//  CFSDK_Demo
//
//  Created by Atul Parmar on 22/01/24.
//

import UIKit
import CFSDK

class ViewController: UIViewController, CFSDKConfigDelegate {

    @IBOutlet weak var cardholderIdTextField: UITextField!
    @IBOutlet weak var configureCFSDKButton: UIButton!
    @IBOutlet weak var resultOfAuthorizationLabel: UILabel!
    @IBOutlet weak var resultCFSDKLabel: UILabel!
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var cardListButton: UIButton!
    @IBOutlet weak var apiResultTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var customerNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupIndicator()
        // Do any additional setup after loading the view.
        self.cardholderIdTextField.text = "9cf152e0-6c7b-462e-b78d-5ee4d37e566a"
        self.configureCFSDKButton.isEnabled = false
        self.userProfileButton.isEnabled = false
        self.cardListButton.isEnabled = false
    }
    
    func setupIndicator() {
        // Initialize activity indicator
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
    }
    
    // Function to show the activity indicator
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    // Function to hide the activity indicator
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    //MARK: CF SDK Configuration.
    
    func setupCFSDKConfiguration() {
        self.showActivityIndicator()
        var objCFSDK = CFSDKConfig()
        objCFSDK.delegate = self   //Optional
        objCFSDK.skdConfiguration(cardholderId: self.cardholderIdTextField.text ?? "")
    }
    
    //MARK: Delegate functions of CF SDK.
    
    func cfSdkHandleConfigurationSuccess() {
        self.hideActivityIndicator()
        //Handle CF SDK configuration success.
        self.resultCFSDKLabel.textColor = .green
        self.resultCFSDKLabel.text = "The CF SDK configuration success"
        self.userProfileButton.isEnabled = true
    }
    
    func cfSdkHandleConfigurationFailure(error: Error) {
        self.hideActivityIndicator()
        //Handle CF SDK configuration failure.
        print("Error: ", error.localizedDescription)
        self.resultCFSDKLabel.textColor = .red
        self.resultCFSDKLabel.text = error.localizedDescription
        self.userProfileButton.isEnabled = false
    }
    
    func cfSdkHandleAuthorizationSuccess() {
        self.hideActivityIndicator()
        //Handle authorization success
        self.resultOfAuthorizationLabel.textColor = .green
        self.resultOfAuthorizationLabel.text = "The CF SDK authorization success"
        self.configureCFSDKButton.isEnabled = true
    }
    
    func cfSdkHandleAuthorizationFailure(error: Error) {
        self.hideActivityIndicator()
        //Handle authorization failure
        print("Error: ", error.localizedDescription)
        self.resultOfAuthorizationLabel.textColor = .red
        self.resultOfAuthorizationLabel.text = error.localizedDescription
        self.configureCFSDKButton.isEnabled = false
    }
    
    //MARK: UIButton Tapped events.
    
    @IBAction func authorizeButtonTapped(_ sender: UIButton) {
        self.resultOfAuthorizationLabel.text = ""
        self.resultCFSDKLabel.text = ""
        self.setupCFSDKConfiguration()
    }
    
    @IBAction func configureCFSDKButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func getUserProfileButtonTapped(_ sender: UIButton) {
        let signalProd = CFAPIManager.shared.getUserProfile()
        
        self.showActivityIndicator()
        signalProd.startWithResult { result in
            self.hideActivityIndicator()
            switch result {
            case .success(let response):
                // Handle API response
                let resultDictionary = self.toDictionary(response)
//                let resultJsonString = self.toJSONString(dictionary: resultDictionary)
                print("API response: \(resultDictionary)")
                self.apiResultTextView.text = "\(resultDictionary))"
                self.customerNumber = response.customerNumber ?? ""
                self.cardListButton.isEnabled = true
            case .failure(let error):
                // Handle errors
                print("Error: \(error)")
                self.apiResultTextView.text = error.localizedDescription
                self.cardListButton.isEnabled = false
            }
        }
    }
    
    @IBAction func getCardListButtonTapped(_ sender: UIButton) {
        let customerNo = self.customerNumber
        let signalProd = CFAPIManager.shared.getCardAccountList(customerNumber: customerNo)
        print("signalProd :: ", signalProd)
        
        self.showActivityIndicator()
        signalProd.startWithResult { result in
            self.hideActivityIndicator()
            switch result {
            case .success(let response):
                // Handle API response
                print("API response: \(self.toDictionary(response) )")
                self.apiResultTextView.text =  self.customerNumber + "   " + "\(self.toDictionary(response))"
            case .failure(let error):
                // Handle errors
                print("Error: \(error)")
                self.apiResultTextView.text = error.localizedDescription
            }
        }
    }
    
}

extension ViewController {
    
    func toDictionary<T>(_ value: T) -> [String: Any] {
        let mirror = Mirror(reflecting: value)
        var dictionary = [String: Any]()
        for child in mirror.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }
        return dictionary
    }
    
    func convertDictionaryToJsonString(dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to JSON string: \(error.localizedDescription)")
        }
        return nil
    }
    
//    func toJSONString<T>(_ value: T) throws -> String where T: Encodable {
//        let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
//        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
//            throw NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert to JSON string"])
//        }
//        return jsonString
//    }
    
//    func toJSONString(dictionary: [String: Any]) -> String? {
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
//            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
//                return nil
//            }
//            return jsonString
//        } catch {
//            return nil
//        }
//    }
    
    func toJSONString(dictionary: [String: Any]) -> String? {
        do {
            var jsonObject = [String: Any]()
            for (key, value) in dictionary {
                if let value = value as? AnyHashable {
                    jsonObject[key] = value
                } else if let value = value as? AnyHashable? {
                    jsonObject[key] = value ?? NSNull()
                } else {
                    jsonObject[key] = NSNull()
                }
            }
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return nil
            }
            return jsonString
        } catch {
            return nil
        }
    }
}
