//
//  PresentationController.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 16.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeight = bounds.height / 5
        return CGRect(x: 0,
                      y: halfHeight,
                      width: bounds.width,
                      height: bounds.height )
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        containerView?.addSubview(presentedView!)

    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()

        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    var driver: TransitionDriver!
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        if completed {
            driver.direction = .dismiss
        }
    }
}

