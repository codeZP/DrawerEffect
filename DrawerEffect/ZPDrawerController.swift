//
//  ZPDrawerController.swift
//  DrawerEffectDemo
//
//  Created by miaolin on 16/6/3.
//  Copyright © 2016年 赵攀. All rights reserved.
//

import UIKit

private let ZPMaxY: CGFloat = 80
private let ZPScreenW = UIScreen.mainScreen().bounds.size.width
private let ZPScreenH = UIScreen.mainScreen().bounds.size.height
private let ZPMaxX: CGFloat = 100

class ZPDrawerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置子控制器
        setupChildVC()
        //设置view
        setupView()
        //设置手势
        setupGesture()
    }
    
    private func setupChildVC() {
        addChildViewController(ZPDrawerRightController())
        addChildViewController(ZPDrawerLeftController())
        addChildViewController(ZPDrawerMainController())
    }
    
    private func setupView() {
        for vc in childViewControllers {
            view.addSubview(vc.view)
        }
    }
    
    private func setupGesture() {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:))))
    }
    
    @objc private func panGesture(pan: UIPanGestureRecognizer) {
        let lastVc = childViewControllers.last
        let offset = pan.translationInView(self.view)
        viewFrameWithOffsetX(offset.x, targetView: lastVc!.view)
        pan.setTranslation(CGPointZero, inView: self.view)
        let leftVC = childViewControllers[1]
        let x = lastVc?.view.frame.origin.x
        if x > 0 {
            leftVC.view.hidden = false
        }else {
            leftVC.view.hidden = true
        }
        if pan.state == .Ended {
            UIView.animateWithDuration(0.25, animations: {
                if x < ZPScreenW * 0.5 && x > -ZPScreenW * 0.5 {
                    lastVc?.view.frame = UIScreen.mainScreen().bounds
                }else {
                    
                    lastVc?.view.frame = UIScreen.mainScreen().bounds
                    if x > 0 {
                        self.viewFrameWithOffsetX(ZPScreenW - ZPMaxX, targetView: lastVc!.view)
                    }else {
                        self.viewFrameWithOffsetX(ZPMaxX - ZPScreenW, targetView: lastVc!.view)
                    }
                    
                }
            })
        }
    }
    
    private func viewFrameWithOffsetX (offsetX: CGFloat, targetView: UIView) {
        var rect = targetView.frame
        rect.origin.x += offsetX
        let preH = rect.size.height
        var curH: CGFloat = 0
        if rect.origin.x > 0 {
            curH = preH - 2 * offsetX * ZPMaxY / ZPScreenW
        }else {
            curH = preH + 2 * offsetX * ZPMaxY / ZPScreenW
        }
        let y = (ZPScreenH - curH) * 0.5
        rect.origin.y = y
        rect.size.height = curH
        targetView.frame = rect
    }
}
