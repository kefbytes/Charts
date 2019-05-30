//
//  AxisView.swift
//  DrawingTest
//
//  Created by Kent Franks on 5/30/19.
//  Copyright © 2019 LPL Financial. All rights reserved.
//

import UIKit

class AxisView: UIView {
    
    // MARK: - Properties
    let graphPadding: CGFloat = 10
    var graphHeight: CGFloat
    var graphWidth: CGFloat
    var xAxisPoints: [CGFloat] = []
    var yAxisPoints: [CGFloat] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        graphHeight = frame.height
        graphWidth = frame.width
        super.init(frame: frame)
        self.backgroundColor = .white
        
    }
    
    convenience init(frame: CGRect, numOfXAxisPoints: Int, numOfYAxisPoints: Int, dataPoints: [CGFloat]) {
        self.init(frame: frame)
        calculateXAxisPoints(numberOfPoints: numOfXAxisPoints)
        calculateYAxisPoints(numberOfPoints: numOfYAxisPoints)
        addInnerGraph(dataPoints: dataPoints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        drawXAxis(rect: rect)
        drawYAxis(rect: rect)
    }
    
    private func drawXAxis(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 1
        print("🤖 AxisView.xAxisPoints: \(xAxisPoints)")
        for (i, _) in xAxisPoints.enumerated() {
            path.move(to: CGPoint(x: xAxisPoints[i], y: transformYCoordinate(originalCoord: 0)))
            path.addLine(to: CGPoint(x: xAxisPoints[i], y: transformYCoordinate(originalCoord: 10)))
        }
        UIColor.blue.setStroke()
        path.stroke()
    }
    
    private func drawYAxis(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 1
        for (i, _) in yAxisPoints.enumerated() {
            path.move(to: CGPoint(x: 0, y: transformYCoordinate(originalCoord: yAxisPoints[i])))
            path.addLine(to: CGPoint(x: 10, y: transformYCoordinate(originalCoord: yAxisPoints[i])))
        }
        UIColor.blue.setStroke()
        path.stroke()
    }
    
    private func addInnerGraph(dataPoints: [CGFloat]) {
        let chartView = ChartView(frame: CGRect(x: 10, y: 10, width: graphWidth - 20, height: graphHeight - 20), xAxisPoints: xAxisPoints, dataPoints: dataPoints)
        chartView.tag = 1007
        self.addSubview(chartView)
    }
    
    // MARK: - Helper functions
    private func transformYCoordinate(originalCoord: CGFloat) -> CGFloat {
        return self.bounds.height - originalCoord
    }
    
    private func calculateXAxisPoints(numberOfPoints: Int) {
        let xAxisWorkingWidth = graphWidth - (graphPadding * 2)
        let numberOfTotalXAxisPoints = numberOfPoints
        let distanceBetweenPoints = xAxisWorkingWidth / CGFloat(numberOfTotalXAxisPoints)
        xAxisPoints.append(graphPadding)
        for i in 1..<numberOfTotalXAxisPoints {
            xAxisPoints.append(graphPadding + (distanceBetweenPoints * CGFloat(i)))
        }
        xAxisPoints.append(graphWidth - graphPadding)
    }
    
    private func calculateYAxisPoints(numberOfPoints: Int) {
        let yAxisWorkingWidth = graphHeight - (graphPadding * 2)
        let numberOfTotalYAxisPoints = numberOfPoints
        let distanceBetweenPoints = yAxisWorkingWidth / CGFloat(numberOfTotalYAxisPoints)
        yAxisPoints.append(graphPadding)
        for i in 1..<numberOfTotalYAxisPoints {
            yAxisPoints.append(graphPadding + (distanceBetweenPoints * CGFloat(i)))
        }
        yAxisPoints.append(graphHeight - graphPadding)
    }
    
    
}

