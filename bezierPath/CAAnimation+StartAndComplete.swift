//
//  CAAnimation+StartAndComplete.swift
//  bezierPath
//
//  Created by peter on 2021/8/15.
//

import Foundation
import UIKit

public typealias CAAnimationCallbackType = () -> ();

public class CAAnimationCallback: NSObject, CAAnimationDelegate {
    var stopCallBack: CAAnimationCallbackType?
    var startCallBack: CAAnimationCallbackType?
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let callBack = stopCallBack {
            callBack()
        }
    }
    
    public func animationDidStart(_ anim: CAAnimation, finished flag: Bool) {
        if let callBack = startCallBack {
            callBack()
        }
    }
}

extension CAAnimation {
    func animationComplete(callback: @escaping CAAnimationCallbackType) {
        if let delegate = self.delegate as? CAAnimationCallback {
            delegate.stopCallBack = callback
            return
        }
        
        let newDelegate = CAAnimationCallback()
        newDelegate.stopCallBack = callback
        self.delegate = newDelegate
    }
    
    func animationStart(callback: @escaping CAAnimationCallbackType) {
        if let delegate = self.delegate as? CAAnimationCallback {
            delegate.startCallBack = callback
            return
        }
        
        let newDelegate = CAAnimationCallback()
        newDelegate.startCallBack = callback
        self.delegate = newDelegate
    }
}


