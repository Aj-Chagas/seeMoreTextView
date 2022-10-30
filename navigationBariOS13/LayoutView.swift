//
//  LayoutView.swift
//  navigationBariOS13
//
//  Created by Anderson Chagas on 21/08/22.
//

import UIKit

open class LayoutView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupConstraints() {}
    open func buildViewHierarchy() {}
    open func configureViews() {}
    
}

extension Array where Element == NSLayoutConstraint {
    @discardableResult
    public func activate() -> [NSLayoutConstraint] {
        for constraint in self {
            constraint.activate()
        }
        return self
    }
}

extension NSLayoutConstraint {
    @discardableResult
    public func activate() -> NSLayoutConstraint {
        self.isActive = true
        return self
    }
}
