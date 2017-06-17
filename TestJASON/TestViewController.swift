//
//  TestViewController.swift
//  Learning JSON
//
//  Created by BBC on 13/05/17.
//  Copyright © 2017 com.bbc.test. All rights reserved.
//

import UIKit
import UserNotifications

class TestViewController: UIViewController {
    @IBOutlet weak var mySwitch: UISwitch!
    @IBAction func mySwitchAction(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if mySwitch.isOn {
            defaults.set(true, forKey: "mySwitch")
            print(defaults.value(forKey: "mySwitch") as! Bool)
        }
        else {
            defaults.set(false, forKey: "mySwitch")
            print(defaults.value(forKey: "mySwitch") as! Bool)

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "mySwitch") != nil {
            print("userDefaults is already there")
            mySwitch.isOn = defaults.value(forKey: "mySwitch") as! Bool
            print("switch enabled as per data")
        }
        else {
            mySwitch.isOn = false
            print("default off switch enabled")
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (bool, error) in
            
        }
        self.view.backgroundColor = UIColor.brown
        
        let myView = UIView()
        myView.frame = CGRect(x: 30, y: 100, width: 300, height: 200)
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = UIColor.white
        //myView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        self.view.addSubview(myView)
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 30, y: 120, width: 150, height: 20)
        //myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "Demo Text"
        myLabel.textAlignment = .center
        myLabel.backgroundColor = UIColor.yellow
        //myView.addSubview(myLabel)
        self.view.addSubview(myLabel)
        
        
        
        let myButton = UIButton(type: .roundedRect)
        myButton.frame = CGRect(x: 30, y: 150, width: 150, height: 20)
        myButton.setTitle("Alert", for: .normal)
        myButton.backgroundColor = UIColor.green
        myButton.addTarget(self, action: #selector(TestViewController.myAlert), for: .touchUpInside)
        self.view.addSubview(myButton)
        
        
        // Do any additional setup after loading the view.
    }
    
    func myAlert() {
        print("clicked")
        
        let alert = UIAlertController(title: "Warning", message: "This is a warning message", preferredStyle: .alert)
        
        let actions = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actions)
        self.present(alert, animated: true, completion: nil)
        myNotification()
        
    }
    
    func myNotification() {
        let noti = UNMutableNotificationContent()
        noti.title = "Local Notification"
        noti.subtitle = "Message"
        noti.body = "this is a local notification test"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "myNoti", content: noti, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
