//
// BoddiView.swift
// Generated by Core Animator version 1.3.1 on 7/28/16.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

import UIKit

@IBDesignable
class BoddiView : UIImageView {


	var animationCompletions = Dictionary<CAAnimation, (Bool) -> Void>()
	var viewsByName: [String : UIView]!

	// - MARK: Life Cycle

	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupHierarchy()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupHierarchy()
	}

	// - MARK: Scaling

	override func layoutSubviews() {
		super.layoutSubviews()

		if let scalingView = self.viewsByName["__scaling__"] {
			var xScale = self.bounds.size.width / scalingView.bounds.size.width
			var yScale = self.bounds.size.height / scalingView.bounds.size.height
			switch contentMode {
			case .ScaleToFill:
				break
			case .ScaleAspectFill:
				let scale = max(xScale, yScale)
				xScale = scale
				yScale = scale
			default:
				let scale = min(xScale, yScale)
				xScale = scale
				yScale = scale
			}
			scalingView.transform = CGAffineTransformMakeScale(xScale, yScale)
			scalingView.center = CGPoint(x:CGRectGetMidX(self.bounds), y:CGRectGetMidY(self.bounds))
		}
	}

	// - MARK: Setup

	func setupHierarchy() {
		var viewsByName: [String : UIView] = [:]
		let bundle = NSBundle(forClass:self.dynamicType)
		let __scaling__ = UIView()
		__scaling__.bounds = CGRect(x:0, y:0, width:300, height:300)
		__scaling__.center = CGPoint(x:150.0, y:150.0)
		self.addSubview(__scaling__)
		viewsByName["__scaling__"] = __scaling__

		let boddiPrincipal = UIImageView()
		boddiPrincipal.bounds = CGRect(x:0, y:0, width:200.0, height:200.0)
		var imgBoddiPrincipal: UIImage!
		if let imagePath = bundle.pathForResource("boddi_principal.png", ofType:nil) {
			imgBoddiPrincipal = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'boddi_principal.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		boddiPrincipal.image = imgBoddiPrincipal
		boddiPrincipal.contentMode = .Center
		boddiPrincipal.layer.position = CGPoint(x:400.000, y:200.000)
		__scaling__.addSubview(boddiPrincipal)
		viewsByName["boddi_principal"] = boddiPrincipal

		let boddiFeliz = UIImageView()
		boddiFeliz.bounds = CGRect(x:0, y:0, width:200.0, height:200.0)
		var imgBoddiFeliz: UIImage!
		if let imagePath = bundle.pathForResource("boddi_feliz.png", ofType:nil) {
			imgBoddiFeliz = UIImage(contentsOfFile:imagePath)
		}else {
			print("** Warning: Could not create image from 'boddi_feliz.png'. Please make sure that it is added to the project directly (not in a folder reference).")
		}
		boddiFeliz.image = imgBoddiFeliz
		boddiFeliz.contentMode = .Center
		boddiFeliz.layer.position = CGPoint(x:171.069, y:200.000)
		boddiFeliz.alpha = 0.00
		__scaling__.addSubview(boddiFeliz)
		viewsByName["boddi_feliz"] = boddiFeliz

		self.viewsByName = viewsByName
	}

	// - MARK: appearHappy

	func addAppearHappyAnimation() {
		addAppearHappyAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
	}

	func addAppearHappyAnimation(completion: ((Bool) -> Void)?) {
		addAppearHappyAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
	}

	func addAppearHappyAnimation(removedOnCompletion removedOnCompletion: Bool) {
		addAppearHappyAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
	}

	func addAppearHappyAnimation(removedOnCompletion removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		addAppearHappyAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
	}

	func addAppearHappyAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		let easeInOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		let easeOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		let instantTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
		let anticipateTiming = CAMediaTimingFunction(controlPoints: 0.42, -0.30, 1.00, 1.00)
		if let complete = completion {
			let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
			representativeAnimation.duration = 1.700
			representativeAnimation.delegate = self
			self.layer.addAnimation(representativeAnimation, forKey: "AppearHappy")
			self.animationCompletions[layer.animationForKey("AppearHappy")!] = complete
		}

		let boddiFelizRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		boddiFelizRotationAnimation.duration = 1.700
		boddiFelizRotationAnimation.values = [0.000 as Float, 0.000 as Float, 0.137 as Float, -0.140 as Float, 0.140 as Float, 0.000 as Float]
		boddiFelizRotationAnimation.keyTimes = [0.000 as Float, 0.671 as Float, 0.771 as Float, 0.853 as Float, 0.912 as Float, 1.000 as Float]
		boddiFelizRotationAnimation.timingFunctions = [easeOutTiming, easeOutTiming, anticipateTiming, easeOutTiming, easeInOutTiming]
		boddiFelizRotationAnimation.beginTime = beginTime
		boddiFelizRotationAnimation.fillMode = fillMode
		boddiFelizRotationAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizRotationAnimation, forKey:"appearHappy_Rotation")

		let boddiFelizOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		boddiFelizOpacityAnimation.duration = 1.700
		boddiFelizOpacityAnimation.values = [0.000 as Float, 0.000 as Float, 1.000 as Float, 1.000 as Float]
		boddiFelizOpacityAnimation.keyTimes = [0.000 as Float, 0.670 as Float, 0.671 as Float, 1.000 as Float]
		boddiFelizOpacityAnimation.timingFunctions = [instantTiming, instantTiming, linearTiming]
		boddiFelizOpacityAnimation.beginTime = beginTime
		boddiFelizOpacityAnimation.fillMode = fillMode
		boddiFelizOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizOpacityAnimation, forKey:"appearHappy_Opacity")

		let boddiFelizTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		boddiFelizTranslationXAnimation.duration = 1.700
		boddiFelizTranslationXAnimation.values = [0.000 as Float, -5.034 as Float, -5.034 as Float]
		boddiFelizTranslationXAnimation.keyTimes = [0.000 as Float, 0.671 as Float, 1.000 as Float]
		boddiFelizTranslationXAnimation.timingFunctions = [easeOutTiming, linearTiming]
		boddiFelizTranslationXAnimation.beginTime = beginTime
		boddiFelizTranslationXAnimation.fillMode = fillMode
		boddiFelizTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizTranslationXAnimation, forKey:"appearHappy_TranslationX")

		let boddiFelizTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		boddiFelizTranslationYAnimation.duration = 1.700
		boddiFelizTranslationYAnimation.values = [0.000 as Float, -1.217 as Float, -1.217 as Float]
		boddiFelizTranslationYAnimation.keyTimes = [0.000 as Float, 0.671 as Float, 1.000 as Float]
		boddiFelizTranslationYAnimation.timingFunctions = [easeOutTiming, linearTiming]
		boddiFelizTranslationYAnimation.beginTime = beginTime
		boddiFelizTranslationYAnimation.fillMode = fillMode
		boddiFelizTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizTranslationYAnimation, forKey:"appearHappy_TranslationY")

		let boddiPrincipalOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		boddiPrincipalOpacityAnimation.duration = 1.700
		boddiPrincipalOpacityAnimation.values = [1.000 as Float, 1.000 as Float, 0.000 as Float, 0.000 as Float]
		boddiPrincipalOpacityAnimation.keyTimes = [0.000 as Float, 0.670 as Float, 0.671 as Float, 1.000 as Float]
		boddiPrincipalOpacityAnimation.timingFunctions = [instantTiming, instantTiming, linearTiming]
		boddiPrincipalOpacityAnimation.beginTime = beginTime
		boddiPrincipalOpacityAnimation.fillMode = fillMode
		boddiPrincipalOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalOpacityAnimation, forKey:"appearHappy_Opacity")

		let boddiPrincipalTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		boddiPrincipalTranslationXAnimation.duration = 1.700
		boddiPrincipalTranslationXAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.000 as Float, -1.641 as Float, -4.917 as Float, -9.840 as Float, -21.315 as Float, -29.514 as Float, -45.912 as Float, -52.469 as Float, -62.309 as Float, -84.718 as Float, -107.674 as Float, -119.155 as Float, -130.630 as Float, -151.951 as Float, -169.983 as Float, -178.182 as Float, -183.105 as Float, -189.663 as Float, -201.138 as Float, -207.702 as Float, -212.619 as Float, -219.177 as Float, -222.459 as Float, -227.376 as Float, -231.205 as Float, -232.840 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float]
		boddiPrincipalTranslationXAnimation.keyTimes = [0.000 as Float, 0.004 as Float, 0.004 as Float, 0.162 as Float, 0.162 as Float, 0.176 as Float, 0.192 as Float, 0.205 as Float, 0.224 as Float, 0.238 as Float, 0.247 as Float, 0.258 as Float, 0.287 as Float, 0.296 as Float, 0.309 as Float, 0.320 as Float, 0.346 as Float, 0.365 as Float, 0.376 as Float, 0.392 as Float, 0.403 as Float, 0.416 as Float, 0.434 as Float, 0.444 as Float, 0.457 as Float, 0.473 as Float, 0.484 as Float, 0.502 as Float, 0.517 as Float, 0.528 as Float, 0.667 as Float, 0.668 as Float, 0.671 as Float, 1.000 as Float]
		boddiPrincipalTranslationXAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, instantTiming, instantTiming, easeOutTiming, linearTiming]
		boddiPrincipalTranslationXAnimation.beginTime = beginTime
		boddiPrincipalTranslationXAnimation.fillMode = fillMode
		boddiPrincipalTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationXAnimation, forKey:"appearHappy_TranslationX")

		let boddiPrincipalTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		boddiPrincipalTranslationYAnimation.duration = 1.700
		boddiPrincipalTranslationYAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.000 as Float, -3.214 as Float, -6.490 as Float, -11.413 as Float, -16.330 as Float, -26.170 as Float, -32.728 as Float, -40.927 as Float, -44.209 as Float, -45.844 as Float, -49.673 as Float, -48.032 as Float, -45.844 as Float, -42.568 as Float, -39.286 as Float, -31.087 as Float, -27.811 as Float, -24.529 as Float, -17.971 as Float, -14.689 as Float, -9.772 as Float, -5.943 as Float, -4.308 as Float, -2.667 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float]
		boddiPrincipalTranslationYAnimation.keyTimes = [0.000 as Float, 0.004 as Float, 0.004 as Float, 0.151 as Float, 0.152 as Float, 0.162 as Float, 0.176 as Float, 0.192 as Float, 0.205 as Float, 0.224 as Float, 0.238 as Float, 0.247 as Float, 0.258 as Float, 0.287 as Float, 0.365 as Float, 0.376 as Float, 0.392 as Float, 0.403 as Float, 0.416 as Float, 0.434 as Float, 0.444 as Float, 0.457 as Float, 0.473 as Float, 0.484 as Float, 0.502 as Float, 0.517 as Float, 0.528 as Float, 0.542 as Float, 0.667 as Float, 0.668 as Float, 0.671 as Float, 1.000 as Float]
		boddiPrincipalTranslationYAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, instantTiming, instantTiming, easeOutTiming, linearTiming]
		boddiPrincipalTranslationYAnimation.beginTime = beginTime
		boddiPrincipalTranslationYAnimation.fillMode = fillMode
		boddiPrincipalTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationYAnimation, forKey:"appearHappy_TranslationY")
	}

	func removeAppearHappyAnimation() {
		self.layer.removeAnimationForKey("AppearHappy")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappy_Rotation")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappy_Opacity")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappy_TranslationX")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappy_TranslationY")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearHappy_Opacity")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearHappy_TranslationX")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearHappy_TranslationY")
	}

	// - MARK: appearHappyJump

	func addAppearHappyJumpAnimation() {
		addAppearHappyJumpAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
	}

	func addAppearHappyJumpAnimation(completion: ((Bool) -> Void)?) {
		addAppearHappyJumpAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
	}

	func addAppearHappyJumpAnimation(removedOnCompletion removedOnCompletion: Bool) {
		addAppearHappyJumpAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
	}

	func addAppearHappyJumpAnimation(removedOnCompletion removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		addAppearHappyJumpAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
	}

	func addAppearHappyJumpAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		let overshootTiming = CAMediaTimingFunction(controlPoints: 0.00, 0.00, 0.58, 1.30)
		let easeInTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
		let instantTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
		let easeOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		let easeInOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		let anticipateTiming = CAMediaTimingFunction(controlPoints: 0.42, -0.30, 1.00, 1.00)
		if let complete = completion {
			let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
			representativeAnimation.duration = 2.270
			representativeAnimation.delegate = self
			self.layer.addAnimation(representativeAnimation, forKey: "AppearHappyJump")
			self.animationCompletions[layer.animationForKey("AppearHappyJump")!] = complete
		}

		let boddiFelizRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		boddiFelizRotationAnimation.duration = 2.270
		boddiFelizRotationAnimation.values = [0.000 as Float, 0.000 as Float, 0.137 as Float, -0.140 as Float, 0.140 as Float, 0.000 as Float, 0.000 as Float]
		boddiFelizRotationAnimation.keyTimes = [0.000 as Float, 0.502 as Float, 0.577 as Float, 0.639 as Float, 0.683 as Float, 0.749 as Float, 1.000 as Float]
		boddiFelizRotationAnimation.timingFunctions = [easeOutTiming, easeOutTiming, anticipateTiming, easeOutTiming, easeInOutTiming, linearTiming]
		boddiFelizRotationAnimation.beginTime = beginTime
		boddiFelizRotationAnimation.fillMode = fillMode
		boddiFelizRotationAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizRotationAnimation, forKey:"appearHappyJump_Rotation")

		let boddiFelizOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		boddiFelizOpacityAnimation.duration = 2.270
		boddiFelizOpacityAnimation.values = [0.000 as Float, 0.000 as Float, 1.000 as Float, 1.000 as Float]
		boddiFelizOpacityAnimation.keyTimes = [0.000 as Float, 0.502 as Float, 0.502 as Float, 1.000 as Float]
		boddiFelizOpacityAnimation.timingFunctions = [instantTiming, instantTiming, linearTiming]
		boddiFelizOpacityAnimation.beginTime = beginTime
		boddiFelizOpacityAnimation.fillMode = fillMode
		boddiFelizOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizOpacityAnimation, forKey:"appearHappyJump_Opacity")

		let boddiFelizTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		boddiFelizTranslationXAnimation.duration = 2.270
		boddiFelizTranslationXAnimation.values = [0.000 as Float, -5.034 as Float, -5.034 as Float]
		boddiFelizTranslationXAnimation.keyTimes = [0.000 as Float, 0.502 as Float, 1.000 as Float]
		boddiFelizTranslationXAnimation.timingFunctions = [easeOutTiming, linearTiming]
		boddiFelizTranslationXAnimation.beginTime = beginTime
		boddiFelizTranslationXAnimation.fillMode = fillMode
		boddiFelizTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizTranslationXAnimation, forKey:"appearHappyJump_TranslationX")

		let boddiFelizTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		boddiFelizTranslationYAnimation.duration = 2.270
		boddiFelizTranslationYAnimation.values = [0.000 as Float, -1.217 as Float, -7.031 as Float, -59.673 as Float, -1.000 as Float, -10.000 as Float]
		boddiFelizTranslationYAnimation.keyTimes = [0.000 as Float, 0.502 as Float, 0.749 as Float, 0.837 as Float, 0.916 as Float, 1.000 as Float]
		boddiFelizTranslationYAnimation.timingFunctions = [easeOutTiming, easeOutTiming, easeInOutTiming, easeInTiming, overshootTiming]
		boddiFelizTranslationYAnimation.beginTime = beginTime
		boddiFelizTranslationYAnimation.fillMode = fillMode
		boddiFelizTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_feliz"]?.layer.addAnimation(boddiFelizTranslationYAnimation, forKey:"appearHappyJump_TranslationY")

		let boddiPrincipalOpacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
		boddiPrincipalOpacityAnimation.duration = 2.270
		boddiPrincipalOpacityAnimation.values = [1.000 as Float, 1.000 as Float, 0.000 as Float, 0.000 as Float]
		boddiPrincipalOpacityAnimation.keyTimes = [0.000 as Float, 0.502 as Float, 0.502 as Float, 1.000 as Float]
		boddiPrincipalOpacityAnimation.timingFunctions = [instantTiming, instantTiming, linearTiming]
		boddiPrincipalOpacityAnimation.beginTime = beginTime
		boddiPrincipalOpacityAnimation.fillMode = fillMode
		boddiPrincipalOpacityAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalOpacityAnimation, forKey:"appearHappyJump_Opacity")

		let boddiPrincipalTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		boddiPrincipalTranslationXAnimation.duration = 2.270
		boddiPrincipalTranslationXAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.000 as Float, -1.641 as Float, -4.917 as Float, -9.840 as Float, -21.315 as Float, -29.514 as Float, -45.912 as Float, -52.469 as Float, -62.309 as Float, -84.718 as Float, -107.674 as Float, -119.155 as Float, -130.630 as Float, -151.951 as Float, -169.983 as Float, -178.182 as Float, -183.105 as Float, -189.663 as Float, -201.138 as Float, -207.702 as Float, -212.619 as Float, -219.177 as Float, -222.459 as Float, -227.376 as Float, -231.205 as Float, -232.840 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float]
		boddiPrincipalTranslationXAnimation.keyTimes = [0.000 as Float, 0.003 as Float, 0.003 as Float, 0.121 as Float, 0.122 as Float, 0.132 as Float, 0.144 as Float, 0.153 as Float, 0.168 as Float, 0.178 as Float, 0.185 as Float, 0.193 as Float, 0.215 as Float, 0.222 as Float, 0.232 as Float, 0.240 as Float, 0.259 as Float, 0.274 as Float, 0.282 as Float, 0.294 as Float, 0.302 as Float, 0.312 as Float, 0.325 as Float, 0.333 as Float, 0.342 as Float, 0.354 as Float, 0.362 as Float, 0.376 as Float, 0.387 as Float, 0.395 as Float, 0.500 as Float, 0.500 as Float, 0.502 as Float, 1.000 as Float]
		boddiPrincipalTranslationXAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, instantTiming, instantTiming, easeOutTiming, linearTiming]
		boddiPrincipalTranslationXAnimation.beginTime = beginTime
		boddiPrincipalTranslationXAnimation.fillMode = fillMode
		boddiPrincipalTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationXAnimation, forKey:"appearHappyJump_TranslationX")

		let boddiPrincipalTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		boddiPrincipalTranslationYAnimation.duration = 2.270
		boddiPrincipalTranslationYAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.000 as Float, -3.214 as Float, -6.490 as Float, -11.413 as Float, -16.330 as Float, -26.170 as Float, -32.728 as Float, -40.927 as Float, -44.209 as Float, -45.844 as Float, -49.673 as Float, -48.032 as Float, -45.844 as Float, -42.568 as Float, -39.286 as Float, -31.087 as Float, -27.811 as Float, -24.529 as Float, -17.971 as Float, -14.689 as Float, -9.772 as Float, -5.943 as Float, -4.308 as Float, -2.667 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float]
		boddiPrincipalTranslationYAnimation.keyTimes = [0.000 as Float, 0.003 as Float, 0.003 as Float, 0.113 as Float, 0.114 as Float, 0.122 as Float, 0.132 as Float, 0.144 as Float, 0.153 as Float, 0.168 as Float, 0.178 as Float, 0.185 as Float, 0.193 as Float, 0.215 as Float, 0.274 as Float, 0.282 as Float, 0.294 as Float, 0.302 as Float, 0.312 as Float, 0.325 as Float, 0.333 as Float, 0.342 as Float, 0.354 as Float, 0.362 as Float, 0.376 as Float, 0.387 as Float, 0.395 as Float, 0.406 as Float, 0.500 as Float, 0.500 as Float, 0.502 as Float, 1.000 as Float]
		boddiPrincipalTranslationYAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, instantTiming, instantTiming, easeOutTiming, linearTiming]
		boddiPrincipalTranslationYAnimation.beginTime = beginTime
		boddiPrincipalTranslationYAnimation.fillMode = fillMode
		boddiPrincipalTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationYAnimation, forKey:"appearHappyJump_TranslationY")
	}

	func removeAppearHappyJumpAnimation() {
		self.layer.removeAnimationForKey("AppearHappyJump")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappyJump_Rotation")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappyJump_Opacity")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappyJump_TranslationX")
		self.viewsByName["boddi_feliz"]?.layer.removeAnimationForKey("appearHappyJump_TranslationY")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearHappyJump_Opacity")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearHappyJump_TranslationX")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearHappyJump_TranslationY")
	}

	// - MARK: appearNormal

	func addAppearNormalAnimation() {
		addAppearNormalAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
	}

	func addAppearNormalAnimation(completion: ((Bool) -> Void)?) {
		addAppearNormalAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
	}

	func addAppearNormalAnimation(removedOnCompletion removedOnCompletion: Bool) {
		addAppearNormalAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
	}

	func addAppearNormalAnimation(removedOnCompletion removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		addAppearNormalAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
	}

	func addAppearNormalAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		let easeOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		let overshootTiming = CAMediaTimingFunction(controlPoints: 0.00, 0.00, 0.58, 1.30)
		let easeInTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
		let instantTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
		if let complete = completion {
			let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
			representativeAnimation.duration = 2.753
			representativeAnimation.delegate = self
			self.layer.addAnimation(representativeAnimation, forKey: "AppearNormal")
			self.animationCompletions[layer.animationForKey("AppearNormal")!] = complete
		}

		let boddiPrincipalRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		boddiPrincipalRotationAnimation.duration = 2.753
		boddiPrincipalRotationAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.140 as Float, -0.140 as Float, 0.140 as Float, -0.035 as Float, -0.035 as Float, 0.105 as Float, -0.035 as Float]
		boddiPrincipalRotationAnimation.keyTimes = [0.000 as Float, 0.413 as Float, 0.413 as Float, 0.476 as Float, 0.527 as Float, 0.563 as Float, 0.618 as Float, 0.654 as Float, 0.817 as Float, 1.000 as Float]
		boddiPrincipalRotationAnimation.timingFunctions = [instantTiming, instantTiming, easeOutTiming, easeInTiming, easeOutTiming, overshootTiming, easeOutTiming, easeOutTiming, easeInTiming]
		boddiPrincipalRotationAnimation.beginTime = beginTime
		boddiPrincipalRotationAnimation.fillMode = fillMode
		boddiPrincipalRotationAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalRotationAnimation, forKey:"appearNormal_Rotation")

		let boddiPrincipalTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		boddiPrincipalTranslationXAnimation.duration = 2.753
		boddiPrincipalTranslationXAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.000 as Float, -1.641 as Float, -4.917 as Float, -9.840 as Float, -21.315 as Float, -29.514 as Float, -45.912 as Float, -52.469 as Float, -62.309 as Float, -84.718 as Float, -107.674 as Float, -119.155 as Float, -130.630 as Float, -151.951 as Float, -169.983 as Float, -178.182 as Float, -183.105 as Float, -189.663 as Float, -201.138 as Float, -207.702 as Float, -212.619 as Float, -219.177 as Float, -222.459 as Float, -227.376 as Float, -231.205 as Float, -232.840 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float, -234.481 as Float]
		boddiPrincipalTranslationXAnimation.keyTimes = [0.000 as Float, 0.002 as Float, 0.003 as Float, 0.100 as Float, 0.100 as Float, 0.109 as Float, 0.118 as Float, 0.126 as Float, 0.138 as Float, 0.147 as Float, 0.153 as Float, 0.159 as Float, 0.177 as Float, 0.183 as Float, 0.191 as Float, 0.198 as Float, 0.214 as Float, 0.226 as Float, 0.232 as Float, 0.242 as Float, 0.249 as Float, 0.257 as Float, 0.268 as Float, 0.274 as Float, 0.282 as Float, 0.292 as Float, 0.299 as Float, 0.310 as Float, 0.319 as Float, 0.326 as Float, 0.412 as Float, 0.412 as Float, 0.414 as Float, 1.000 as Float]
		boddiPrincipalTranslationXAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, instantTiming, instantTiming, easeOutTiming, linearTiming]
		boddiPrincipalTranslationXAnimation.beginTime = beginTime
		boddiPrincipalTranslationXAnimation.fillMode = fillMode
		boddiPrincipalTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationXAnimation, forKey:"appearNormal_TranslationX")

		let boddiPrincipalTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		boddiPrincipalTranslationYAnimation.duration = 2.753
		boddiPrincipalTranslationYAnimation.values = [0.000 as Float, 0.000 as Float, 0.000 as Float, 0.000 as Float, -3.214 as Float, -6.490 as Float, -11.413 as Float, -16.330 as Float, -26.170 as Float, -32.728 as Float, -40.927 as Float, -44.209 as Float, -45.844 as Float, -49.673 as Float, -48.032 as Float, -45.844 as Float, -42.568 as Float, -39.286 as Float, -31.087 as Float, -27.811 as Float, -24.529 as Float, -17.971 as Float, -14.689 as Float, -9.772 as Float, -5.943 as Float, -4.308 as Float, -2.667 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float, -1.026 as Float]
		boddiPrincipalTranslationYAnimation.keyTimes = [0.000 as Float, 0.002 as Float, 0.003 as Float, 0.094 as Float, 0.094 as Float, 0.100 as Float, 0.109 as Float, 0.118 as Float, 0.126 as Float, 0.138 as Float, 0.147 as Float, 0.153 as Float, 0.159 as Float, 0.177 as Float, 0.226 as Float, 0.232 as Float, 0.242 as Float, 0.249 as Float, 0.257 as Float, 0.268 as Float, 0.274 as Float, 0.282 as Float, 0.292 as Float, 0.299 as Float, 0.310 as Float, 0.319 as Float, 0.326 as Float, 0.335 as Float, 0.412 as Float, 0.412 as Float, 0.414 as Float, 1.000 as Float]
		boddiPrincipalTranslationYAnimation.timingFunctions = [instantTiming, instantTiming, instantTiming, instantTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, linearTiming, instantTiming, instantTiming, easeOutTiming, linearTiming]
		boddiPrincipalTranslationYAnimation.beginTime = beginTime
		boddiPrincipalTranslationYAnimation.fillMode = fillMode
		boddiPrincipalTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationYAnimation, forKey:"appearNormal_TranslationY")
	}

	func removeAppearNormalAnimation() {
		self.layer.removeAnimationForKey("AppearNormal")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearNormal_Rotation")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearNormal_TranslationX")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("appearNormal_TranslationY")
	}

	// - MARK: normalCycle

	func addNormalCycleAnimation() {
		addNormalCycleAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: nil)
	}

	func addNormalCycleAnimation(completion: ((Bool) -> Void)?) {
		addNormalCycleAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false, completion: completion)
	}

	func addNormalCycleAnimation(removedOnCompletion removedOnCompletion: Bool) {
		addNormalCycleAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: nil)
	}

	func addNormalCycleAnimation(removedOnCompletion removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		addNormalCycleAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion, completion: completion)
	}

	func addNormalCycleAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool, completion: ((Bool) -> Void)?) {
		let easeInOutTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		if let complete = completion {
			let representativeAnimation = CABasicAnimation(keyPath: "not.a.real.key")
			representativeAnimation.duration = 4.000
			representativeAnimation.delegate = self
			self.layer.addAnimation(representativeAnimation, forKey: "NormalCycle")
			self.animationCompletions[layer.animationForKey("NormalCycle")!] = complete
		}

		let boddiPrincipalRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
		boddiPrincipalRotationAnimation.duration = 4.000
		boddiPrincipalRotationAnimation.values = [-0.035 as Float, 0.105 as Float, -0.035 as Float]
		boddiPrincipalRotationAnimation.keyTimes = [0.000 as Float, 0.406 as Float, 1.000 as Float]
		boddiPrincipalRotationAnimation.timingFunctions = [easeInOutTiming, easeInOutTiming]
		boddiPrincipalRotationAnimation.autoreverses = true
		boddiPrincipalRotationAnimation.repeatCount = HUGE
		boddiPrincipalRotationAnimation.beginTime = beginTime
		boddiPrincipalRotationAnimation.fillMode = fillMode
		boddiPrincipalRotationAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalRotationAnimation, forKey:"normalCycle_Rotation")

		let boddiPrincipalTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		boddiPrincipalTranslationXAnimation.duration = 4.000
		boddiPrincipalTranslationXAnimation.values = [-234.481 as Float, -234.481 as Float]
		boddiPrincipalTranslationXAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		boddiPrincipalTranslationXAnimation.timingFunctions = [linearTiming]
		boddiPrincipalTranslationXAnimation.beginTime = beginTime
		boddiPrincipalTranslationXAnimation.fillMode = fillMode
		boddiPrincipalTranslationXAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationXAnimation, forKey:"normalCycle_TranslationX")

		let boddiPrincipalTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		boddiPrincipalTranslationYAnimation.duration = 4.000
		boddiPrincipalTranslationYAnimation.values = [-1.026 as Float, -1.026 as Float]
		boddiPrincipalTranslationYAnimation.keyTimes = [0.000 as Float, 1.000 as Float]
		boddiPrincipalTranslationYAnimation.timingFunctions = [linearTiming]
		boddiPrincipalTranslationYAnimation.beginTime = beginTime
		boddiPrincipalTranslationYAnimation.fillMode = fillMode
		boddiPrincipalTranslationYAnimation.removedOnCompletion = removedOnCompletion
		self.viewsByName["boddi_principal"]?.layer.addAnimation(boddiPrincipalTranslationYAnimation, forKey:"normalCycle_TranslationY")
	}

	func removeNormalCycleAnimation() {
		self.layer.removeAnimationForKey("NormalCycle")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("normalCycle_Rotation")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("normalCycle_TranslationX")
		self.viewsByName["boddi_principal"]?.layer.removeAnimationForKey("normalCycle_TranslationY")
	}

	override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
		if let completion = self.animationCompletions[anim] {
			self.animationCompletions.removeValueForKey(anim)
			completion(flag)
		}
	}

	func removeAllAnimations() {
		for subview in viewsByName.values {
			subview.layer.removeAllAnimations()
		}
		self.layer.removeAnimationForKey("AppearNormal")
		self.layer.removeAnimationForKey("AppearHappy")
		self.layer.removeAnimationForKey("AppearHappyJump")
		self.layer.removeAnimationForKey("NormalCycle")
	}
}