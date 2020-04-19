import UIKit
import UIKit.UIGestureRecognizerSubclass

// https://www.swiftkickmobile.com/building-better-app-animations-swift-uiviewpropertyanimator/

final class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .began {
            return
        }

        super.touchesBegan(touches, with: event)

        self.state = .began
    }
}

private enum State {
    case open
    case closed

    var opposite: State {
        switch self {
        case .open:
            return .closed
        case .closed:
            return .open
        }
    }
}

class ViewController: UIViewController {
    private static let popupOffset: CGFloat = 440

    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        return view
    }()

    private lazy var closedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    private lazy var openTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.alpha = 0
        label.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(translationX: 0, y: -15))
        return label
    }()

    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = InstantPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()

    private var bottomConstraint = NSLayoutConstraint()

    private var transitionAnimator = UIViewPropertyAnimator()

    private var animationProgress: CGFloat = 0

    private var currentState: State = .closed

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemGroupedBackground

        self.layout()
        self.popupView.addGestureRecognizer(self.panRecognizer)
    }

    private func layout() {
        self.view.addSubview(self.overlayView)
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.overlayView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.overlayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.view.addSubview(self.popupView)
        self.popupView.translatesAutoresizingMaskIntoConstraints = false
        self.popupView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.popupView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        self.popupView.addSubview(self.closedTitleLabel)
        self.closedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.closedTitleLabel.leadingAnchor.constraint(equalTo: self.popupView.leadingAnchor).isActive = true
        self.closedTitleLabel.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor).isActive = true
        self.closedTitleLabel.topAnchor.constraint(equalTo: self.popupView.topAnchor, constant: 20).isActive = true

        self.popupView.addSubview(self.openTitleLabel)
        self.openTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.openTitleLabel.leadingAnchor.constraint(equalTo: self.popupView.leadingAnchor).isActive = true
        self.openTitleLabel.trailingAnchor.constraint(equalTo: self.popupView.trailingAnchor).isActive = true
        self.openTitleLabel.topAnchor.constraint(equalTo: self.popupView.topAnchor, constant: 30).isActive = true

        self.bottomConstraint = self.popupView.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor,
            constant: Self.popupOffset
        )
        self.bottomConstraint.isActive = true
        self.popupView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }

    @objc
    private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.animateTransitionIfNeeded(to: self.currentState.opposite, duration: 1)
            self.transitionAnimator.pauseAnimation()
            self.animationProgress = self.transitionAnimator.fractionComplete
        case .changed:
            let translation = recognizer.translation(in: self.popupView)
            var fraction = -translation.y / Self.popupOffset

            if self.currentState == .open {
                fraction *= -1
            }
            if self.transitionAnimator.isReversed {
                fraction *= -1
            }

            self.transitionAnimator.fractionComplete = fraction + self.animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: self.popupView).y
            let shouldClose = yVelocity > 0

            if yVelocity == 0 {
                self.transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }

            switch self.currentState {
            case .open:
                if !shouldClose && !self.transitionAnimator.isReversed {
                    self.transitionAnimator.isReversed = !self.transitionAnimator.isReversed // open card
                }
                if shouldClose && self.transitionAnimator.isReversed {
                    self.transitionAnimator.isReversed = !self.transitionAnimator.isReversed // close card
                }
            case .closed:
                if shouldClose && !self.transitionAnimator.isReversed {
                    self.transitionAnimator.isReversed = !self.transitionAnimator.isReversed // close card
                }
                if !shouldClose && self.transitionAnimator.isReversed {
                    self.transitionAnimator.isReversed = !transitionAnimator.isReversed // open card
                }
            }

            self.transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }

    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        if self.transitionAnimator.isRunning {
            return
        }

        self.transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.popupView.layer.cornerRadius = 20
                self.overlayView.alpha = 0.5
                // animate label
                self.closedTitleLabel.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                    .concatenating(CGAffineTransform(translationX: 0, y: 15))
                self.openTitleLabel.transform = .identity
                self.openTitleLabel.alpha = 1
                self.closedTitleLabel.alpha = 0
            case .closed:
                self.bottomConstraint.constant = Self.popupOffset
                self.popupView.layer.cornerRadius = 0
                self.overlayView.alpha = 0
                // animate label
                self.closedTitleLabel.transform = .identity
                self.openTitleLabel.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
                    .concatenating(CGAffineTransform(translationX: 0, y: -15))
                self.openTitleLabel.alpha = 0
                self.closedTitleLabel.alpha = 1
            }
            self.view.layoutIfNeeded()
        })
        self.transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                break
            @unknown default:
                fatalError("")
            }

            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = Self.popupOffset
            }
        }

        self.transitionAnimator.startAnimation()
    }
}

