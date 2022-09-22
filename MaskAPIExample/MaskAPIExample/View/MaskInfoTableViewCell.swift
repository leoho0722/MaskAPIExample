//
//  MaskInfoTableViewCell.swift
//  MaskAPIExample
//
//  Created by Leo Ho on 2022/9/21.
//

import UIKit

class MaskInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var drugStoreName: UILabel!
    @IBOutlet weak var drugStoreAddress: UILabel!
    @IBOutlet weak var drugStorePhone: UILabel!
    @IBOutlet weak var drugStoreMaskNum: UILabel!
    
    static let identifier = "MaskInfoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInit(drugStoreName name: String, drugStoreAddress address: String, drugStorePhone phone: String, adultMaskNum: Int, childMaskNum: Int) {
        self.drugStoreName.text = name
        self.drugStoreAddress.text = address
        self.drugStorePhone.text = phone
        self.drugStoreMaskNum.text = "成人口罩：\(adultMaskNum) 個  兒童口罩：\(childMaskNum) 個"
    }
    
}
