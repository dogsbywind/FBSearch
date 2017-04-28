//
//  AlbumTableViewCell.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/20/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumTitle: UILabel!

    @IBOutlet weak var pic2W: NSLayoutConstraint!
    @IBOutlet weak var pic2H: NSLayoutConstraint!
    @IBOutlet weak var pic1W: NSLayoutConstraint!
    @IBOutlet weak var pic1H: NSLayoutConstraint!
    @IBOutlet weak var pic1: UIImageView!
    
    @IBOutlet weak var pic2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pic1.isHidden = true
        self.pic2.isHidden = true
        self.pic1.image = nil
        self.pic2.image = nil
    }

}
