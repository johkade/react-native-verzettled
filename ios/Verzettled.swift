import iZettleSDK

@objc(Verzettled)
class Verzettled: NSObject {

  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve(a*b)
  }

  @objc(say:withResolver:withRejecter:)
  func say(s: String, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve("I say: " + s)
  }


  // @objc(initZettle:callbackURL:withResolver:withRejecter:)
  // func initZettle(clientId: String, cbu: String, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) -> Void {
      
  //     do {
  //         let authenticationProvider = try iZettleSDKAuthorization(clientID: clientId, callbackURL: URL(string: cbu)!)
  //         iZettleSDK.shared().start(with: authenticationProvider)
  //         resolve("Success")
  //     } catch let error {
  //         reject("failed_initialization", "Failed to initialize", error)
        
  //     }
  // }

  @objc(initZettle:callbackURL:withResolver:withRejecter:)
  func initZettle(clientId: String, cbu: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
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
    
            resolve("Success")
        } catch let error {
            // Handle the error and signal that the function has completed
            reject("failed_initialization", "Failed to initialize", error)
            group.leave()
        }
    }
    
    
}

}
