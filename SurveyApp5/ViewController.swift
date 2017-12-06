//
//  ViewController.swift
//  SurveyApp5
//
//  Created by Yufang Lin on 02/11/2017.
//  Copyright © 2017 Yufang Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // MARK: - Other Properties
    var survey = Survey()
    var pageIndex = 1
    var currentVC: UIViewController?

    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- Set the Back Button -- \\
        backButton.layer.cornerRadius = 5.0
        backButton.layer.borderWidth = 1.5
        backButton.layer.borderColor = UIColor(red: 44/255, green: 96/255, blue: 69/255, alpha: 1.0).cgColor
        
        // -- Set the Next Button -- \\
        nextButton.layer.cornerRadius = 5.0
        nextButton.layer.borderWidth = 1.5
        nextButton.layer.borderColor = UIColor(red: 44/255, green: 96/255, blue: 69/255, alpha: 1.0).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Button Functions
    @IBAction func nextTapped(_ sender: UIButton) {
        // -- Function called when next tapped -- \\
        
        // Switch-case on page index
        switch pageIndex {
        case 1:
            // Get the next (2nd) VC from storyboard
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
            
            // Optional Binding: in case current/next VC not found
            if let fromVC = currentVC, let toVC = nextVC {
                // Send survey object to SecondViewController
                (toVC as! SecondViewController).survey = survey
                
                // Transition to the SecondViewController
                switchChildVC(from: fromVC, to: toVC)
                
                // Increment page index
                pageIndex += 1
                
                // Set navigation bars
                setNav()
            }
            break
            
        case 2:
            // Get the next (3rd) VC from storyboard
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "ThirdVC")
            
            // Optional Binding: in case current/next VC not found
            if let fromVC = currentVC, let toVC = nextVC {
                // Send survey object to ThirdViewController
                (toVC as! ThirdViewController).survey = survey
                
                // Transition to the ThirdViewController
                switchChildVC(from: fromVC, to: toVC)
                
                // Increment page index
                pageIndex += 1
                
                // Set navigation bars
                setNav()
            }
            break
            
        case 3:
            // Get the next (4th) VC from storyboard
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "FourthVC")
            
            // Optional Binding: in case current/next VC not found
            if let fromVC = currentVC, let toVC = nextVC {
                // Send survey object to FourthViewController
                (toVC as! FourthViewController).survey = survey
                
                // Transition to the SecondViewController
                switchChildVC(from: fromVC, to: toVC)
                
                // Increment page index
                pageIndex += 1
                
                // Set navigation bars
                setNav()
            }
            break
            
        default:
            break
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        // -- Function called when back tapped -- \\
        
        // Switch-case on page index
        switch pageIndex {
        case 2:
            // Get previous (1stVC) VC from storyboard
            let prevVC = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
            
            // Optional Binding: in case current/previous VC not found
            if let fromVC = currentVC, let toVC = prevVC {
                // Send the survey object to FirstViewController
                (toVC as! FirstViewController).survey = survey
                
                // Transition from current to previous VC
                switchChildVC(from: fromVC, to: toVC)
                
                // decrement page index
                pageIndex -= 1
                
                // Set the navigation bars
                setNav()
            }
            break
            
        case 3:
            // Get previous (2nd) VC from storyboard
            let prevVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
            
            // Optional Binding: in case current/previous VC not found
            if let fromVC = currentVC, let toVC = prevVC {
                // Send the survey object to SecondViewController
                (toVC as! SecondViewController).survey = survey
                
                // Transition from current to previous VC
                switchChildVC(from: fromVC, to: toVC)
                
                // decrement page index
                pageIndex -= 1
                
                // Set the navigation bars
                setNav()
            }
            break
            
        default:
            break
        }
    }
    
    func setNav() {
        // -- Function called to set progress label and button status -- \\
        
        // Set progress label
        progressLabel.text = String(format: "Step %d of 3", pageIndex)
        
        // Switch-case on page index
        switch pageIndex {
        case 1:
            // Hide Back Button. Show Next Button
            backButton.alpha = 0
            nextButton.alpha = 1
            
            // Set Next Button title: Next
            nextButton.setTitle("Next", for: .normal)
            
            // Show progress label
            progressLabel.alpha = 1
            
            break
            
        case 2:
            // Show Back/Next Button
            backButton.alpha = 1
            nextButton.alpha = 1
            
            // Set Next Button title: Next
            nextButton.setTitle("Next", for: .normal)
            
            // Show progress label
            progressLabel.alpha = 1
            
            break
            
        case 3:
            // Show Back/Next Button
            backButton.alpha = 1
            nextButton.alpha = 1
            
            // Set Next Button title: Submit
            nextButton.setTitle("Submit", for: .normal)
            
            // Show progress label
            progressLabel.alpha = 1
            
            break
            
        case 4:
            // Hide Back/Next Button
            backButton.alpha = 0
            nextButton.alpha = 0
            
            // Hide progress label
            progressLabel.alpha = 0
            
            break
            
        default:
            break
        }
    }
    
    // MARK: - Navigation Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // -- Function called to prepare embedded segue in container view -- \\
        
        // Save the destination (FirstViewController) of the embedded segue as the current VC
        currentVC = segue.destination
        
        // Send FirstViewController the survey object
        (segue.destination as! FirstViewController).survey = survey
    }
    
    func switchChildVC(from fromVC:UIViewController, to toVC:UIViewController) {
        // -- Function called to transition between two View Controllers -- \\
        
        // Tell the current VC to transition to nil, because we are removing it
        fromVC.willMove(toParentViewController: nil)
        
        // Add a new child VC to the parent VC
        self.addChildViewController(toVC)
        
        // Add the new VC's view to the container View to be displayed
        containerView.addSubview(toVC.view)
        
        // Set the new VC's view frame to match the container view's bounds
        toVC.view.frame = containerView.bounds
        
        // Prepare animation: hide the new VC
        toVC.view.alpha = 0
        
        // Animate: Transition between the current/new VC
        UIView.animate(withDuration: 0.5, animations: { 
            // Fade in the new VC
            toVC.view.alpha = 1
            
            // Fade out the current VC
            fromVC.view.alpha = 0
            
        }) { (Bool) in
            // removing current VC's view from the container view
            fromVC.view.removeFromSuperview()
            
            // remove the current VC object from its Parent VC
            fromVC.removeFromParentViewController()
            
            // Tell the new VC that it transitioned 
            toVC.didMove(toParentViewController: self)
            
            // Keep track of the new VC as the current VC
            self.currentVC = toVC
        }
    }
}

