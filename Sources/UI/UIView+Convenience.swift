//
//  UIView+Convenience.swift
//  Extensions
//
//  Created by David Lenský on 12/12/2017.
//  Copyright © 2017 David Lenský. All rights reserved.

import RxCocoa
import RxSwift
import UIKit

public typealias Subview = UIView
public typealias ParentView = UIView
public typealias SiblingView = UIView
public typealias Offset = CGFloat

extension UIView {

    @IBInspectable open var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }

    @IBInspectable open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

}

public extension UIView {

	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}

    var width: CGFloat {
        get { return frame.width }
        set { frame.size = CGSize(width: newValue, height: height) }
    }

    var height: CGFloat {
        get { return frame.height }
        set { frame.size = CGSize(width: width, height: newValue) }
    }

    var flatSubviews: [UIView] { subviews.flatMap { $0.flatSubviews + [$0] } }

    func centeredXOrigin(of subview: Subview) -> CGFloat {
        return (width - subview.width) / 2.0
    }

    func centeredYOrigin(of subview: Subview) -> CGFloat {
        return (height - subview.height) / 2.0
    }

    func centeredOrigin(of subview: Subview) -> CGPoint {
        return CGPoint(x: centeredXOrigin(of: subview), y: centeredYOrigin(of: subview))
    }

    func distanceTo(_ view: UIView) -> CGSize? {
        guard self.superview == view.superview else { return nil }

        return CGSize(w: view.frame.minX - frame.maxX, h: view.frame.minY - frame.maxY)
    }

    typealias ItemSize = CGFloat
    typealias SpacingSize = CGFloat

    func fitsNumber(of item: ItemSize, with spacing: SpacingSize, into dimension: CGFloat) -> Int {
        floor((dimension - item) / (item + spacing)).int + 1
    }

    func fitsNumber(of item: ItemSize, with spacing: SpacingSize, into dimension: KeyPath<UIView, CGFloat>) -> Int {
        fitsNumber(of: item, with: spacing, into: self[keyPath: dimension])
    }

    enum XPosition {
        case left(in: ParentView, _ offset: Offset = 0.0)
        case center(in: ParentView, _ offset: Offset = 0.0)
        case right(in: ParentView, _ offset: Offset = 0.0)

        case before(SiblingView, _ offset: Offset = 0.0)
        case after(SiblingView, _ offset: Offset = 0.0)

        case alignedLeft(with: SiblingView, _ offset: Offset = 0.0)
        case centered(with: SiblingView, _ offset: Offset = 0.0)
        case alignedRight(with: SiblingView, _ offset: Offset = 0.0)
    }

    enum YPosition {
        case top(in: ParentView, _ offset: Offset = 0.0)
        case center(in: ParentView, _ offset: Offset = 0.0)
        case bottom(in: ParentView, _ offset: Offset = 0.0)

        case above(SiblingView, _ offset: Offset = 0.0)
        case below(SiblingView, _ offset: Offset = 0.0)

        case alignedTop(with: SiblingView, _ offset: Offset = 0.0)
        case centered(with: SiblingView, _ offset: Offset = 0.0)
        case alignedBottom(with: SiblingView, _ offset: Offset = 0.0)

    }

    // TODO: - This can be remade against any View - recalculate the point into the other views coordinates
    func setOrigin(x: XPosition, y: YPosition) {
        setXOrigin(x)
        setYOrigin(y)
    }

    func setXOrigin(_ x: XPosition) {
        switch x {
        case let .left(parent, offset):
            let hierarchyOffset = getHierarchyOffset(for: parent).x
            frame.origin.x = 0.0 + offset + hierarchyOffset

        case let .center(parent, offset):
            let hierarchyOffset = getHierarchyOffset(for: parent).x
            frame.origin.x = parent.centeredXOrigin(of: self) + offset + hierarchyOffset

        case let.right(parent, offset):
            let hierarchyOffset = getHierarchyOffset(for: parent).x
            frame.origin.x = parent.width - width + offset + hierarchyOffset

        case let .before(sibling, offset): frame.origin.x = sibling.frame.minX - width + offset
        case let .after(sibling, offset): frame.origin.x = sibling.frame.maxX + offset

        case let .alignedLeft(sibling, offset): frame.origin.x = sibling.frame.minX + offset
        case let .centered(sibling, offset): frame.origin.x = sibling.frame.minX + (sibling.width - width) / 2.0 + offset
        case let .alignedRight(sibling, offset): frame.origin.x = sibling.frame.maxX - width + offset
        }
    }

    func setYOrigin(_ y: YPosition) {
        switch y {
        case let .top(parent, offset):
            let hierarchyOffset = getHierarchyOffset(for: parent).y
            frame.origin.y = 0.0 + offset + hierarchyOffset

        case let .center(parent, offset):
            let hierarchyOffset = getHierarchyOffset(for: parent).y
            frame.origin.y = parent.centeredYOrigin(of: self) + offset + hierarchyOffset

        case let .bottom(parent, offset):
            let hierarchyOffset = getHierarchyOffset(for: parent).y
            frame.origin.y = parent.height - height + offset + hierarchyOffset

        case let .above(sibling, offset): frame.origin.y = sibling.frame.minY - height + offset
        case let .below(sibling, offset): frame.origin.y = sibling.frame.maxY + offset

        case let .alignedTop(sibling, offset): frame.origin.y = sibling.frame.minY + offset
        case let .centered(sibling, offset): frame.origin.y = sibling.frame.minY + (sibling.height - height) / 2.0 + offset
        case let .alignedBottom(sibling, offset): frame.origin.y = sibling.frame.maxY - height + offset
        }
    }

    private func getHierarchyOffset(for view: UIView) -> CGPoint {
        guard let sv = superview else { return .zero }
        return view.convert(.zero, to: sv)
    }

    func updateLayout() {
        setNeedsLayout()
        layoutIfNeeded()
        invalidateIntrinsicContentSize()
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

}



public extension Reactive where Base == UIView {

    var borderWidth: Binder<CGFloat> {
        Binder(self.base) { view, borderWidth in
            view.borderWidth = borderWidth
        }
    }

}
