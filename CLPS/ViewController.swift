//
//  ViewController.swift
//  CLPS
//
//  Created by 瀚 段 on 17/2/3.
//  Copyright © 2017年 瀚 段. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate{


    
    @IBOutlet weak var ImgA: UIImageView!
    @IBOutlet weak var ImgB: UIImageView!
    @IBOutlet weak var ImgC: UIImageView!
    @IBOutlet weak var ImgD: UIImageView!

    
    @IBOutlet weak var LabelD: UILabel!
    @IBOutlet weak var LabelC: UILabel!
    @IBOutlet weak var LabelB: UILabel!
    @IBOutlet weak var LabelA: UILabel!

    
    @IBOutlet weak var UILableforQuestion: UILabel!
    
    @IBOutlet weak var UILableforOptions: UILabel!
    @IBOutlet weak var ImgApple: UIImageView!
    
    @IBOutlet weak var UIPickerAnswer: UIPickerView!
    @IBOutlet weak var UIBtnPre: UIButton!
    @IBOutlet weak var UIBtnNext: UIButton!
   
    var pickAns = 0
    var pickerData = ["A","B","C","D"]
    var QNum = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIPickerAnswer.dataSource = self
        UIPickerAnswer.delegate = self
        


        UILableforQuestion.text = "Q1.What motivates you most at work? "
        UILableforOptions.text = "A.good team culture, teamwork and relationships\n\nB.achievement and winning\n\nC.helping people \n\nD.implement new things  "
        changeQuestion(index: QNum)
    }
    
    func changeQuestion(index: Int){
        ImgA.isHidden = true
        ImgB.isHidden = true
        ImgC.isHidden = true
        ImgD.isHidden = true
      
        LabelA.isHidden = true
        LabelB.isHidden = true
        LabelC.isHidden = true
        LabelD.isHidden = true
        
        ImgApple.isHidden = true
        
        UILableforOptions.isHidden = true
        
        
        
        switch index {
        case 1:
            UILableforQuestion.text = "Q"+String(index)+".Chose one kind of love by instinct from below："
            ImgA.image = UIImage(named: "love1.png")
            ImgB.image = UIImage(named: "love2.png")
            ImgC.image = UIImage(named: "love3.png")
            ImgD.image = UIImage(named: "love4.png")
            ImgA.isHidden = false
            ImgB.isHidden = false
            ImgC.isHidden = false
            ImgD.isHidden = false
            
            LabelA.isHidden = false
            LabelB.isHidden = false
            LabelC.isHidden = false
            LabelD.isHidden = false
            pickerData = ["A","B","C","D"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 2:
           UILableforQuestion.text = "Q"+String(index)+".What motivates you most at work?"
           UILableforOptions.text = "A.good team culture, teamwork and relationships\n\nB.achievement and winning\n\nC.helping people \n\nD.implement new things  "
           UILableforOptions.isHidden = false
           pickerData = ["A","B","C","D"]
           UIPickerAnswer.reloadComponent(0)
            break
        case 3:
            UILableforQuestion.text = "Q"+String(index)+".How would a former client describe you?"
            UILableforOptions.text = "a.great attention to detail, does a great job at analysing needs and solutions. \n\n b.great guy to be around, loves your personality \n\nc.Very focused and able to move things forward fast. "
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 4:
            UILableforQuestion.text = "Q"+String(index)+".What is your approach to handling customer objections? "
            UILableforOptions.text = "a.keep plowing and pushing the limit  \n\nb.take a step back and try to empathise with them \n\nc.analyse what went wrong and then go back to the customer "
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 5:
            UILableforQuestion.text = "Q"+String(index)+".I perceive myself as: "
            UILableforOptions.text = "a.a person who values a rich emotional life \n\nb.a person with great clarity in thought and analysis\n\nc.a person who is very task-oriented"
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 6:
            UILableforQuestion.text = "Q"+String(index)+".When I meet new people: "
            UILableforOptions.text = "a.I open my heart and put myself out there, and I can quickly build up rapport.\nb.I let things flow naturally, I don't pursue or try actively, if good things happen, great. \nc.I take things slow, and once I trust and like that person as a friend, I will make a long-   term effort to maintain the relationship\nd.I like to quickly get to the point and share how I can benefit their business instead of small talk or beating about the bush."
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c","d"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 7:
            UILableforQuestion.text = "Q"+String(index)+".In the workplace I am generally: "
            UILableforOptions.text = "a.generally expressive with full of passion and ideas.\n\nb.dependable and reliable, quite a perfectionist.\n\nc.decisive and straight to the point, pushing things forward.\n\nd.very calm and patient, very adaptable, coordinates really well."
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c","d"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 8:
            UILableforQuestion.text = "Q"+String(index)+".When I am trying to sell something and the customer says he likes another offering, I"
            UILableforOptions.text = "a.help him do a detailed comparison with other alternatives before making decision \n\nb.tell him that that is indeed good to increase chance of closing the sale. \n\nc.insist on the product recommended before"
            
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 9:
            UILableforQuestion.text = "Q"+String(index)+".In a team meeting or group discussion I prefer to conclude the meeting by:"
            UILableforOptions.text = "a.expressing my own opinion in an original way and leading others to see it from my angle\n\nb.following whatever is best for the team \n\nc.analyzing and weighing both the pros and cons first before taking a stand"
            
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 10:
            UILableforQuestion.text = "Q"+String(index)+".Which situation do you agree most?"
            UILableforOptions.text = "a.i often risk disapproval in order to express beliefs about what is right for the customer \n\nb.when negotiating with customers, I understand what drives value with different customers and adapt my message accordingly \n\nc.I am likely to spend more time on preparation in advance of any sales calls or meetings as compared to everybody else \n\nd.I often share some daily interesting story when having dinner with customers"
            
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c","d"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 11:
            UILableforQuestion.text = "Q"+String(index)+".What is the first thing that comes to your mind when you see the picture below?"
            UILableforOptions.text = "a.An apple  \n\nb.A worm  \n\nc.A knife \n\nd.A butterfly "
            ImgApple.isHidden = false
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c","d"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 12:
            UILableforQuestion.text = "Q"+String(index)+".Which of the following maxim resonates most with you?"
            UILableforOptions.text = "a.I dominante my own destiny without hearing others words \n\nb.A person who does not pay attention to small things, will never succeed big business \n\nc.Good temper is one person’s best costumes in the social"
            
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 13:
            UILableforQuestion.text = "Q"+String(index)+".Suppose you have three samples to sell namely A,B,C of the same product and the quality has been graded as best quality, medium quality and low quality. Which sample would be prioritized and sold first? (assuming the prices are the same for A, B and C.)"
            UILableforOptions.text = "a.A\nb.B\nc.C"
            
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 14:
            UILableforQuestion.text = "Q"+String(index)+".Suppose you are in charge of securing new customers for your firm. Which kind of customers would you prioritize in targeting, given your limited time and resources?        "
            UILableforOptions.text = "a.One single large account with a spending of 100k. \n\nb.10 accounts with a spending of 10k each. \n\nc.Give equal priority to both. \n\nd.Others "
            
            UILableforOptions.isHidden = false
            pickerData = ["a","b","c","d"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 15:
            UILableforQuestion.text = "Q"+String(index)+". I often form enduring and useful relationships with customers."
            UILableforOptions.text = " 1 = Strongly Disagree\n2 = Disagree \n3 = Neutral \n4 = Agree\n5 = Strongly Agree"
            
            UILableforOptions.isHidden = false
            pickerData = ["1","2","3","4","5"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 16:
            UILableforQuestion.text = "Q"+String(index)+". I can effectively discuss pricing and cost concerns with my customers on their own terms."
            UILableforOptions.text = " 1 = Strongly Disagree\n2 = Disagree \n3 = Neutral \n4 = Agree\n5 = Strongly Agree"
            
            UILableforOptions.isHidden = false
            pickerData = ["1","2","3","4","5"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 17:
            UILableforQuestion.text = "Q"+String(index)+".I am likely to spend more time on preparation in advance of any sales calls or meetings as compared to everybody else."
            UILableforOptions.text = " 1 = Strongly Disagree\n2 = Disagree \n3 = Neutral \n4 = Agree\n5 = Strongly Agree"
            
            UILableforOptions.isHidden = false
            pickerData = ["1","2","3","4","5"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 18:
            UILableforQuestion.text = "Q"+String(index)+". When it comes to fulfilling customer requests, I usually resolve everything myself."
            UILableforOptions.text = " 1 = Strongly Disagree\n2 = Disagree \n3 = Neutral \n4 = Agree\n5 = Strongly Agree"
            
            UILableforOptions.isHidden = false
            pickerData = ["1","2","3","4","5"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 19:
            UILableforQuestion.text = "Q"+String(index)+".I can effectively offer my customers a unique perspective, teaching them new insights on how my company’s products and services will improve their business."
            UILableforOptions.text = " 1 = Strongly Disagree\n2 = Disagree \n3 = Neutral \n4 = Agree\n5 = Strongly Agree"
            
            UILableforOptions.isHidden = false
            pickerData = ["1","2","3","4","5"]
            UIPickerAnswer.reloadComponent(0)
            break
        case 20:
            UILableforQuestion.text = "Q"+String(index)+".Which of destinations shown below would suite you the most?(Choose from the below pictures)"
            ImgA.image = UIImage(named: "place1.png")
            ImgB.image = UIImage(named: "place2.png")
            ImgC.image = UIImage(named: "place3.png")
            ImgD.image = UIImage(named: "place4.png")
            ImgA.isHidden = false
            ImgB.isHidden = false
            ImgC.isHidden = false
            ImgD.isHidden = false
            
            LabelA.isHidden = false
            LabelB.isHidden = false
            LabelC.isHidden = false
            LabelD.isHidden = false
            pickerData = ["A","B","C","D"]
            UIPickerAnswer.reloadComponent(0)
            break
        default:
            
            break
        }
        
    }

    @IBAction func clickPrevious(_ sender: UIButton) {
        if (QNum > 1) {
            QNum = QNum-1
            changeQuestion(index: QNum)
        }
        
//        pickerData = ["1","2","3","4","5"]
//        UIPickerAnswer.reloadComponent(0)
    }
    
    @IBAction func clickNext(_ sender: UIButton) {
       // print(self.pickAns)
        let cmd = "(input (questionNum "+String(QNum)+") (inputnum "+String(self.pickAns+1)+"))  "
        MyGlobal.arrayofQuestions[QNum-1] = cmd
        
        if (QNum < 21) {

            QNum = QNum+1
            changeQuestion(index: QNum)
        }
        if QNum>=21 {

            //finish all question
//            for str in MyGlobal.arrayofQuestions
//            {
//                print(str)
//                MyGlobal.cmd += str
//            }
   //         print(MyGlobal.cmd)
            let QRview = (self.storyboard?.instantiateViewController(withIdentifier: "analysis"))! as UIViewController
          
            self.showDetailViewController(QRview, sender: nil)
            
        }
    }
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // myLabel.text = pickerData[row]
        self.pickAns = row
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!,NSForegroundColorAttributeName:UIColor.blue])
        return myTitle
    }

    /* less conservative memory version
     func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
     let pickerLabel = UILabel()
     let titleData = pickerData[row]
     let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
     pickerLabel.attributedText = myTitle
     //color  and center the label's background
     let hue = CGFloat(row)/CGFloat(pickerData.count)
     pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
     pickerLabel.textAlignment = .Center
     return pickerLabel
     }
     */
    
    /* better memory management version */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(pickerData.count*2)
            pickerLabel?.backgroundColor = UIColor(hue: hue, saturation: 0.3, brightness: 1.0, alpha: 1.0)
        }
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        
        return pickerLabel!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

