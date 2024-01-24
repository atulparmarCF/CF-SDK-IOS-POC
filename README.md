# CFSDK - IOS - POC

![Platform](https://img.shields.io/cocoapods/p/MiSnap.svg?color=darkgray)
![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen)

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

![Screenshot 2024-01-22 at 9 40 23 AM](https://github.com/atulparmarCF/CF-SDK-IOS-POC/assets/153191045/075723a1-f021-46d5-a899-9c7251d03471)


Note:- As a part of manual integration you have to add following dependencies in your project.
* Alamofire: https://github.com/Alamofire/Alamofire.git
* ReactiveSwift: https://github.com/ReactiveCocoa/ReactiveSwift.git
* SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON.git


# How to configure the CF SDK?


### See the full example of configuration CF SDK and integrate delegate methods of that.

```groovy
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
    
    func successfullyConfiguredCFSDK() {
        //The CF API has been configured successfully.
        print("The CF API has been configured successfully.")
    }
    
    func failedToConfigCFSDK(error: Error) {
        //The CF API configuration has failed.
        print("CF API configured Failed.....:: \(error.localizedDescription)")
    }
}
```
