import UIKit

class ViewController: UIViewController {
    let animationLayer = CAShapeLayer()
    let dotView = UIView()
    let animationDuration: TimeInterval = 8.0
    let animationAmplitude: CGFloat = 50.0
    let animationFrequency: CGFloat = 0.1
    let dotRadius: CGFloat = 7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        animationLayer.backgroundColor = UIColor.clear.cgColor
        animationLayer.strokeColor = UIColor.black.cgColor
        view.layer.addSublayer(animationLayer)
        
        dotView.frame = CGRect(x: 0, y: 0, width: dotRadius * 2, height: dotRadius * 2)
        dotView.center = CGPoint(x: -dotRadius, y: view.center.y)
        dotView.backgroundColor = UIColor.green
        dotView.layer.cornerRadius = dotRadius
        view.addSubview(dotView)
        
        animate()
    }
    
    func animate() {
        let animationPath = createWavePath()
        animationLayer.path = animationPath.cgPath
        
        let dotAnimation = CAKeyframeAnimation(keyPath: "position")
        dotAnimation.duration = animationDuration
        dotAnimation.path = animationPath.cgPath
        dotAnimation.calculationMode = .paced
        dotAnimation.repeatCount = .infinity
        
        dotView.layer.add(dotAnimation, forKey: "dotAnimation")
    }
    
    func createWavePath() -> UIBezierPath {
        let path = UIBezierPath()
        let width = animationLayer.bounds.width
        
        path.move(to: CGPoint(x: 0, y: view.center.y))
        
        for x in stride(from: 0, to: width + 1, by: 1) {
            let y = view.center.y - animationAmplitude * CGFloat(sin(x * animationFrequency))
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: view.center.y))
        
        return path
    }
}
