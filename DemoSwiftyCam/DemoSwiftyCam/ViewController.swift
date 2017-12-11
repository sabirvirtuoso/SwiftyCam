/*Copyright (c) 2016, Andrew Walz.

Redistribution and use in source and binary forms, with or without modification,are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

import UIKit

public class ViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var flipCamera: UIButton!
    @IBOutlet weak var flash: UIButton!
    @IBOutlet weak var event: UIButton!
    
    @IBOutlet weak var capture: UIVisualEffectView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        setButtonsImage()
        capture.layer.cornerRadius = capture.frame.height / 2.0
        capture.clipsToBounds = true
        capture.layer.borderWidth = 5.0
        capture.layer.borderColor = UIColor.white.cgColor
    }
    
    public func setButtonsImage() {
        /*
        let cameraImage = UIImage(named: "icon_capture")!//.resizeImageWith(newSize: fixedCameraIconSize())
        let swapImage = UIImage(named: "icon_camera_rotate")!//.resizeImageWith(newSize: fixedIconSize())
        let eventImage = UIImage(named: "icon_gallery")!//.resizeImageWith(newSize: fixedCameraIconSize())
        let flashImage = UIImage(named: "icon_flash_off")!//.resizeImageWith(newSize: CGSize(width: 20, height: 20))
        
        flipCamera.setImage(swapImage, for: .normal)
        event.setImage(eventImage, for: .normal)
        flash.setImage(flashImage, for: .normal)
        capture.setImage(cameraImage, for: .normal)
 */
    }

	public override var prefersStatusBarHidden: Bool {
		return true
	}

	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	public func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        
    }

	public func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
		let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
		focusView.center = point
		focusView.alpha = 0.0
		view.addSubview(focusView)

		UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
			focusView.alpha = 1.0
			focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
		}, completion: { (success) in
			UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
				focusView.alpha = 0.0
				focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
			}, completion: { (success) in
				focusView.removeFromSuperview()
			})
		})
	}

	public func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
		print(zoom)
	}

	public func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
		print(camera)
	}
    
    public func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }

    @IBAction func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    
    @IBAction func toggleFlashTapped(_ sender: Any) {
        flashEnabled = !flashEnabled
        
        /*
        if flashEnabled == true {
            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
        } else {
            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
        }*/
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popOverViewController = segue.destination
        popOverViewController.popoverPresentationController?.delegate = self
        popOverViewController.popoverPresentationController?.sourceRect = CGRect(x:-capture.frame.width+5, y: -2, width:200, height: 40)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

