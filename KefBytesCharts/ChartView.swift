//
//  ChartView.swift
//  DrawingTest
//
//  Created by Kent Franks on 5/29/19.
//  Copyright © 2019 LPL Financial. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    // MARK: - Properties
    let graphPadding: CGFloat = 10
    let dataPointSize: CGFloat = 2
    let dataPointOffset: CGFloat = 0
    let lineWidth: CGFloat = 1
    
    var graphHeight: CGFloat
    var graphWidth: CGFloat
    var xAxisPoints: [CGFloat] = []
    var dataPoints: [CGFloat] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        graphHeight = frame.height
        graphWidth = frame.width
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    convenience init(frame: CGRect, xAxisPoints: [CGFloat], dataPoints: [CGFloat]) {
        print("🤖 ChartView.xAxisPoints: \(xAxisPoints)")
        print("🤖 ChartView.dataPoints: \(dataPoints)")
        self.init(frame: frame)
        self.dataPoints = dataPoints
        //        calculateXAxisPoints(numberOfPoints: xAxisPoints.count)
        self.xAxisPoints = xAxisPoints
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        drawGraphLines(rect: rect)
        //        drawDataPointsOnGraph(rect: rect)
    }
    
    // Draw graph lines
    private func drawGraphLines(rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: xAxisPoints[0] - graphPadding, y: transformYCoordinate(originalCoord: dataPoints[0])))
        guard xAxisPoints.count >= dataPoints.count else {
            print("❌ Not enough x axis points to display all the data points")
            return
        }
        for i in 1..<dataPoints.count {
            path.addLine(to: CGPoint(x: xAxisPoints[i] - graphPadding, y: transformYCoordinate(originalCoord: dataPoints[i])))
        }
        UIColor.green.setStroke()
        path.stroke()
    }
    
    // Draw points
    private func drawDataPointsOnGraph(rect: CGRect) {
        var pointPath = UIBezierPath()
        pointPath = UIBezierPath(ovalIn: CGRect(x: xAxisPoints[0] - dataPointOffset, y: transformYCoordinate(originalCoord: dataPoints[0] + dataPointOffset), width: dataPointSize, height: dataPointSize))
        UIColor.blue.setFill()
        pointPath.fill()
        pointPath = UIBezierPath(ovalIn: CGRect(x: xAxisPoints[1] - dataPointOffset, y: transformYCoordinate(originalCoord: dataPoints[1] + dataPointOffset), width: dataPointSize, height: dataPointSize))
        UIColor.blue.setFill()
        pointPath.fill()
        pointPath = UIBezierPath(ovalIn: CGRect(x: xAxisPoints[2] - dataPointOffset, y: transformYCoordinate(originalCoord: dataPoints[2] + dataPointOffset), width: dataPointSize, height: dataPointSize))
        UIColor.blue.setFill()
        pointPath.fill()
        pointPath = UIBezierPath(ovalIn: CGRect(x: xAxisPoints[3] - dataPointOffset, y: transformYCoordinate(originalCoord: dataPoints[3] + dataPointOffset), width: dataPointSize, height: dataPointSize))
        UIColor.blue.setFill()
        pointPath.fill()
        pointPath = UIBezierPath(ovalIn: CGRect(x: xAxisPoints[4] - dataPointOffset, y: transformYCoordinate(originalCoord: dataPoints[4] + dataPointOffset), width: dataPointSize, height: dataPointSize))
        UIColor.blue.setFill()
        pointPath.fill()
        pointPath = UIBezierPath(ovalIn: CGRect(x: xAxisPoints[5] - dataPointOffset, y: transformYCoordinate(originalCoord: dataPoints[5] + dataPointOffset), width: dataPointSize, height: dataPointSize))
        UIColor.blue.setFill()
        pointPath.fill()
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
    
}

