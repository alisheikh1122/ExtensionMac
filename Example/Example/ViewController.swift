//
//  ViewController.swift
//  Example
//
//  Created by Ali Shahzad on 18/04/2025.
//

import Cocoa
import Foundation
import ExtensionMac

class ViewController: NSViewController {
    
    @IBOutlet weak var shimmerView : NSView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shimmerView.addShimmer()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
