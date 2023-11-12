//
//  ViewController.swift
//  Created by Hassan Tariq on 3/20/20.
//  Copyright © 2020 Hassan Tariq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Triples()
    var rngBool = true
    var tileMap = [Int:ButtonTile]()
    let defaults = UserDefaults.standard
    var highscores = [String]()
    
    @IBOutlet weak var BoardView: BoardView!
    @IBOutlet weak var NewGameOutlet: UIButton!
    @IBOutlet weak var upOutlet: UIButton!
    @IBOutlet weak var downOutlet: UIButton!
    @IBOutlet weak var leftOutlet: UIButton!
    @IBOutlet weak var rightOutlet: UIButton!
    @IBOutlet weak var randomOutlet: UISegmentedControl!
    @IBOutlet weak var scoreOutlet: UILabel!
    
    //Creates a new game by removing old tiles and spawning four new ones
    @IBAction func NewGameAction(_ sender: UIButton) {
        for view in BoardView.subviews {
            view.removeFromSuperview()
        }
        tileMap.removeAll()
        game.newgame(rand: rngBool)
        game.spawn()
        game.spawn()
        game.spawn()
        game.spawn()
        updateViewFromGame()
        
    }
    
    //Code that is ran when user presses left button or swipes left. It checks if the game is over and if it is then displays appropriate alerts. Otherwise it updates the scores and tiles appropriately.
    @IBAction func leftAction(_ sender: UIButton) {
        let moved = game.collapse(dir: .left)
        if moved {
            game.spawn()
        }
        updateViewFromGame()
        
        if game.isDone() == true {
            let savedhighscores = defaults.object(forKey: "HiScore") as? [String] ?? [String]()
            highscores = savedhighscores
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            highscores.append("\(game.score) \(dateFormatter.string(from: date))")
            let sorted = highscores.sorted {$0.localizedStandardCompare($1) == .orderedDescending}
            defaults.set(sorted, forKey: "HiScore")
            
            let alert = UIAlertController(
                title: "Game Over",
                message: "\(game.score) points",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "Bummer", style: .default,
                handler: nil ))
            
            present(alert, animated: true,
                    completion: {self.BoardView.layoutSubviews()})
            tabBarController?.selectedIndex = 1
        }
        
    }
    
    //Code that is ran when user presses up button or swipes up. It checks if the game is over and if it is then displays appropriate alerts. Otherwise it updates the scores and tiles appropriately.
    @IBAction func upAction(_ sender: UIButton) {
        let moved = game.collapse(dir: .up)
        if moved {
            game.spawn()
        }
        updateViewFromGame()
        if game.isDone() == true {
            let savedhighscores = defaults.object(forKey: "HiScore") as? [String] ?? [String]()
            highscores = savedhighscores
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            highscores.append("\(game.score) \(dateFormatter.string(from: date))")
            let sorted = highscores.sorted {$0.localizedStandardCompare($1) == .orderedDescending}
            defaults.set(sorted, forKey: "HiScore")
            
            let alert = UIAlertController(
                title: "Game Over",
                message: "\(game.score) points",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "Bummer", style: .default,
                handler: nil ))
            
            present(alert, animated: true,
                    completion: {self.BoardView.layoutSubviews()})
            tabBarController?.selectedIndex = 1
        }
        
    }
    
    //Code that is ran when user presses right button or swipes right. It checks if the game is over and if it is then displays appropriate alerts. Otherwise it updates the scores and tiles appropriately.
    @IBAction func rightAction(_ sender: UIButton) {
        let moved = game.collapse(dir: .right)
        if moved {
            game.spawn()
        }
        updateViewFromGame()
        if game.isDone() == true {
            let savedhighscores = defaults.object(forKey: "HiScore") as? [String] ?? [String]()
            highscores = savedhighscores
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            highscores.append("\(game.score) \(dateFormatter.string(from: date))")
            let sorted = highscores.sorted {$0.localizedStandardCompare($1) == .orderedDescending}
            defaults.set(sorted, forKey: "HiScore")
            
            let alert = UIAlertController(
                title: "Game Over",
                message: "\(game.score) points",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "Bummer", style: .default,
                handler: nil ))
            
            present(alert, animated: true,
                    completion: {self.BoardView.layoutSubviews()})
            tabBarController?.selectedIndex = 1
        }
    }
    
    //Code that is ran when user presses down button or swipes down. It checks if the game is over and if it is then displays appropriate alerts. Otherwise it updates the scores and tiles appropriately.
    @IBAction func downAction(_ sender: UIButton) {
        let moved = game.collapse(dir: .down)
        if moved {
            game.spawn()
        }
        updateViewFromGame()
        if game.isDone() == true {
            let savedhighscores = defaults.object(forKey: "HiScore") as? [String] ?? [String]()
            highscores = savedhighscores
            let dateFormatter = DateFormatter()
            let date = Date()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            highscores.append("\(game.score) \(dateFormatter.string(from: date))")
            let sorted = highscores.sorted {$0.localizedStandardCompare($1) == .orderedDescending}
            defaults.set(sorted, forKey: "HiScore")
            
            let alert = UIAlertController(
                title: "Game Over",
                message: "\(game.score) points",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "Bummer", style: .default,
                handler: nil ))
            
            present(alert, animated: true,
                    completion: {self.BoardView.layoutSubviews()})
            tabBarController?.selectedIndex = 1
            
        }
    }
    
    //Initializing the board and setting up gestures when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        game.newgame(rand: rngBool)
        game.spawn()
        game.spawn()
        game.spawn()
        game.spawn()
        updateViewFromGame()
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upAction(_:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downAction(_:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightAction(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftAction(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    // Control for random switch (deterministic mode for testing purposes)
    @IBAction func randomAction(_ sender: UISegmentedControl) {
        if randomOutlet.selectedSegmentIndex == 1 {
            rngBool = false
        } else {
            rngBool = true
        }
    }
    
    // Updating buttontiles to match matrix of ints (used for animations)
    func updatetileMap() {
        for i in 0..<4 {
            for j in 0..<4 {
                if game.board[i][j] != nil {
                    tileMap[game.board[i][j]!.id] = ButtonTile(t: game.board[i][j]!)
                }
            }
        }
    }
    
    //Calculates the frame of a buttontile based on the view of the specific iOS device.
    func buttonFrame(row: Int, col: Int, view: UIView) -> CGRect {
        let width = view.frame.width/4
        let height =  view.frame.height/4
        
        print("cg col", CGFloat(col))
        print("cg row", CGFloat(row))
        
        return CGRect(x: CGFloat(col) * width, y: CGFloat(row) * height, width: width, height: height)
    }
    
    
    //Checking to see whether a tile needs to be moved and if it needs an animation or not
    func move(tiletocheck: Tile?) -> Bool{
        if tiletocheck != nil && tileMap[tiletocheck!.id] != nil &&
            (tiletocheck!.row != tileMap[tiletocheck!.id]?.tile.row ||
                tiletocheck!.col != tileMap[tiletocheck!.id]?.tile.col) {
            return true
        }
        return false
    }
    
    //updating the view after making any other changes
    func updateViewFromGame() {
        scoreOutlet.text  = "\(game.score) pts"
        NewGameOutlet.layer.cornerRadius = 10
        NewGameOutlet.layer.borderColor = CGColor(srgbRed: 0/255, green: 38/255, blue: 22/255, alpha: 1.0)
        NewGameOutlet.layer.backgroundColor = UIColor.gray.cgColor
        NewGameOutlet.layer.borderWidth = 3
        NewGameOutlet.setTitleColor(UIColor.white, for: UIControl.State.normal)
        leftOutlet.layer.cornerRadius = 10
        rightOutlet.layer.cornerRadius = 10
        upOutlet.layer.cornerRadius = 10
        downOutlet.layer.cornerRadius = 10
        
        // Adding new tiles to the board
        for i in 0..<4 {
            for j in 0..<4 {
                if game.board[i][j] != nil && tileMap[game.board[i][j]!.id] == nil  {
                    tileMap[game.board[i][j]!.id] = ButtonTile(t: game.board[i][j]!)
                    let button = tileMap[game.board[i][j]!.id]
                    BoardView.addSubview(button!)
                }
            }
        }
        
        // Flagging the tiles that should be removed
        for element in tileMap {
            var remove = true
            outerloop : for i in 0..<4 {
                for j in 0..<4 {
                    if game.board[i][j] != nil && element.key == game.board[i][j]!.id {
                        remove = false
                        break outerloop
                    }
                }
            }
            
            if remove == true {
                tileMap[element.key]?.should_remove = true
            }
        }
        
        // updating row and col info for all remaining tiles
        for i in 0..<4 {
            for j in 0..<4 {
                if game.board[i][j] != nil && tileMap[game.board[i][j]!.id]?.should_remove == false {
                    tileMap[game.board[i][j]!.id]?.tile.row = game.board[i][j]!.row
                    tileMap[game.board[i][j]!.id]?.tile.col = game.board[i][j]!.col
                }
            }
        }
        BoardView.setNeedsDisplay()
    }
    
}

