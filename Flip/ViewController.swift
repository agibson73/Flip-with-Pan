//
//  ViewController.swift
//  Flip
//
//  Created by Alex Gibson on 1/15/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var flipViewBlue: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "flipView:")
       
        self.view.addGestureRecognizer(panGesture)
      
        let trans = CATransform3DIdentity
        greenView.layer.anchorPoint = CGPointMake(0.5, 0.5)
        greenView.layer.transform = CATransform3DRotate(trans, self.degreesToRadian(180), 0, 1, 0)
        //self.flipViewBlue.alpha = 0
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flipView(sender:UIPanGestureRecognizer){
       

        let dragPoint = sender.locationInView(self.view)
        let width = self.view.bounds.width
        let change = width - dragPoint.x
        let degreePercentage : CGFloat = (change / width)

        if sender.state == UIGestureRecognizerState.Began{
            self.container.layer.anchorPoint = CGPointMake(0.5, 0.5)
            self.greenView.layer.anchorPoint = CGPointMake(0.5, 0.5)
        }
            if sender.state == UIGestureRecognizerState.Changed{
                
                if degreePercentage > 0.5{
                    self.flipViewBlue.layer.zPosition = 1
                    self.greenView.layer.zPosition = 5
                }
                else{
                    self.flipViewBlue.layer.zPosition = 5
                    self.greenView.layer.zPosition = 1
                }
               
                let degress = self.degreesToRadian(CGFloat(180) * degreePercentage)
          
                
                let rotateTransform = CATransform3DIdentity
                self.container.layer.transform = CATransform3DRotate(rotateTransform, degress, 0, 1, 0)
                
            }
            else{
                if degreePercentage > 0.5{
                    let duration = Double(1.0 - degreePercentage)

                    let degress = self.degreesToRadian(CGFloat(180) * 1)

                  let rotateTransform = CATransform3DIdentity
                    UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        
                        self.container.layer.transform = CATransform3DRotate(rotateTransform, degress, 0, 1, 0)
                        }, completion: {
                            finished in
                    })
                    
                }
                else{
                    let duration = Double(degreePercentage)
      
                    let degress = self.degreesToRadian(CGFloat(180) * 0)
                    
                    let rotateTransform = CATransform3DIdentity
                    UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                        
                        self.container.layer.transform = CATransform3DRotate(rotateTransform, degress, 0, 1, 0)
                        }, completion: {
                            finished in
                    })
                    

                }
            }
        }
    
    
    
    func degreesToRadian(x:CGFloat)->CGFloat{
        return CGFloat(M_PI) * CGFloat(x) / CGFloat(180.0)
    }


}

