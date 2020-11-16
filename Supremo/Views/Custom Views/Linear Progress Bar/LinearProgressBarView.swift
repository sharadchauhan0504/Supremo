//
//  LinearProgressBarView.swift
//  Supremo
//
//  Created by Sharad on 16/11/20.
//

import UIKit

extension Comparable {
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        return min(max(self, lowerBound), upperBound)
    }
}

class LinearProgressBarView: UIView {
        
    //MARK:- Public variables
    public var barColor: UIColor     = .green
    public var trackColor: UIColor   = .yellow
    public var barThickness: CGFloat = 10
    public var barPadding: CGFloat   = 0
    public var trackPadding: CGFloat = 0 {
        didSet {
            if trackPadding < 0 {
                trackPadding = 0
            } else if trackPadding > barThickness {
                trackPadding = 0
            }
        }
    }
    public var progressValue: CGFloat = 0 {
        didSet {
            progressValue = progressValue.clamped(lowerBound: 0, upperBound: 100)
            setNeedsDisplay()
        }
    }
    public var barColorForValue: ((Float) -> UIColor)?
    
    //MARK:- Private variables
    private var trackHeight: CGFloat {
        return barThickness + trackPadding
    }
            
    private var trackOffset: CGFloat {
        return trackHeight / 2
    }
    
    //MARK:- Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
            
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
        
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawProgressView()
    }
    
    //MARK:- Private methods
    private func drawOn(context: CGContext, lineWidth: CGFloat, begin: CGPoint, end: CGPoint, lineCap: CGLineCap, strokeColor: UIColor) {
        context.setStrokeColor(strokeColor.cgColor)
        context.beginPath()
        context.setLineWidth(lineWidth)
        context.move(to: begin)
        context.addLine(to: end)
        context.setLineCap(lineCap)
        context.strokePath()
    }
    
    private func drawProgressView() {
        guard let context = UIGraphicsGetCurrentContext() else { return }
            
        let beginPoint = CGPoint(
            x: barPadding + trackOffset,
            y: frame.size.height / 2
        )
            
        // Progress Bar Track
        drawOn(
            context: context,
            lineWidth: barThickness + trackPadding,
            begin: beginPoint,
            end: CGPoint(x: frame.size.width - barPadding - trackOffset, y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: trackColor
        )
            
        // Progress bar
        let colorForBar  = barColorForValue?(Float(progressValue)) ?? barColor
        let barLineWidth = calculatePercentage() > 0 ? barThickness : 0
            
        drawOn(
            context: context,
            lineWidth: barLineWidth,
            begin: beginPoint,
            end: CGPoint(x: barPadding + trackOffset + calculatePercentage(), y: frame.size.height / 2),
            lineCap: .round,
            strokeColor: colorForBar
        )
    }

    private func setup() {
        clearsContextBeforeDrawing = true
        contentMode                = .redraw
        clipsToBounds              = false
    }
    
    private func calculatePercentage() -> CGFloat {
        let screenWidth = frame.size.width - (barPadding * 2) - (trackOffset * 2)
        let progress    = ((progressValue / 100) * screenWidth)
        return progress < 0 ? barPadding : progress
    }
}
