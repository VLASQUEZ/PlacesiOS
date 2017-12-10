//
//  ReviewViewController.swift
//  MisRecetas
//
//  Created by Andres on 5/11/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    var ratingSelected : String?
    @IBOutlet var ratingStackView: UIStackView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    
    @IBOutlet var greatBtn: UIButton!
    @IBOutlet var goodBtn: UIButton!
    @IBOutlet var dislikeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect : blurEffect)
        blurEffectView.frame = view.bounds
        
        backgroundImageView.addSubview(blurEffectView)
        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let translation = CGAffineTransform(translationX: 0.0, y: 500.0)

        self.greatBtn.transform = scale.concatenating(translation)
        self.goodBtn.transform = scale.concatenating(translation)
        self.dislikeBtn.transform = scale.concatenating(translation)

        
        //self.ratingStackView.transform  = scale.concatenating(translation)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [], animations: {
            //self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.greatBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { (success) in
                UIView.animate(withDuration: 2.0, delay: 0.0, options: [], animations: {
                    //self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.goodBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: {(success) in
                    UIView.animate(withDuration: 2.0, delay: 0.0, options: [], animations: {
                        //self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.dislikeBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: {(success) in
                    })
                })
            })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ratingPress(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            ratingSelected = "great"
            break
        case 2:
            ratingSelected = "good"
            break
        case 3:
            ratingSelected = "dislike"
            break
        default:
            break
        }
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
