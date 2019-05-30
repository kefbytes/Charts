//
//  ViewController.swift
//  KefBytesCharts
//
//  Created by Kent Franks on 5/30/19.
//  Copyright © 2019 KefBytes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCustomDrawing(width: screenSize.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            addCustomDrawing(width: screenSize.height)
        } else {
            addCustomDrawing(width: screenSize.width)
        }
    }
    
    func addCustomDrawing(width: CGFloat) {
        if let axisView = self.view.viewWithTag(1007) {
            axisView.removeFromSuperview()
        }
        let axisView = AxisView(frame: CGRect(x: 10, y: 100, width: width - 20, height: 300), numOfXAxisPoints: 10, numOfYAxisPoints: 10, dataPoints: [20, 60, 40, 65, 125, 140, 145, 147, 179])
        axisView.tag = 1007
        self.view.addSubview(axisView)
    }
    
}

