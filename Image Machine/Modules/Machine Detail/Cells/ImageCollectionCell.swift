//
//  ImageCollectionCell.swift
//  Image Machine
//
//  Created by Verrelio C. Rizky on 03/12/22.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(image: UIImage) {
        imageView.image = image
    }

}
