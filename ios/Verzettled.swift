import iZettleSDK
import UIKit


@objc(Verzettled)
class Verzettled: NSObject {

  var wasInitialized:Bool = false

  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve(a*b)
  }

  @objc(say:withResolver:withRejecter:)
  func say(s: String, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve("I say: " + s)
  }

  @objc(initZettle:callbackURL:withResolver:withRejecter:)
  func initZettle(clientId: String, cbu: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
    
    if(self.wasInitialized){
      resolve("Already initialized")
      return
    }
    
    // Create a DispatchGroup
    let group = DispatchGroup()
    
    // Enter the DispatchGroup before calling the function
    group.enter()

    // Call the function on the main thread
    DispatchQueue.main.async {
        do {
            let authenticationProvider = try iZettleSDKAuthorization(clientID: clientId, callbackURL: URL(string: cbu)!)
            iZettleSDK.shared().start(with: authenticationProvider)
            
            // Signal that the function has completed
            group.leave()
            // Wait for the function to complete
            group.wait()
            self.wasInitialized = true
    
            resolve("Success")
        } catch let error {
            self.wasInitialized = false
            // Handle the error and signal that the function has completed
            reject("failed_initialization", "Failed to initialize", error)
            group.leave()
        }
    }
  }

  @objc(showSettingsView:rejecter:)
  func showSettingsView(resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
      if(!self.wasInitialized){
        reject("failed_showing_settings", "Not initialized", nil)
        return
      }
      
      let group = DispatchGroup()
      group.enter()

      DispatchQueue.main.async {
        do {
            let delegate = (UIApplication.shared as UIApplication).delegate
            let controller = (delegate?.window as? UIWindow)?.rootViewController as? UIViewController
            
            if(controller == nil){
                reject("failed_showing_settings", "Failed to find UIViewController", nil)
                return
            }else {
                iZettleSDK.shared().presentSettings(from: controller!)
                group.leave()
                group.wait()
                resolve("Okay")
            }
        } catch let error {
            // Handle the error and signal that the function has completed
            reject("failed_showing_settings", "Failed to show settings", error)
            group.leave()
        }
      }
  }

  @objc(charge:withResolver:withRejecter:)
  func charge(a: NSDecimalNumber, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
    if(!self.wasInitialized){
        reject("failed_showing_settings", "Not initialized", nil)
        return
      }
      
    let group = DispatchGroup()
    group.enter()

    DispatchQueue.main.async {
      do {
        let delegate = (UIApplication.shared as UIApplication).delegate
        let controller = (delegate?.window as? UIWindow)?.rootViewController as? UIViewController
        
          if #available(iOS 13.0, *) {
              if(controller == nil){
                reject("failed_charging", "Failed to find UIViewController", nil)
                return
              } else {
                  Task {
                  try (await iZettleSDK.shared().charge(amount: a, tippingStyle: IZSDKTippingStyle.none, reference: "myReference", presentFrom: controller!))
                  }
                group.leave()
                group.wait()
                resolve("Okay")
              }
          } else {
              reject("failed_charging", "Requires ios >= 13.0", nil)
              return
          }
      } catch let error {
          // Handle the error and signal that the function has completed
          reject("failed_charging", "Failed to charge", error)
          group.leave()
      }
    }
  }
                    /*
open func charge(amount: NSDecimalNumber,
  tippingStyle: IZSDKTippingStyle,
  reference: String?,
  presentFrom viewController: UIViewController,
  completion: @escaping iZettleSDK.iZettleSDKOperationCompletion) */

}
