//
//  AboutController.swift
//  Created by Hassan Tariq on 4/5/20.
//  Copyright © 2020 Hassan Tariq. All rights reserved.
//

import UIKit

class AboutController: UIView {
    
    override func draw(_ rect: CGRect) {
        
        
        
        let path = UIBezierPath()
        path.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 25, y: frame.height/2 - 25, width: 50, height: 50), cornerRadius: 25))
        UIColor.yellow.setFill()
        path.fill()
        path.close()
        
        let path2 = UIBezierPath()
        path2.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 50, y: frame.height/2 - 50, width: 100, height: 100), cornerRadius: 50))
        path2.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 75, y: frame.height/2 - 75, width: 150, height: 150), cornerRadius: 50))
        path2.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 100, y: frame.height/2 - 100, width: 200, height: 200), cornerRadius: 100))
        UIColor.black.setStroke()
        path2.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 125, y: frame.height/2 - 125, width: 250, height: 250), cornerRadius: 100))
        UIColor.black.setStroke()
        path2.stroke()
        path2.close()
        
        
        let path3 = UIBezierPath()
        path3.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 150, y: frame.height/2 - 150, width: 300, height: 300), cornerRadius: 150))
        path3.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 175, y: frame.height/2 - 175, width: 350, height: 350), cornerRadius: 350/2))
        path3.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 200, y: frame.height/2 - 200, width: 400, height: 400), cornerRadius: 200))
        UIColor.black.setStroke()
        path3.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 225, y: frame.height/2 - 225, width: 450, height: 450), cornerRadius: 450/2))
        UIColor.white.setStroke()
        path3.lineWidth = 8
        let  dashes: [ CGFloat ] = [ 0.0, 10.0 ]
        path3.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path3.stroke()
        path3.close()
        
        
        let path5 = UIBezierPath()
        path5.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 40, y: frame.height/2 - 50, width: 20, height: 20), cornerRadius: 25))
        UIColor.darkGray.setFill()
        path5.fill()
        path5.close()
        
        let path6 = UIBezierPath()
        path6.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 65, y: frame.height/2 - 65, width: 25, height: 25), cornerRadius: 25))
        UIColor.orange.setFill()
        path6.fill()
        path6.close()
        
        let path7 = UIBezierPath()
        path7.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 80, y: frame.height/2 - 90, width: 27, height: 27), cornerRadius: 25))
        UIColor.blue.setFill()
        path7.fill()
        path7.close()
        
        let path8 = UIBezierPath()
        path8.append(UIBezierPath(roundedRect: CGRect(x: frame.width/2 - 100, y: frame.height/2 - 100, width: 22, height: 22), cornerRadius: 25))
        UIColor.red.setFill()
        path8.fill()
        path8.close()
        
    }
    
    override func layoutSubviews() {
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
