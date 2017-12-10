//
//  RecipeCell.swift
//  MisRecetas
//
//  Created by Andres on 29/10/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet var recipeImg: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var recipeTime: UILabel!
    @IBOutlet var recipeIngredientes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
