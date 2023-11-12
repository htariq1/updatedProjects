//
//  BoardView.swift
//  Created by Hassan Tariq on 4/4/20.
//  Copyright © 2020 Hassan Tariq. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    //Calculates the frame of a buttontile based on the view of the specific iOS device.
    func buttonFrame(row: Int, col: Int) -> CGRect {
        let width = self.frame.width/4
        let height =  self.frame.height/4
        return CGRect(x: CGFloat(col) * width + 2, y: CGFloat(row) * height + 2, width: width - 4, height: height - 4)
    }
    
    //Drawing the background or board for the tiles based on size of view on device
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x:1, y: 1))
        path.addLine(to: CGPoint(x: 1, y: self.frame.height - 1))
        path.addLine(to: CGPoint(x: self.frame.width - 1, y: self.frame.height - 1))
        path.addLine(to: CGPoint(x: self.frame.width - 1, y: 1))
        path.addLine(to: CGPoint(x: 1, y: 1))
        path.move(to: CGPoint(x: self.frame.width/4, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width/4, y: self.frame.height))
        path.move(to: CGPoint(x: self.frame.width/2, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
        path.move(to: CGPoint(x: self.frame.width * (3/4), y: 0))
        path.addLine(to: CGPoint(x: self.frame.width * (3/4), y: self.frame.height))
        path.move(to: CGPoint(x: 0, y: self.frame.height/4))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height/4))
        path.move(to: CGPoint(x: 0, y: self.frame.height/2))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height/2))
        path.move(to: CGPoint(x: 0, y: self.frame.height * (3/4)))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height * (3/4)))
        UIColor.darkGray.setStroke()
        path.lineWidth = 3
        path.stroke()
        path.close()
    }
    
    
    
    //laying down the buttontiles on top of the board with appropriate colors (font and background) and animations
    override func layoutSubviews() {
        
        for view in self.subviews {
            let tile = view as? ButtonTile
            
            if tile!.isNew == true {
                tile!.layer.opacity = 0.0
                UIView.animate(withDuration: 0.25, animations: {tile!.layer.opacity = 1.0})
                tile!.frame = buttonFrame(row: tile!.tile.row, col: tile!.tile.col)
                tile!.isNew = false
            } else {
                UIView.animate(withDuration: 0.25, animations: {tile!.frame = self.buttonFrame(row: tile!.tile.row, col: tile!.tile.col)})
            }
            
            if tile!.should_remove == true {
                UIView.animate(withDuration: 0.25, animations: {tile!.layer.opacity = 0.0}, completion: {finished in view.removeFromSuperview()})
            } else if tile!.tile.val == 1 {
                tile!.layer.backgroundColor = CGColor(srgbRed: 0/255, green: 193/255, blue: 255/255, alpha: 1.0)
                tile!.setTitle(String(tile!.tile.val), for: UIControl.State.normal)
                tile!.setTitleColor(UIColor.white, for: UIControl.State.normal)
            } else if tile!.tile.val == 2 {
                tile!.layer.backgroundColor = CGColor(srgbRed: 255/255, green: 28/255, blue: 141/255, alpha: 1.0)
                tile!.setTitle(String(tile!.tile.val), for: UIControl.State.normal)
                tile!.setTitleColor(UIColor.white, for: UIControl.State.normal)
            } else {
                tile!.layer.backgroundColor = UIColor.white.cgColor
                tile!.setTitle(String(tile!.tile.val), for: UIControl.State.normal)
                tile!.setTitleColor(UIColor.black, for: UIControl.State.normal)
            }
        }
    }
    
}
