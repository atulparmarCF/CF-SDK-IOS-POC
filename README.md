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

Make sure `Embed & Sign` is chosen as Embed option.

Note:- As a part of manual integration you have to add following dependencies in your project.
* Alamofire: https://github.com/Alamofire/Alamofire.git
* ReactiveSwift: https://github.com/ReactiveCocoa/ReactiveSwift.git
* SwiftyJSON: https://github.com/SwiftyJSON/SwiftyJSON.git
