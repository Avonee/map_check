//
//  explanation explanation explanation explanationView.swift
//  map_checkpoint
//
//  Created by rubl333 on 2016/7/2.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit
import FirebaseDatabase

class explanationView: UIViewController {
var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var nickNameGet: UILabel!
    var nickName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameGet.text = nickName
        // Do any additional setup after loading the view.
        
        self.userDefault.setObject(nickNameGet.text!, forKey: "nickName")
        FIRDatabase.database().reference().child("user").setValue(["uid": nickNameGet.text!])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
