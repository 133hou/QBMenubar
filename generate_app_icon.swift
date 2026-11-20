import AppKit
import CoreGraphics

func generateAppIcon() {
    let canvasSize: CGFloat = 1024
    let rect = NSRect(x: 0, y: 0, width: canvasSize, height: canvasSize)
    
    let image = NSImage(size: rect.size, flipped: false) { _ in
        guard let ctx = NSGraphicsContext.current?.cgContext else { return false }
        
        // 1. Draw outer app icon drop shadow
        ctx.saveGState()
        let iconBounds = NSRect(x: 100, y: 100, width: 824, height: 824)
        let cornerRadius: CGFloat = 185
        let squirclePath = NSBezierPath(roundedRect: iconBounds, xRadius: cornerRadius, yRadius: cornerRadius)
        
        ctx.setShadow(
            offset: CGSize(width: 0, height: -22),
            blur: 32,
            color: NSColor.black.withAlphaComponent(0.38).cgColor
        )
        NSColor.black.withAlphaComponent(0.01).setFill()
        squirclePath.fill()
        ctx.restoreGState()
        
        // 2. Draw Liquid Glass gradient base
        ctx.saveGState()
        squirclePath.addClip()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let baseColors = [
            NSColor(srgbRed: 0.18, green: 0.54, blue: 0.98, alpha: 1.0).cgColor,
            NSColor(srgbRed: 0.12, green: 0.42, blue: 0.88, alpha: 1.0).cgColor,
            NSColor(srgbRed: 0.08, green: 0.28, blue: 0.74, alpha: 1.0).cgColor
        ] as CFArray
        let baseLocations: [CGFloat] = [0.0, 0.5, 1.0]
        if let baseGradient = CGGradient(colorsSpace: colorSpace, colors: baseColors, locations: baseLocations) {
            ctx.drawLinearGradient(
                baseGradient,
                start: CGPoint(x: 100, y: 924),
                end: CGPoint(x: 924, y: 100),
                options: []
            )
        }
        
        // 3. Upper specular gloss sheen
        let glossColors = [
            NSColor.white.withAlphaComponent(0.25).cgColor,
            NSColor.white.withAlphaComponent(0.0).cgColor
        ] as CFArray
        let glossLocations: [CGFloat] = [0.0, 1.0]
        if let glossGradient = CGGradient(colorsSpace: colorSpace, colors: glossColors, locations: glossLocations) {
            ctx.drawLinearGradient(
                glossGradient,
                start: CGPoint(x: 512, y: 924),
                end: CGPoint(x: 512, y: 512),
                options: []
            )
        }
        
        // 4. Central "qb" Typography
        let fontDescriptor = NSFont.systemFont(ofSize: 390, weight: .bold).fontDescriptor.withDesign(.rounded) ?? NSFont.systemFont(ofSize: 390, weight: .bold).fontDescriptor
        let font = NSFont(descriptor: fontDescriptor, size: 390) ?? NSFont.systemFont(ofSize: 390, weight: .bold)
        
        let text = "qb"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let textShadow = NSShadow()
        textShadow.shadowColor = NSColor.black.withAlphaComponent(0.30)
        textShadow.shadowBlurRadius = 14
        textShadow.shadowOffset = NSSize(width: 0, height: -8)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor.white,
            .paragraphStyle: paragraphStyle,
            .shadow: textShadow
        ]
        
        let attrString = NSAttributedString(string: text, attributes: attributes)
        let textSize = attrString.size()
        // Fine-tuned visual optical center
        let textRect = NSRect(
            x: (canvasSize - textSize.width) / 2,
            y: (canvasSize - textSize.height) / 2 - 14,
            width: textSize.width,
            height: textSize.height
        )
        attrString.draw(in: textRect)
        
        ctx.restoreGState()
        
        // 5. Specular rim highlight border
        ctx.saveGState()
        let rimBounds = iconBounds.insetBy(dx: 2.0, dy: 2.0)
        let rimPath = CGPath(roundedRect: rimBounds, cornerWidth: cornerRadius - 2.0, cornerHeight: cornerRadius - 2.0, transform: nil)
        ctx.addPath(rimPath)
        ctx.setLineWidth(4.0)
        ctx.replacePathWithStrokedPath()
        ctx.clip()
        
        let rimColors = [
            NSColor.white.withAlphaComponent(0.80).cgColor,
            NSColor.white.withAlphaComponent(0.22).cgColor,
            NSColor(srgbRed: 0.18, green: 0.54, blue: 0.98, alpha: 0.35).cgColor
        ] as CFArray
        let rimLocations: [CGFloat] = [0.0, 0.55, 1.0]
        if let rimGradient = CGGradient(colorsSpace: colorSpace, colors: rimColors, locations: rimLocations) {
            ctx.drawLinearGradient(
                rimGradient,
                start: CGPoint(x: 100, y: 924),
                end: CGPoint(x: 924, y: 100),
                options: []
            )
        }
        ctx.restoreGState()
        
        // 6. Subtle outer rim stroke
        ctx.saveGState()
        let outerPath = CGPath(roundedRect: iconBounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
        ctx.addPath(outerPath)
        ctx.setLineWidth(1.0)
        ctx.setStrokeColor(NSColor.black.withAlphaComponent(0.14).cgColor)
        ctx.strokePath()
        ctx.restoreGState()
        
        return true
    }
    
    let fm = FileManager.default
    let iconsetDir = "AppIcon.iconset"
    try? fm.removeItem(atPath: iconsetDir)
    try? fm.createDirectory(atPath: iconsetDir, withIntermediateDirectories: true)
    
    let sizes: [(String, Int)] = [
        ("icon_16x16.png", 16),
        ("icon_16x16@2x.png", 32),
        ("icon_32x32.png", 32),
        ("icon_32x32@2x.png", 64),
        ("icon_128x128.png", 128),
        ("icon_128x128@2x.png", 256),
        ("icon_256x256.png", 256),
        ("icon_256x256@2x.png", 512),
        ("icon_512x512.png", 512),
        ("icon_512x512@2x.png", 1024)
    ]
    
    for (filename, targetPx) in sizes {
        let destRect = NSRect(x: 0, y: 0, width: targetPx, height: targetPx)
        let scaledImage = NSImage(size: destRect.size)
        scaledImage.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        image.draw(in: destRect, from: NSRect(x: 0, y: 0, width: canvasSize, height: canvasSize), operation: .copy, fraction: 1.0)
        scaledImage.unlockFocus()
        
        if let scaledTiff = scaledImage.tiffRepresentation,
           let scaledRep = NSBitmapImageRep(data: scaledTiff),
           let scaledPng = scaledRep.representation(using: .png, properties: [:]) {
            let path = "\(iconsetDir)/\(filename)"
            try? scaledPng.write(to: URL(fileURLWithPath: path))
        }
    }
    
    print("Generated all icons in \(iconsetDir)")
}

generateAppIcon()
