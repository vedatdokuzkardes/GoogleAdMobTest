//
//  ViewController.swift
//  GoogleAdMobTest
//
//  Created by Vedat Dokuzkardeş on 21.12.2023.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class ViewController: UIViewController, GADFullScreenContentDelegate {
    
    private var interstitial: GADInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        
        ATTrackingManager.requestTrackingAuthorization { status in
            
            GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )
            
            if status == .authorized{
                
            }else if status == .denied {
                
            }
        }
        
        //reel -> ca-app-pub-4737300523164437/4542329325
        
        //test -> ca-app-pub-3940256099942544/4411468910
    }

    @IBAction func NextBtn(_ sender: Any) {
        
        if interstitial != nil {
          interstitial!.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
        
        
    }
    /// Tells the delegate that the ad failed to present full screen content.
     func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
       print("Ad did fail to present full screen content.")
     }

     /// Tells the delegate that the ad will present full screen content.
     func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad will present full screen content.")
     }

     /// Tells the delegate that the ad dismissed full screen content.
     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did dismiss full screen content.")
     }
    
}

