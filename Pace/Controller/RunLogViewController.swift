//
//  RunLogViewController.swift
//  Pace
//
//  Created by Junior on 16/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import UIKit

class RunLogViewController: LocationViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
}


extension RunLogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as? RunLogTableViewCell {
            guard let run = Run.getAllRuns()?[indexPath.row] else {
                 return RunLogTableViewCell()
            }
            cell.configureCell(run: run)
            return cell
        }else{
            return RunLogTableViewCell()
        }
    }
    
    
}
