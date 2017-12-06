//
//  FirstViewController.swift
//  SurveyApp5
//
//  Created by Yufang Lin on 03/11/2017.
//  Copyright © 2017 Yufang Lin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    // MARK: - UI Elements
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactSwitch: UISwitch!
    
    
    // MARK: - Other Properties
    var survey: Survey?
    
    
    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set both text field's delegate as the FirstViewController
        nameTextField.delegate = self
        emailTextField.delegate = self
        
        // Optional Binding: in case "Back" was tapped in 2ndVC. Survey object not nil
        if let actualSurvey = survey {
            // Set both text field's text with the survey's name/email property
            nameTextField.text = actualSurvey.name
            emailTextField.text = actualSurvey.email
            
            // Set the on/off state of the contact switch
            contactSwitch.isOn = actualSurvey.contact
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Field Functions
    func textFieldDidEndEditing(_ textField: UITextField) {
        // -- Function called when text field resigns the first responder, ending the editing -- \\
        
        // Optional Binding: in case no text was entered
        if let actualText = textField.text {
            // Check which textfield was edited
            if textField == nameTextField {
                // Save the entered text to the survey as the name property
                survey?.name = actualText
            }
            else if textField == emailTextField {
                // Save the entered text to the survey as the email property
                survey?.email = actualText
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // -- Function called when "Return" key was tapped -- \\
        
        // Slide down keyboard and end editing on either textfields 
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        // Yes the textfield should have default behavior for the "Return" key
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // -- Function called when touches were detected -- \\
        
        // Slide down keyboard and end editing of either text fields
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    // MARK: - Switch Functions
    @IBAction func switchChanged(_ sender: UISwitch) {
        // -- Functions called when switch was tapped -- \\
        
        // Save the on/off state of the switch as the survey's contact property
        survey?.contact = sender.isOn
    }
}
