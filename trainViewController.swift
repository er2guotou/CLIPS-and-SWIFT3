//
//  trainViewController.swift
//  CLPS
//
//  Created by 瀚 段 on 17/2/28.
//  Copyright © 2017年 瀚 段. All rights reserved.
//

import UIKit

class trainViewController: UIViewController {

    @IBOutlet weak var trainImg1: UIImageView!
    @IBOutlet weak var trainLabel1: UILabel!
    
    @IBOutlet weak var trainImg2: UIImageView!
    @IBOutlet weak var trainLabel2: UILabel!
    
    @IBOutlet weak var trainImg3: UIImageView!
    @IBOutlet weak var trainLabel3: UILabel!
    
    @IBOutlet weak var trainImg4: UIImageView!
     var characterList:[character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trainImg1.isHidden = true
        trainImg2.isHidden = true
        trainImg3.isHidden = true
        trainImg4.isHidden = true
        trainLabel1.isHidden = true
        trainLabel2.isHidden = true
        trainLabel3.isHidden = true
        for cmdStr in MyGlobal.arrayofQuestions2 {
            MyGlobal.OC?.sendCLIPScommond(cmdStr)
        }

        MyGlobal.OC?.generatetrain()
        
        let  arr : NSMutableArray = (MyGlobal.OC?.characterList)!
        let num = arr.count
        print(num)
        for char in  arr {
            let cha = char as! character
            
           // characterList.append(cha)
           
            if(cha.name=="train4")
            {
                trainImg1.isHidden = true
                trainImg2.isHidden = true
                trainImg3.isHidden = true
                trainImg4.isHidden = false
                trainLabel1.isHidden = true
                trainLabel2.isHidden = true
                trainLabel3.isHidden = true
                break
            }
            if(cha.name=="train1")
            {
                trainImg1.isHidden = false
                trainLabel1.isHidden = false

            }
            if(cha.name=="train2")
            {
                trainImg2.isHidden = false
                trainLabel2.isHidden = false
            }
            if(cha.name=="train3")
            {
                trainImg3.isHidden = false
                trainLabel3.isHidden = false
            }
             print(cha.name)
            print(cha.certainty)
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func restart(_ sender: UIButton) {
        MyGlobal.characterTest = true
        let QRview = (self.storyboard?.instantiateViewController(withIdentifier: "question"))! as UIViewController
        
        self.showDetailViewController(QRview, sender: nil)
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
