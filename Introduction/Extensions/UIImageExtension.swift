//
//  UIImageExtension.swift
//  CrazyList
//
//  Created by Alex on 07/09/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import UIKit

extension UIImage {
    
    var uncompressedPNGData: Data { return self.pngData()! }
    var highestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 1.0)! }
    var highQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 0.75)! }
    var mediumQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 0.5)! }
    var lowQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 0.25)! }
    var lowestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 0.0)! }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        draw(in: CGRect(origin: .zero, size: canvasSize))
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
