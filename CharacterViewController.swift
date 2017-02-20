//
//  CharacterViewController.swift
//  CLPS
//
//  Created by 瀚 段 on 17/2/16.
//  Copyright © 2017年 瀚 段. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    @IBOutlet weak var CHA1Label: UILabel!
    @IBOutlet weak var CHA2Label: UILabel!
    @IBOutlet weak var CHA3Label: UILabel!
    @IBOutlet weak var CHA4Label: UILabel!
    @IBOutlet weak var CHA5Label: UILabel!
    

    
    @IBOutlet weak var LabelDesctription: UILabel!
    
    
    let maxWidth = 280.0

    
    override func viewDidLoad() {
        
     

        super.viewDidLoad()
        
               let OC = OCwithCLIPS()
        for cmdStr in MyGlobal.arrayofQuestions {
            OC?.sendCLIPScommond(cmdStr)
        }
        OC?.generateFact()
        
                let  arr : NSMutableArray = (OC?.characterList)!
                print(arr.count)
        
                for char in  arr {
                    let cha = char as! character
                    print(cha.name)
                    print(cha.certainty)
                }
        CHA1Label.text = "90%"
        CHA2Label.text = "80%"
         CHA3Label.text = "70%"
         CHA4Label.text = "30%"
         CHA5Label.text = "20%"
        
       let btn1 = UIButton(frame: CGRect(x: 69, y: 74, width: CGFloat(0.9*maxWidth), height: 34))
        btn1.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        btn1.setTitle("Relationship Builders", for: UIControlState.normal)
        btn1.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 69, y: 74+50.5, width: CGFloat(0.8*maxWidth), height: 34))
        btn2.backgroundColor = #colorLiteral(red: 0.2703323364, green: 0.7012543082, blue: 1, alpha: 1)
        btn2.setTitle("Reactive Problem Solvers", for: UIControlState.normal)
        btn2.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3 = UIButton(frame: CGRect(x: 69, y: 74+50.5*2, width: CGFloat(0.7*maxWidth), height: 34))
        btn3.backgroundColor = #colorLiteral(red: 0.7155655026, green: 0.9886419177, blue: 0.7473583817, alpha: 1)
        btn3.setTitle("Hard Workers", for: UIControlState.normal)
        btn3.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        let btn4 = UIButton(frame: CGRect(x: 69, y: 74+50.5*3, width: CGFloat(0.3*maxWidth), height: 34))
        btn4.backgroundColor = #colorLiteral(red: 1, green: 0.6768288016, blue: 0.7297707796, alpha: 1)
        btn4.setTitle("Lone Wolves", for: UIControlState.normal)
        btn4.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn4.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(btn4)
        
        let btn5 = UIButton(frame: CGRect(x: 69, y: 74+50.5*4, width: CGFloat(0.2*maxWidth), height: 34))
        btn5.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn5.setTitle("Challengers", for: UIControlState.normal)
        btn5.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn5.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(btn5)
        
 

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showDescription(str:String)->String{
        var str2 = ""
        switch str {
        case "Relationship Builders":
            str2 = str + ":\nfocus on developing strong personal and professional relationships and advocates across the customer organization. They are generous with their time, strive to meet customers' every need, and work hard to resolve tensions in the commercial relationship."
            break
        case "Reactive Problem Solvers":
            str2 = str + ":\nare, from the customers' standpoint, highly reliable and detail-oriented. They focus on post-sales follow-up, ensuring that service issues related to implementation and execution are addressed quickly and thoroughly."
            break
        case "Hard Workers":
            str2 = str + ":\nshow up early, stay late, and always go the extra mile. They'll make more calls in an hour and conduct more visits in a week than just about anyone else on the team."
            break
        case "Lone Wolves":
            str2 = str + ":\nare the deeply self-confident, the rule-breaking cowboys of the sales force who do things their way or not at all. "
            break
        case "Challengers":
            str2 = str + ":\nuse their deep understanding of their customers' business to push their thinking and take control of the sales conversation. They're not afraid to share even potentially controversial views and are assertive—with both their customers and bosses."
            break
        default:
            break
        }
       return str2
        
    }
    @IBAction func restart(_ sender: UIButton) {
           let QRview = (self.storyboard?.instantiateViewController(withIdentifier: "question"))! as UIViewController
        
        self.showDetailViewController(QRview, sender: nil)

        
    }
    func buttonAction(sender: UIButton!) {
        var str = sender.titleLabel?.text
        str = showDescription(str: str!)
        
        LabelDesctription.text = str
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
