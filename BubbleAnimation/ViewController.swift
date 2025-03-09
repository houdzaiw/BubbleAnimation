import UIKit

class ViewController: UIViewController {
    
    // 动画视图的数量
    let numberOfAnimations = 2 // 动画次数（每次2个视图，共10个视图）
    var animationTimer: Timer?
    var animatingViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化时不创建视图，在动画开始时动态创建
        startSequentialAnimation()
        
        // 设置定时器，每隔2秒启动一次新动画
        animationTimer = Timer.scheduledTimer(withTimeInterval: 1.3, repeats: true) { [weak self] _ in
            self?.startSequentialAnimation()
        }
        let view1 = UIView()
        let view2 = UIView()
        view1.backgroundColor = self.randomColor()
        view2.backgroundColor = self.randomColor()
        view1.frame = CGRect(x: 100, y: 250, width: 50, height: 50)
        view2.frame = CGRect(x: 150, y: 250, width: 50, height: 50)
        self.view.addSubview(view1)
        self.view.addSubview(view2)
    }
    
    // 顺序启动动画 (每次创建两个视图)
    func startSequentialAnimation() {
        for i in 0..<numberOfAnimations {
            // 延迟启动动画，保证顺序执行
            let delay = Double(i) * 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                // 每次启动两个视图的动画
                self.startAnimation(index: i)
            }
        }
    }
    
    // 动态创建两个视图并开始动画
    func startAnimation(index: Int) {
        // 创建两个视图并添加到界面
        let firstView = createAnimatingView(color: randomColor())
        let secondView = createAnimatingView(color: randomColor())
        // 为每个视图启动动画
        startViewAnimation(view: firstView, index: index)
        startViewAnimation(view: secondView, index: index)
        //放到最底层
        self.view.insertSubview(firstView, at: 0)
        self.view.insertSubview(secondView, at: 0)
    }
    
    // 创建单个 animatingView 视图
    func createAnimatingView(color: UIColor) -> UIView {
        let size: CGFloat = 50
        let startX = 100.0 // 两个视图从同一 X 位置开始
        let startY = 250.0
        let animatingView = UIView(frame: CGRect(x: startX, y: startY, width: size, height: size))
        animatingView.backgroundColor = color
        animatingView.layer.cornerRadius = size / 2
       
        
        return animatingView
    }
    
    // 配置视图动画效果
    func startViewAnimation(view: UIView, index: Int) {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4.0
        animationGroup.repeatCount = 1
        animationGroup.delegate = self
        
        // 1. 位置动画 (从下到上 + 轻微左右摇摆)
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = UIBezierPath()
        let startPoint = view.layer.position
        let endPoint = CGPoint(x: startPoint.x, y: 100)
        
        path.move(to: startPoint)
        
        // 创建轻微左右摇摆的路径
        let maxSwingRange: CGFloat = 10
        for i in 1...5 {
            let swingFactor = CGFloat(1.0 - Double(i) * 0.2)
            let xOffset = (i % 2 == 1 ? -1 : 1) * maxSwingRange * swingFactor
            let intermediatePoint = CGPoint(
                x: startPoint.x + xOffset,
                y: startPoint.y - CGFloat(i) * ((startPoint.y - endPoint.y) / 5)
            )
            path.addLine(to: intermediatePoint)
        }
        path.addLine(to: endPoint)
        
        positionAnimation.path = path.cgPath
        positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // 2. 缩放动画 (从小到大)
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [0.3, 0.6, 1.0]
        scaleAnimation.keyTimes = [0.0, 0.5, 1.0]
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // 3. 透明度变化 (淡入淡出)
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [0.3, 1.0, 0.3]
        opacityAnimation.keyTimes = [0.0, 0.5, 1.0]
        
        // 组合动画效果
        animationGroup.animations = [positionAnimation, scaleAnimation, opacityAnimation]
        
        // 动画完成后重新执行，实现无限循环
        animationGroup.setValue(view, forKey: "animatingView")
        animationGroup.setValue(index, forKey: "viewIndex")
        
        view.layer.add(animationGroup, forKey: "sequentialAnimation")
    }
    
    // 生成随机颜色
    func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.5...1),
            green: CGFloat.random(in: 0.5...1),
            blue: CGFloat.random(in: 0.5...1),
            alpha: 1.0
        )
    }
    // 释放animationTimer
    deinit {
        animationTimer?.invalidate()
    }
}
// MARK: - CAAnimationDelegate
extension ViewController: CAAnimationDelegate {
    
    // 监听动画结束事件
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag, let view = anim.value(forKey: "animatingView") as? UIView,
           let index = anim.value(forKey: "viewIndex") as? Int {
               view.removeFromSuperview()
            // 动画结束后重新开始，保证无限循环
//            let delay = Double(index) * 0.5
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                self.startViewAnimation(view: view, index: index)
//            }
        }
    }
}
