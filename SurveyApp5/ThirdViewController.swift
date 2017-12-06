//
//  ThirdViewController.swift
//  SurveyApp5
//
//  Created by Yufang Lin on 03/11/2017.
//  Copyright © 2017 Yufang Lin. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - UI Element
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Other Properties
    var survey: Survey?

    
    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Round the corners of the text view
        textView.layer.cornerRadius = 5.0
        
        // Set text view's delegate as the ThirdViewController
        textView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Text View Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // -- Function called when touches were detected (won't happen if textView was tapped) -- \\
        
        // Slide down keyboard and end editing of text view
        textView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // -- Function called when text view resigns the first responder -- \\
        
        // Optional Binding: in case no text been entered
        if let actualText = textView.text {
            // save the text to the survey object as the comments
            survey?.comments = actualText
        }
    }
}
