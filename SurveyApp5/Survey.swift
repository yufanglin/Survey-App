//
//  Survey.swift
//  SurveyApp5
//
//  Created by Yufang Lin on 03/11/2017.
//  Copyright © 2017 Yufang Lin. All rights reserved.
//

import UIKit

class Survey: NSObject {
    // First View Controller
    var name: String = ""
    var email: String = ""
    var contact: Bool = false
    
    // Second View Controller
    var location: String = ""
    var experience: Int = 0
    var decor: Int = 0
    var service: Int = 0
    var food: Int = 0
    var visitAgain: Bool = true
    var visitReason: String = ""
    var wontVisitReason: String = ""
    
    // Third View Controller
    var comments: String = ""
}
