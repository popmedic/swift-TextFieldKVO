//
//  ViewController.swift
//  TextFieldKVO
//
//  Created by Kevin Scardina on 7/12/18.
//  Copyright © 2018 Kevin Scardina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var textFieldHiddenContext = 0
    private var textFieldObservingView:UIView? = nil
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add the observer
        textField.addObserver(
            self,
            forKeyPath: "hidden",
            options: [.new],
            context: &self.textFieldHiddenContext
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
        if context == &self.textFieldHiddenContext {
            // get the new value that was set
            if let newValue = change?[NSKeyValueChangeKey.newKey] as? Bool {
                // do what needs to be done when the observer is triggered
                self.label.isHidden = newValue
            }
        }
    }
    
    deinit {
        // remove the observer
        if let view = self.textFieldObservingView {
            view.removeObserver(self, forKeyPath: "hidden")
            self.textFieldObservingView = nil
        }
    }
    
    @IBAction func showHideButtonAction(_ sender: Any) {
        self.textField.isHidden = !self.textField.isHidden
    }
}


