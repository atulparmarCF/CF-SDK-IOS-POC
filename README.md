# CFSDK - IOS - POC

![Platform](https://img.shields.io/cocoapods/p/MiSnap.svg?color=darkgray)
![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen)

# Change Financial SDK POC Integration Guide
Change Financial SDK POC is a sample SDK in which it has predefined functions that provide the data from change financial's CMS.

# Table of Contents
[Integration Guides](#integration-guides)

[CF SDK configuration](#how-to-configure-the-cf-sdk)

[SDK Functions](#sdk-functions)
* [1. User Profile](#1-user-profile)
* [2. Get a list of customer cards.](#2-get-a-list-of-customer-cards)

- - - -
# Integration Guides

### Swift Package Manager

Add the following repository url:

`https://github.com/atulparmarCF/CF-SDK-IOS-POC.git`

Note:- Alamofire, ReactiveSwift, and SwiftyJSON will be added as project dependencies automatically.

### Manual integration
If you prefer not to use any of the aforementioned dependency managers, you can integrate Alamofire into your project manually.

From [Sources](../../../SDKs/Sources) copy:
* CFSDK.xcframework

Add all copied artifacts to your Xcode project under "Frameworks, Libraries, and Embedded Content". 

Make sure `Embed & Sign` is chosen as Embed option (See the below screenshot).

![Screenshot 2024-02-06 at 2 07 21 PM](https://github.com/atulparmarCF/CF-SDK-IOS-POC/assets/153191045/6dfcae6b-ef79-4543-94f5-ea1a862969f3)

Note:- As a part of manual integration you have to add following dependencies in your project.
* Alamofire: https://github.com/Alamofire/Alamofire.git
* ReactiveSwift: https://github.com/ReactiveCocoa/ReactiveSwift.git
* SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON.git

- - - -
# How to configure the CF SDK?

## CF SDK configuration steps.
1. Add necessary imports in view controller.
```Swift
import CFSDK
```

2. Configure SDK using `cardholderId` and setup environment
```Swift
var objCFSDK = CFSDKConfig()
objCFSDK.delegate = self   //Optional
objCFSDK.skdConfiguration(
             cardholderId: "Card holder ID String",
             environment: .envProd   //Optional (Default environment is production)
        )
```

3. Setup delegate methods (Optional),
Implement required callbacks to conform to `CFSDKConfigDelegate`
```Swift
    func cfSdkHandleConfigurationSuccess() {
        //Handle CF SDK configuration success.
    }
    
    func cfSdkHandleConfigurationFailure(error: Error) {
        //Handle CF SDK configuration failure.
        print("Error: ", error.localizedDescription)
    }

    // CF SDK Authorization methods are part of CF SDK configurations.
    //(This methods are optional, just let the user know authorization status while configuring SDK)

    func cfSdkHandleAuthorizationSuccess() {
        //Handle authorization success
    }
    
    func cfSdkHandleAuthorizationFailure(error: Error) {
        //Handle authorization failure
        print("Error: ", error.localizedDescription)
    }
```


### See the full example of configuration CF SDK and integrate delegate methods of that.

```Swift
import CFSDK

class ViewController: UIViewController, CFSDKConfigDelegate {

    //MARK: CF SDK Configuration.

    func setupCFSDKConfiguration() {

        var objCFSDK = CFSDKConfig()
        objCFSDK.delegate = self   //Optional
        objCFSDK.skdConfiguration(
            cardholderId: "Card holder ID String",
            environment: .envProd   //Optional (Default environment is production)
        )
    }
    
    //MARK: Delegate functions of CF SDK.
    func cfSdkHandleConfigurationSuccess() {
        //Handle CF SDK configuration success.
    }
    
    func cfSdkHandleConfigurationFailure(error: Error) {
        //Handle CF SDK configuration failure.
        print("Error: ", error.localizedDescription)
    }
}
```
- - - -
# SDK Functions

## 1. User Profile
To retrieve user profile details, it is necessary to invoke the `getUserProfile()` function as demonstrated below, As part of the result (response) you will get `UserProfileData` model.

```Swift
let signalProd = CFAPIManager.shared.getUserProfile()
signalProd.startWithResult { result in
  switch result {
  case .success(let response):
      // Handle API response
      print("API response: \(response)")
  case .failure(let error):
     // Handle errors
     print("Error: \(error.localizedDescription)")
  }
}
```

## 2. Get a list of customer cards.
Retrieves a list of all cards associated with the specified customer, it is necessary to invoke the `getCardAccountList()` function as demonstrated below. to invoke this function must pass the customer number as a string, As part of the result (response) you will get `AccountListData` model.

```Swift
let customerNo = "Customer Number String"
let signalProd = CFAPIManager.shared.getCardAccountList(customerNumber: customerNo)
signalProd.startWithResult { result in
  switch result {
  case .success(let response):
      // Handle API response
      print("API response: \(response)")
  case .failure(let error):
     // Handle errors
     print("Error: \(error.localizedDescription)")
  }
}
```
