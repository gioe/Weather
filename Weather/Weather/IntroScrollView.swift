//
//  IntroScrollView.swift
//  Weather
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class IntroScrollView: UIView {

    let numberOfScreens = 4
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            
            self.scrollView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
            let scrollViewWidth:CGFloat = self.scrollView.frame.width
            let scrollViewHeight:CGFloat = self.scrollView.frame.height
            
            for i in (0...numberOfScreens){
                let newWidth = scrollViewWidth * CGFloat(i)
                let screen = UIView(frame: CGRectMake(newWidth, 0, scrollViewWidth, scrollViewHeight))
                screen.backgroundColor = .blackColor()
                self.scrollView.addSubview(screen)
            }
            
            self.scrollView.contentSize = CGSizeMake(self.frame.width * CGFloat(numberOfScreens), self.frame.height)
            
        }
    }

    @IBOutlet weak var popupButton: UIButton! {
        didSet {
            self.popupButton.layer.cornerRadius = 4.0
        }
    }
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textAlignment = .Center
            textView.backgroundColor = .clearColor()
            textView.text = "Welcome! If you'd like a little explanation, go ahead and swipe on. If you just want to skip right to the setup, click the button below."
            textView.textColor = .redColor()
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.currentPage = 0
            pageControl.backgroundColor = .clearColor()
            pageControl.tintColor = .whiteColor()
        }
    }
    
    func updateTextForPage(currentPage : Int){
        switch currentPage {
        case 0:
            textView.text = "Welcome! If you'd like a little explanation, go ahead and swipe on. If you just want to skip right to the setup, click the button below."
        case 1:
            textView.text = "I forget my umbrella a lot. You would think I would learn to check the weather before I leave the house every day but the thing is, I forget to do that too."
        case 2:
            textView.text = "I built this app because I don't need to know much about the weather. I just need to know one simple thing every morning: will it rain today?"
        default:
            textView.text = "Select your locale and notification time, along with any important daily time frame and weather intensity if you'd like. Every day, we'll do the weather lookup for you and notify you so you're prepared."
        }
        
        pageControl.currentPage = currentPage
    }

}
