//
//  TableViewController.swift
//  B10715027_HW2
//
//  Created by mac10 on 2021/3/18.
//  Copyright © 2021 mac10. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var names = ["711" , "g8dog" , "facebook" , "google" , "twitter" , "firefox" , "youtube"]
    var imgs = ["711_icon" , "g8dog_icon" , "fb_icon" , "google_icon" , "twitter_icon" , "firefox_icon" , "youtube_icon"]
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    var isAdd = true
    var Btnclicked = false
    var usingAdd = false
    var usingDel = false
    @IBAction func addAction(_ sender: UIButton) {
        if usingDel {
            addBtn.setTitle("新增", for: .normal)
        }else{
            usingAdd = true
            if Btnclicked {
                tableView.isEditing = false
                addBtn.setTitle("新增", for: .normal)
                Btnclicked = false
                usingAdd = false
            }
            else{
                isAdd = true
                tableView.isEditing = true
                addBtn.setTitle("返回", for: .normal)
                Btnclicked = true
            }
        }
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        if usingAdd {
            deleteBtn.setTitle("刪除", for: .normal)
        }else{
            usingDel = true
            if Btnclicked {
                tableView.isEditing = false
                deleteBtn.setTitle("刪除", for: .normal)
                Btnclicked = false
                usingDel = false
            }
            else{
                isAdd = false
                tableView.isEditing = true
                deleteBtn.setTitle("返回", for: .normal)
                Btnclicked = true
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if isAdd {
            return .insert
        }
        else{
            return .delete
        }
    }
   /* override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        deleteBtn.setTitle("刪除", for: .normal)
        addBtn.setTitle("新增", for: .normal)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首頁"
        addBtn.titleLabel?.text = "新增"
        deleteBtn.titleLabel?.text = "刪除"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(named: imgs[indexPath.row])
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VC") as? ViewController{
            vc.labelName = names[indexPath.row]
            vc.iconName = imgs[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            names.remove(at: indexPath.row)
            imgs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            names.insert(names[indexPath.row], at: indexPath.row)
            imgs.insert(imgs[indexPath.row], at: indexPath.row + 1)
            tableView.insertRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let tmp = names[fromIndexPath.row]
        names.remove(at: fromIndexPath.row)
        names.insert(tmp, at: to.row)

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
