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

  @objc(showSettingsView:withResolver:withRejecter:)
  func showSettingsView(s: String, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
      
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
                reject("failed_initialization", "Failed to find UIViewController", nil)
                return
            }else {
                iZettleSDK.shared().presentSettings(from: controller!)
                group.leave()
                group.wait()
                resolve("Okay")
            }
        } catch let error {
            // Handle the error and signal that the function has completed
            reject("failed_initialization", "Failed to initialize", error)
            group.leave()
        }
      }
  }

}
