import UIKit

fileprivate extension CGFloat {
    
    func isAlmostEqual(to other: CGFloat, delta: CGFloat = 0.0001) -> Bool {
        abs(self - other) < delta
    }
    
}

extension UIColor {
    
    func comparedByRainbow(to other: UIColor) -> Bool {
        if self.isGray() && !other.isGray() {
            return true
        }
        if !self.isGray() && other.isGray() {
            return false
        }
        if self.isGray() && other.isGray() {
            let (_, _, brightness1) = self.getHSB()
            let (_, _, brightness2) = other.getHSB()
            return brightness1 < brightness2
        }
        let (hue1, _, _) = self.getHSB()
        let (hue2, _, _) = other.getHSB()
        return hue1 < hue2
    }
    
    func getRGB() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }

    func getHSB() -> (h: CGFloat, s: CGFloat, b: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: nil)
        return (h, s, b)
    }

    func isGray() -> Bool {
        let rgb = self.getRGB()
        return rgb.r.isAlmostEqual(to: rgb.g) &&
        rgb.g.isAlmostEqual(to: rgb.b)
        
    }
    
    func isAlmostEqualTo(_ otherColor: UIColor, delta: CGFloat) -> Bool {
        let (r1, g1, b1, _) = self.getRGB()
        let (r2, g2, b2, _) = otherColor.getRGB()
        return abs(r1 - r2) < delta && abs(g1 - g2) < delta && abs(b1 - b2) < delta
    }
}


extension Array where Element == UIColor {
    
    func firstIndex(closestTo color: UIColor) -> Int {
        var closestColorIndex = 0
        var closestColorDistance: CGFloat = .greatestFiniteMagnitude
        let thisRGB = color.getRGB()
        for (i, color) in self.enumerated() {
            let otherRGB = color.getRGB()
            let rDiff = thisRGB.r - otherRGB.r
            let gDiff = thisRGB.g - otherRGB.g
            let bDiff = thisRGB.b - otherRGB.b
            let distance = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
            if distance < closestColorDistance {
                closestColorIndex = i
                closestColorDistance = distance
            }
        }
        return closestColorIndex
    }
    
    func sortedByRainbow() -> [UIColor] {
        // First, split the colors into two arrays: one for black/gray/white colors, and one for rainbow colors
        var blackGrayWhiteColors: [UIColor] = []
        var rainbowColors: [UIColor] = []
        for color in self {
            if color.isGray() {
                blackGrayWhiteColors.append(color)
            } else {
                rainbowColors.append(color)
            }
        }

        // Next, sort the black/gray/white colors by brightness
        blackGrayWhiteColors.sort { (color1, color2) -> Bool in
            let (_, _, brightness1) = color1.getHSB()
            let (_, _, brightness2) = color2.getHSB()
            return brightness1 < brightness2
        }

        // Finally, sort the rainbow colors by hue, and then return the combined array
        rainbowColors.sort { (color1, color2) -> Bool in
            let (hue1, _, _) = color1.getHSB()
            let (hue2, _, _) = color2.getHSB()
            return hue1 < hue2
        }

        return blackGrayWhiteColors + rainbowColors
    }
}

