//
//  PopularListCell.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//


import UIKit

public protocol Reuseable {
    static func reuseID() -> String
}

class PopularListCell: UITableViewCell {

    @IBOutlet var imgArticle: UIImageView!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblAuthor: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setPopularList(list: MostPopularResult) {
        self.lblDate.text = list.updated?.convertDate()
        self.lblTitle.text = list.title
        self.lblSubTitle.text = list.abstract
        self.lblAuthor.text = list.byline
    }

}

extension PopularListCell: Reuseable {
    static func reuseID() -> String {
        return String(describing: self)
    }
}
