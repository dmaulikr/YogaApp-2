//
//  HamburgerViewController.swift
//  YogaApp
//
//  Created by Rasheda Babatunde on 9/28/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    
    func slideMenuViewControllerRequestedWithName(_ viewControllerName: String)
}

class HamburgerViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
     let backendless = Backendless.sharedInstance()!
    
    
    @IBOutlet var slideMenuTableView: UITableView!
    
    // Large transparent button to hide the slide menu when the user clicks anyhwere off of the menu.
    @IBOutlet var closeMenuOverlayBtn: UIButton!
    
    struct MenuEntry {
        
        let title: String
        let iconImageName: String
        let viewControllerName: String
    }
    
    // Array containing our menu enties.
    var menuEntries = [MenuEntry]()
    
    // The menu button in the upper-left corner.
    var slideMenuBtn: UIButton!
    
    // Delegate of the MenuViewController
    var delegate: SlideMenuDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        menuEntries.append(MenuEntry(title: "Classes", iconImageName: "one", viewControllerName: "FirstViewController"))
        menuEntries.append(MenuEntry(title: "Mindful Minute", iconImageName: "nutri", viewControllerName: "NutritionViewController"))
        menuEntries.append(MenuEntry(title: "Weekly Pose", iconImageName: "daily", viewControllerName: "DailyPViewController"))
        menuEntries.append(MenuEntry(title: "Contact Me", iconImageName: "three", viewControllerName: "ContactUsViewController"))
        
        slideMenuTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onCloseOverlayBtnClicked(_ button:UIButton!) {
        
        slideMenuBtn.tag = 0
        
        if button != self.closeMenuOverlayBtn {
            switchViewController(button.tag)
        }
        
        closeMenu()
    }
    
    func switchViewController(_ index:Int) {
        
        delegate?.slideMenuViewControllerRequestedWithName(menuEntries[index].viewControllerName)
    }
    
    func closeMenu() {
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            
            }, completion: { (finished) -> Void in
                
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell") as! MenuTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        cell.iconImage.image = UIImage(named: menuEntries[(indexPath as NSIndexPath).row].iconImageName)
        cell.itemLabel.text = menuEntries[(indexPath as NSIndexPath).row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switchViewController((indexPath as NSIndexPath).row)
        closeMenu()
    }
}
