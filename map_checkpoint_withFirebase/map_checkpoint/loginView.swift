//
//  loginView.swift
//  map_checkpoint
//
//  Created by rubl333 on 2016/7/2.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class loginView: UIViewController {

    @IBOutlet weak var nickName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let v2 = segue.destinationViewController as! explanationView
        v2.nickName = self.nickName.text!
        
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
