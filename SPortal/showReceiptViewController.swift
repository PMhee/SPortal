//
//  showReceiptViewController.swift
//  SPortal
//
//  Created by Tanakorn on 4/4/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class showReceiptViewController: UIViewController {

    @IBOutlet var price: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var price1: UILabel!
    @IBOutlet var priceTotal: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var logo: UIImageView!
    
    var user : Receipt!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.user)
        self.name.text = self.user.name
        self.place.text = self.user.place
        self.price.text = String(self.user.price) + " THB"
        self.price1.text = String(self.user.price)
        self.priceTotal.text = String(self.user.price)
        self.date.text = (self.user.date).substringWithRange(Range<String.Index>(start: (self.user.date).startIndex.advancedBy(0), end: (self.user.date).endIndex.advancedBy(-14))) + " "+(self.user.date).substringWithRange(Range<String.Index>(start: (self.user.date).startIndex.advancedBy(11), end: (self.user.date).endIndex.advancedBy(-8)))
        self.type.text = self.user.type
        logo.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
