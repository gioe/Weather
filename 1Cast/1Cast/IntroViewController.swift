//
//  IntroViewController.swift
//  Weather
//
//  Created by Matt Gioe on 6/9/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import PopupController

class IntroViewController: UIViewController, UIScrollViewDelegate {

    var popView = PopupView()
    var currentUser = User()
    @IBOutlet weak var baseView: IntroScrollView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.scrollView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the text accordingly
        self.baseView.updateTextForPage(Int(currentPage))
        
    }

    @IBAction func throwPop(sender: AnyObject) {
        let popup = PopupController
            .create(self)
            .customize(
                [
                    .Layout(.Center),
                    .Animation(.FadeIn),
                    .BackgroundStyle(.BlackFilter(alpha: 0.8)),
                    .DismissWhenTaps(true),
                ]
            )
            .didShowHandler { popup in
                print("showed popup!")
            }
            .didCloseHandler { popup in
                print("closed popup!")
        }
        
        let container = PopupView.instance()
        container.closeHandler = { bool in
            if bool {
                self.performSegueWithIdentifier(Constants.SetupSegueIdentifier, sender: nil)
                self.currentUser.loginStatus = .NotPastSetup
            }
            
            popup.dismiss()
        }

        popup.show(container)
    }
    
}

