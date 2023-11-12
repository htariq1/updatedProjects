//
//  AboutControllerViewController.swift
//  Created by Hassan Tariq on 4/4/20.
//  Copyright © 2020 Hassan Tariq. All rights reserved.
//

import UIKit

class AboutControllerViewController: UIViewController {

    @IBOutlet weak var spaceOutlet: AboutController!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var byLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        byLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        byLabel.frame.origin = CGPoint(x: BackView.frame.width - 40, y: BackView.frame.height - 260)
    }
    
}
