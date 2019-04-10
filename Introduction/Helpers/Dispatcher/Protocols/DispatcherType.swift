//
//  DispatcherType.swift
//  CrazyList
//
//  Created by Alex on 04/02/2019.
//  Copyright © 2019 Alex Saraev. All rights reserved.
//

import UIKit

protocol DispatcherType {
    
    func asyncMainQueue(delay seconds: Double, execution: @escaping () -> Void)
    
    func asyncGlobalQueue(qos: DispatchQoS.QoSClass, execution: @escaping () -> Void)
    
    /// The image resizing performs in background thread, then the completion block performs in main thread.
    func resizeImageInBackgroundQueue(image: UIImage, toWidth width: CGFloat, completion: @escaping (_ image: UIImage) -> Void)
}
