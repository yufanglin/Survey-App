//
//  FourthViewController.swift
//  SurveyApp5
//
//  Created by Yufang Lin on 03/11/2017.
//  Copyright © 2017 Yufang Lin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FourthViewController: UIViewController {
    
    // MARK: - Properties
    var survey: Survey?
    var ref: DatabaseReference?
    
    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Optional Binding: in case survey object not sent to FourthViewController
        if let actualSurvey = survey {
            // Get the dictionary version of the Survey object
            let surveyDict = getSurveyDict(from: actualSurvey)
            
            // Sent the survey to online database Firebase
            ref?.child("Survey5").childByAutoId().setValue(surveyDict)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getSurveyDict(from actualSurvey:Survey) -> [String:Any]{
        // Create an empty dictionary for the survey object
        var dict = [String:Any]()
        
        // Populate dictionary with survey objects
        dict["name"] = actualSurvey.name
        dict["email"] = actualSurvey.email
        dict["contact"] = actualSurvey.contact
        
        dict["location"] = actualSurvey.location
        dict["experience"] = actualSurvey.experience
        dict["decor"] = actualSurvey.decor
        dict["service"] = actualSurvey.decor
        dict["food"] = actualSurvey.food
        dict["visitAgain"] = actualSurvey.visitAgain
        dict["visitReason"] = actualSurvey.visitReason
        dict["wontVisitReason"] = actualSurvey.wontVisitReason
        
        dict["comments"] = actualSurvey.comments
        
        // Return the dictionary version of the survey object
        return dict
    }
}
