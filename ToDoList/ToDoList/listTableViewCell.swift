//
//  listTableViewCell.swift
//  ToDoList
//
//  Created by Ashish Kumar Sonkar on 05/07/17.
//  Copyright © 2017 Ashish Kumar Sonkar. All rights reserved.
//

import UIKit

class listTableViewCell: UITableViewCell {
    @IBOutlet weak var taskTitle: UILabel!

    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var switchStatus: UISwitch!
    
    var delegate: element?
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func switchButton(_ sender: UISwitch) {
        delegate?.change(index: index)
    }

    
    @IBAction func deleteTask(_ sender: UIButton) {
        delegate?.deleteTask(index: index)

    }
}
protocol element{
    func change(index: Int)
    func deleteTask(index: Int)
}
