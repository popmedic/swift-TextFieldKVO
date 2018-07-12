//
//  ViewController.swift
//  TextFieldKVO
//
//  Created by Kevin Scardina on 7/12/18.
//  Copyright © 2018 Kevin Scardina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var lastNameTextFieldHiddenContext = 0
    private var lastNameObservingView:UIView? = nil
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add the observer
        lastNameTextField.addObserver(
            self,
            forKeyPath: "hidden",
            options: [.new],
            context: &self.lastNameTextFieldHiddenContext
        )
    }
    
    /// function will be called whenever an added observer is triggered
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        // make sure it is our text field isHidden observer
        if context == &self.lastNameTextFieldHiddenContext {
            // get the new value that was set
            if let newValue = change?[NSKeyValueChangeKey.newKey] as? Bool {
                // do what needs to be done when the observer is triggered
                self.lastNameLabel.isHidden = newValue
            }
        }
    }
    
    deinit {
        // remove the observer
        if let view = lastNameObservingView {
            view.removeObserver(self, forKeyPath: "hidden")
            lastNameObservingView = nil
        }
    }
    
    @IBAction func showHideButtonAction(_ sender: Any) {
        self.lastNameTextField.isHidden = !self.lastNameTextField.isHidden
    }
}


