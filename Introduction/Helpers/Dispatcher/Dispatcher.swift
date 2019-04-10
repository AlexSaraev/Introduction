//
//  Dispatcher.swift
//  CrazyList
//
//  Created by Alex on 09/08/2018.
//  Copyright © 2018 Alex Saraev. All rights reserved.
//

import UIKit

class Dispatcher: DispatcherType {
    
    // MARK: - Static properties
    static let shared = Dispatcher()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - DispatcherType
    /// Delay in seconds.
    func asyncMainQueue(delay seconds: Double = 0, execution: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            execution()
        }
    }
    
    func asyncGlobalQueue(qos: DispatchQoS.QoSClass, execution: @escaping () -> Void) {
        DispatchQueue.global(qos: qos).async {
            execution()
        }
    }
    
    /// The image resizing performs in background thread, then the completion block performs in main thread.
    func resizeImageInBackgroundQueue(image: UIImage, toWidth width: CGFloat = Defaults.maxImageSizeWidth, completion: @escaping (_ image: UIImage) -> Void) {
        
        func executeCompletionBlockInMainQueue(with image: UIImage) {
            DispatchQueue.main.async { completion(image) }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            if image.size.width > width {
                let imageWithNewSize = image.resized(toWidth: width)
                executeCompletionBlockInMainQueue(with: imageWithNewSize!)
            } else {
                executeCompletionBlockInMainQueue(with: image)
            }
        }
    }
    
    // MARK: - Defaults
    struct Defaults {
        static let maxImageSizeWidth: CGFloat = 960
    }
}
