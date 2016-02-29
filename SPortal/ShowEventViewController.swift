//
//  ShowEventViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/27/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class ShowEventViewController: UIViewController {
    @IBOutlet weak var name: UIButton!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    var showEvent:DataToPass!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.setTitle(showEvent.author, forState: .Normal)
        self.place.setTitle(showEvent.place, forState: .Normal)
        self.price.text = showEvent.price
        self.date.text = showEvent.date
        self.type.text = showEvent.type
        self.time.text = showEvent.time
        image.image = UIImage(named: showEvent.image)
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
