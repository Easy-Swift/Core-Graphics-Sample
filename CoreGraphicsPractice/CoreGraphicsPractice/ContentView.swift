//
//  ContentView.swift
//  CoreGraphicsPractice
//
//  Created by Manish on 09/06/20.
//  Copyright © 2020 Manish. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: drawRectLines)
    }
    
    
}

// MARK :- Drawings
extension ContentView {
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        image = Image(uiImage: img)
    }
    
    func drawBlendMode () {
        let boundSize: CGFloat = 512
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: boundSize, height: boundSize))
        
        let img = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            UIColor(red: 158/255, green: 215/255, blue: 245/255, alpha: 1).setFill()
            
            let rectSize = boundSize/1.5
            let intersectingRectPosition = rectSize / 2
            
            
            context.fill(CGRect(x: 1, y: 1, width: rectSize, height: rectSize))
            UIColor(red: 145/255, green: 211/255, blue: 205/255, alpha: 1).setFill()
            context.fill(CGRect(x: intersectingRectPosition,
                                y: intersectingRectPosition,
                                width: rectSize, height: rectSize),
                         blendMode: .multiply)
        }
        
        image = Image(uiImage: img)
    }
    
    func drawBlendCircle () {
        let boundSize: CGFloat = 512
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: boundSize, height: boundSize))
        
        let img = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            
            let rectSize = boundSize/1.5
            let intersectingRectPosition = rectSize / 2
            
            // first rect
            UIColor(red: 158/255, green: 215/255, blue: 245/255, alpha: 1).setFill()
            context.fill(CGRect(x: 1, y: 1, width: rectSize, height: rectSize))
            
            // second rect with intersection
            UIColor(red: 145/255, green: 211/255, blue: 205/255, alpha: 1).setFill()
            context.fill(CGRect(x: intersectingRectPosition,
                                y: intersectingRectPosition,
                                width: rectSize, height: rectSize),
                         blendMode: .multiply)
            
            UIColor(red: 203/255, green: 222/255, blue: 116/255, alpha: 0.6).setFill()
            context.cgContext.fillEllipse(in: CGRect(x: intersectingRectPosition,
                                                     y: intersectingRectPosition,
                                                     width: rectSize, height: rectSize))
            
        }
        
        image = Image(uiImage: img)
    }
    
    func drawSubstractedIntersectingRect () {
        let boundSize: CGFloat = 512
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: boundSize, height: boundSize))
        
        let img = renderer.image { (context) in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
            
            let rectSize = boundSize/1.5
            let intersectingRectPosition = rectSize / 2
            
            // first rect
            UIColor(red: 158/255, green: 215/255, blue: 245/255, alpha: 1).setFill()
            context.fill(CGRect(x: 1, y: 1, width: rectSize, height: rectSize))
            
            // second rect with intersection
            UIColor(red: 145/255, green: 211/255, blue: 205/255, alpha: 1).setFill()
            context.fill(CGRect(x: intersectingRectPosition,
                                y: intersectingRectPosition,
                                width: rectSize, height: rectSize))
            
            // substraction - order matters
            context.fill(CGRect(x: intersectingRectPosition,
                                y: intersectingRectPosition,
                                width: rectSize / 2, height: rectSize / 2),
                         blendMode: .clear)
            
        }
        
        image = Image(uiImage: img)
    }
    
    func drawChackerboard () {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.fill(CGRect(x: row * 64, y: col * 64,
                                                  width: 64, height: 64))
                    }
                }
            }
            
        }
        
        image = Image(uiImage: img)
    }
    
    func drowRotatedRactangles () {
        let boundsSize: CGFloat = 512
        let rectSize = boundsSize / 2
        let rectPosition = boundsSize / 4
        
        let rendere = UIGraphicsImageRenderer(size: CGSize(width: boundsSize, height: boundsSize))
        
        let img = rendere.image { ctx in
            
            ctx.cgContext.translateBy(x: rectSize, y: rectSize)
            
            let numberOfRects = 16
            let rotationAmount = Double.pi / Double(numberOfRects)
            
            for _ in 0..<numberOfRects {
                ctx.cgContext.rotate(by: CGFloat(rotationAmount))
                // create rect without fill
                ctx.cgContext.addRect(CGRect(x: -rectPosition, y: -rectPosition,
                                             width: rectSize, height: rectSize))
            }
            
            // add storoke to all rects
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
            
        }
        
        image = Image(uiImage: img)
        
    }
    
    func drawRectLines () {
        let bounds: CGFloat = 512
        let lineSize: CGFloat = bounds / 2
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: bounds, height: bounds))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: lineSize, y: lineSize)
            
            var isFirst = true
            var length = lineSize
            
            for _ in  0..<Int(lineSize) {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if isFirst {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    isFirst = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                  
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        image = Image(uiImage: img)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
