//
//  SecondViewController.swift
//  SurveyApp5
//
//  Created by Yufang Lin on 03/11/2017.
//  Copyright © 2017 Yufang Lin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - UI Elements
    // Slider UI Properties
    @IBOutlet weak var decorSlider: UISlider!
    @IBOutlet weak var decorLabel: UILabel!
    
    @IBOutlet weak var serviceSlider: UISlider!
    @IBOutlet weak var serviceLabel: UILabel!
    
    @IBOutlet weak var foodSlider: UISlider!
    @IBOutlet weak var foodLabel: UILabel!
    
    
    // Stepper UI Properties
    @IBOutlet weak var expStepper: UIStepper!
    @IBOutlet weak var expLabel: UILabel!
    
    // Switch UI Properties
    @IBOutlet weak var visitSwitch: UISwitch!
    
    // TextField UI Properties
    @IBOutlet weak var whyVisitTextField: UITextField!
    @IBOutlet weak var whyVisitLabel: UILabel!
    
    @IBOutlet weak var whyNotVisitTextField: UITextField!
    @IBOutlet weak var whyNotVisitLabel: UILabel!
    
    
    // Picker View UI Properties
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    
    
    // MARK: - Other Properties
    var locations = ["Beaverton", "Eugene", "Portland", "Salem"]
    var survey: Survey?
    
    
    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Round the corners of the experience stepper to hide the white background from peaking out of the lines
        expStepper.layer.cornerRadius = 5.0
        
        // Set the border and round the corners of the location button
        locationButton.layer.cornerRadius = 5.0
        locationButton.layer.borderWidth = 1.5
        locationButton.layer.borderColor = UIColor(red: 44/255, green: 96/255, blue: 69/255, alpha: 1.0).cgColor
        
        // Set the picker view's delegate/datasource as the SecondViewController
        locationPicker.delegate = self
        locationPicker.dataSource = self
        
        // Set both textfield delegates as the SecondViewController
        whyVisitTextField.delegate = self
        whyNotVisitTextField.delegate = self
        
        
        // Optional Binding: in case "Back" was tapped in the ThirdViewController. Survey not nil
        if let actualSurvey = survey {
            // Get the index of the location that was saved in the survey object
            let index = locations.index(of: actualSurvey.location)
            
            // Optional Binding: in case index not found
            if let actualIndex = index {
                // Set the location picker view to the row that matches the saved location
                locationPicker.selectRow(actualIndex, inComponent: 0, animated: false)
                
                // Set the location button title with the saved location
                locationButton.setTitle(locations[actualIndex], for: .normal)
            }
            
            // Set the experience stepper and it's rating label 
            expStepper.value = Double(actualSurvey.experience)
            expLabel.text = String(format: "Rating: %d", Int(actualSurvey.experience))
            
            // Set the decor slider and it's rating label
            decorSlider.value = Float(actualSurvey.decor)
            decorLabel.text = String(format: "Rating: %d", Int(actualSurvey.decor))
            
            // Set the service slider and it's service label
            serviceSlider.value = Float(actualSurvey.service)
            serviceLabel.text = String(format: "Rating: %d", Int(actualSurvey.service))
            
            // Set the food slider and it's food label
            foodSlider.value = Float(actualSurvey.food)
            foodLabel.text = String(format: "Rating: %d", Int(actualSurvey.food))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Location Functions
    @IBAction func chooseLocationTapped(_ sender: UIButton) {
        // -- Function called when the location button was tapped -- \\
        
        // Make sure the current layout is up-to-date
        view.layoutIfNeeded()
        
        // Animate: "Opening" the location picker view
        UIView.animate(withDuration: 0.25, animations: { 
            // Set the height of the picker view so it would be visible
            self.pickerHeight.constant = 216
            
            // Update layout changes immediately
            self.view.layoutIfNeeded()
        }) { (Bool) in
            // Animate: Completion upon showing picker view
            UIView.animate(withDuration: 0.25, animations: { 
                // Show the picker view 
                self.locationPicker.alpha = 1
                
                // Update the layout changes immediately
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Return the number of columns in the picker view
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Return the number of rows in the picker view, in this case, location count
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // -- Function returns a white colored location title for each row in the picker view -- \\
        
        // Create an attributed string that is white and set to a location at the row index
        let attrString = NSAttributedString(string: locations[row], attributes: [NSForegroundColorAttributeName:UIColor.white])
        
        // Return the attributed string as the title for the row 
        return attrString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // -- Function called when user selects a row in the picker view -- \\
        
        // Update button title with the select row title
        locationButton.setTitle(locations[row], for: .normal)
        
        // Save the selected row as the location to the survey object
        survey?.location = locations[row]
        
        // Make sure the layout is up-to-date
        view.layoutIfNeeded()
        
        // Animate: "Closing" the location picker view
        UIView.animate(withDuration: 0.25, animations: { 
            // Fade out the picker view
            self.locationPicker.alpha = 0
            
            // Update layout changes immediately
            self.view.layoutIfNeeded()
        }) { (Bool) in
            // Animate: Completion upon shrinking the picker view's height
            UIView.animate(withDuration: 0.25, animations: { 
                // Set the location picker view's height
                self.pickerHeight.constant = 0
                
                // Update layout changes immediately
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Stepper's Function
    @IBAction func stepperChanged(_ sender: UIStepper) {
        // -- Function called when stepper UI was tapped -- \\
        
        // Update the experience rating label with the stepper value
        expLabel.text = String(format: "Rating: %d", Int(sender.value))
        
        // Save the slider's value as the survey's experience rating
        survey?.experience = Int(sender.value)
    }
    
    
   // MARK: - Sliders' Function
    @IBAction func sliderChanged(_ sender: UISlider) {
        // -- Function called when slider (Decor, Service, Food) been changed -- \\
        
        // Increment notches into the slider
        sender.value = Float(Int(sender.value))
        
        // Check which slider been edited
        if sender == decorSlider {
            // Update decor label with the slider value
            decorLabel.text = String(format: "Rating: %d", Int(sender.value))
            
            // Save service rating to survey object
            survey?.decor = Int(sender.value)
        }
        else if sender == serviceSlider {
            // Update the service label with the slider value
            serviceLabel.text = String(format: "Rating: %d", Int(sender.value))
            
            // Save the service rating to the survey object
            survey?.service = Int(sender.value)
        }
        else if sender == foodSlider {
            // Update the food label with the slider value
            foodLabel.text = String(format: "Rating: %d", Int(sender.value))
            
            // Save the food rating to the survey object
            survey?.food = Int(sender.value)
        }
    }
    
    // MARK: - Switch Function
    @IBAction func visitSwitchChanged(_ sender: UISwitch) {
        // -- Function called when the visit again switch was changed -- \\
        
        // Save the on/off state of the switch
        survey?.visitAgain = sender.isOn
        
        // Check switch's on/off state to set textField states
        if sender.isOn {
            // erase any text in the why not text field and remove data from survey object
            whyNotVisitTextField.text = ""
            survey?.wontVisitReason = ""
            
            // User will visit again, disable why not text field and label
            whyNotVisitTextField.isEnabled = false
            self.whyNotVisitTextField.resignFirstResponder()
            whyNotVisitLabel.isEnabled = false
            
            // enable the why visit text field and label
            whyVisitLabel.isEnabled = true
            whyVisitTextField.isEnabled = true
            // put focus onto the reason to visit text field
            self.whyVisitTextField.becomeFirstResponder()
        }else {
            // erase any tex in the why visit text field and remove data from the survey object
            whyVisitTextField.text = ""
            survey?.visitReason = ""
            
            // User will not visit again, disable situation to visit text field and label
            whyVisitTextField.isEnabled = false
            self.whyVisitTextField.resignFirstResponder()
            whyVisitLabel.isEnabled = false
            
            // enable the reason not to visit text field and label
            whyNotVisitLabel.isEnabled = true
            whyNotVisitTextField.isEnabled = true
            // put focus onto the reason NOT to visit text field
            self.whyNotVisitTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - Textfield Functions
    func textFieldDidEndEditing(_ textField: UITextField) {
        // -- Called when textfield resigns the first responder -- \\
        
        // Optional Binding: in case no text been entered
        if let actualText = textField.text {
            // Check which text field been edited
            if textField == whyVisitTextField {
                // save the entered text to the survey object
                survey?.visitReason = actualText
            }
            else if textField == whyNotVisitTextField {
                // Save the entered text to the survey objext
                survey?.wontVisitReason = actualText
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // -- Called when return key was tapped while editing text field -- \\
        
        // dismiss keyboard and end editing on either text fields
        whyVisitTextField.resignFirstResponder()
        whyNotVisitTextField.resignFirstResponder()
        
        // Yes, text field should have default behavior for the return key
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // -- Function called when touch detected -- \\
        
        // dismiss keyboard and end editing on either text fields
        whyVisitTextField.resignFirstResponder()
        whyNotVisitTextField.resignFirstResponder()
    }
}
