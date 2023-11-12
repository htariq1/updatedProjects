//
//  HighController.swift
//  Created by Hassan Tariq on 4/4/20.
//  Copyright © 2020 Hassan Tariq. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var highscoreOutlet: UILabel!
}

// Displays top scores from current and previous session in highscores tab.

class HighController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var defaults = UserDefaults.standard
    var highArray = [String]()
    
    @IBOutlet weak var tableOutlet: UITableView! {
        didSet {
            tableOutlet.delegate = self
            tableOutlet.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let mycell = cell as? Cell {
            mycell.highscoreOutlet.text = "\(highArray[indexPath.row])"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let savedhighscores = defaults.object(forKey: "HiScore") as? [String] ?? [String]()
        highArray = [String]()
        for i in 0..<16 {
            if i < savedhighscores.count {
                highArray.append("\(i + 1)) \(savedhighscores[i])")
            } else {
                highArray.append("")
            }
        }
        self.tableOutlet?.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let savedhighscores = defaults.object(forKey: "HiScore") as? [String] ?? [String]()
        highArray = [String]()
        for i in 0..<16 {
            if i < savedhighscores.count {
                highArray.append("\(i + 1)) \(savedhighscores[i])")
            } else {
                highArray.append("")
            }
        }
        self.tableOutlet?.reloadData()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
