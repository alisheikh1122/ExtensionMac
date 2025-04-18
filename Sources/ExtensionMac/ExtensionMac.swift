// The Swift Programming Language
// https://docs.swift.org/swift-book

import Cocoa
import Foundation

@IBDesignable
extension NSView {
    @IBInspectable var bgColor: NSColor? {
           get {
               guard let cgColor = layer?.backgroundColor else { return nil }
               return NSColor(cgColor: cgColor)
           }
           set {
               wantsLayer = true
               layer?.backgroundColor = newValue?.cgColor
           }
       }
    @IBInspectable var cornerRadius: CGFloat {
        get { layer?.cornerRadius ?? 0 }
        set {
            wantsLayer = true
            layer?.cornerRadius = newValue
            layer?.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { layer?.borderWidth ?? 0 }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: NSColor {
        get {
            guard let cgColor = layer?.borderColor else { return .clear }
            return NSColor(cgColor: cgColor) ?? .clear
        }
        set {
            wantsLayer = true
            layer?.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var isCircle: Bool {
        get {
            guard let layer = layer else { return false }
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            wantsLayer = true
            if newValue {
                let minDimension = min(bounds.width, bounds.height)
                layer?.cornerRadius = minDimension / 2
                layer?.masksToBounds = true
            }
        }
    }
}
@IBDesignable
extension NSButton {
    @IBInspectable var bgColorb: NSColor? {
        get {
            guard let cgColor = layer?.backgroundColor else { return nil }
            return NSColor(cgColor: cgColor)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadiusb: CGFloat {
        get { layer?.cornerRadius ?? 0 }
        set {
            wantsLayer = true
            layer?.cornerRadius = newValue
            layer?.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidthb: CGFloat {
        get { layer?.borderWidth ?? 0 }
        set {
            wantsLayer = true
            layer?.borderWidth = newValue
        }
    }
    @IBInspectable var borderColorb: NSColor {
        get {
            guard let cgColor = layer?.borderColor else { return .clear }
            return NSColor(cgColor: cgColor) ?? .clear
        }
        set {
            wantsLayer = true
            layer?.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var isCircleb: Bool {
        get {
            guard let layer = layer else { return false }
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            wantsLayer = true
            if newValue {
                let minDimension = min(bounds.width, bounds.height)
                layer?.cornerRadius = minDimension / 2
                layer?.masksToBounds = true
            }
        }
    }
}
extension NSView {
    public func addShimmer(shimmerColor: NSColor = .white) {
        wantsLayer = true
        let dark = shimmerColor.withAlphaComponent(0.2).cgColor
        let light = shimmerColor.withAlphaComponent(0.1).cgColor
        let clear = shimmerColor.withAlphaComponent(0.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [clear, light, dark, light, clear]
        gradientLayer.locations = [0, 0.3, 0.5, 0.7, 1]

        layer?.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -frame.size.width
        animation.toValue = frame.size.width
        animation.repeatCount = .infinity
        animation.duration = 1.5
        animation.isRemovedOnCompletion = false

        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}
@IBDesignable
extension NSTextField {
    @IBInspectable var textColor: NSColor? {
            get { textColor }
            set { textColor = newValue ?? .labelColor }
        }
    @IBInspectable var fontName: String? {
        get { font?.fontName }
        set {
            if let fontName = newValue, let fontSize = font?.pointSize {
                font = NSFont(name: fontName, size: fontSize)
            }
        }
    }
    @IBInspectable var fontSize: CGFloat {
        get { font?.pointSize ?? 0 }
        set {
            if let fontName = font?.fontName {
                font = NSFont(name: fontName, size: newValue)
            }
        }
    }
}
@IBDesignable
public class GradientView: NSView {
    @IBInspectable var hexColors: String = "#FFFFFF,#000000" {
        didSet { updateGradient() }
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet { updateGradient() }
    }
    private let gradientLayer = CAGradientLayer()
    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        sharedInit()
    }
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        sharedInit()
    }
    override public func layout() {
        super.layout()
        gradientLayer.frame = bounds
    }
    private func sharedInit() {
        wantsLayer = true
        layer?.insertSublayer(gradientLayer, at: 0)
        updateGradient()
    }
    private func updateGradient() {
        gradientLayer.colors = parseHexColors(hexColors).map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = isHorizontal ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
    }
    private func parseHexColors(_ hexString: String) -> [NSColor] {
        hexString
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { NSColor(hex: $0) }
    }
}
@IBDesignable
public class GradientButton: NSButton {
    @IBInspectable var hexColors: String = "#FFFFFF,#000000" {
        didSet { updateGradient() }
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet { updateGradient() }
    }
    private let gradientLayer = CAGradientLayer()
    // MARK: - Init
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        sharedInit()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    // MARK: - Layout
    public override func layout() {
        super.layout()
        gradientLayer.frame = bounds
    }
    // MARK: - Setup
    private func sharedInit() {
        wantsLayer = true
        layer?.masksToBounds = true
        layer?.insertSublayer(gradientLayer, at: 0)
        updateGradient()
    }
    // MARK: - Update Gradient
    private func updateGradient() {
        gradientLayer.colors = parseHexColors(hexColors).map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = isHorizontal ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
    }
    // MARK: - Helper
    private func parseHexColors(_ hexString: String) -> [NSColor] {
        return hexString
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { NSColor(hex: $0) }
    }
}
extension NSColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        if hexSanitized.count == 3 {
            let r = hexSanitized[hexSanitized.startIndex]
            let g = hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 1)]
            let b = hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 2)]
            hexSanitized = "\(r)\(r)\(g)\(g)\(b)\(b)"
        }

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        switch hexSanitized.count {
        case 6:
            self.init(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        case 8:
            self.init(
                red: CGFloat((rgb & 0xFF000000) >> 24) / 255.0,
                green: CGFloat((rgb & 0x00FF0000) >> 16) / 255.0,
                blue: CGFloat((rgb & 0x0000FF00) >> 8) / 255.0,
                alpha: CGFloat(rgb & 0x000000FF) / 255.0
            )
        default:
            return nil
        }
    }
}
