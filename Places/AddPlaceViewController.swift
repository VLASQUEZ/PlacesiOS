//
//  AddPlaceViewController.swift
//  Places
//
//  Created by Andres Velasquez on 24/02/18.
//  Copyright © 2018 Andres Velasquez. All rights reserved.
//

import UIKit
import CoreData

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    var rating : String?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtWebsite: UITextField!
    @IBOutlet weak var btnDislike: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnLovit: UIButton!
    let defaultColor = UIColor(displayP3Red: 236.0/255.0, green: 134.0/255.0, blue: 144.0/255.0, alpha: 1)
    let selectedColor = UIColor.red
    var place : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtName.delegate = self
        self.txtType.delegate = self
        self.txtPhone.delegate = self
        self.txtLocation.delegate = self
        self.txtWebsite.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if let name = self.txtName.text,
            let type = self.txtType.text,
            let location = self.txtLocation.text,
            let phone = self.txtPhone.text,
            let website = self.txtWebsite.text,
            let image = self.imageView.image,
            let rating = self.rating{
            
            //Shared : instancia compartida ak singleton
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                self.place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
                
                self.place?.name = name
                self.place?.type = type
                self.place?.location = location
                self.place?.phone = phone
                self.place?.website = website
                self.place?.rating = rating
                self.place?.image = UIImagePNGRepresentation(image) as NSData?
                do{
                    try context.save()
                }
                catch{
                    print("Ha ocurrido un error " + error.localizedDescription);
                }



                
            }
            self.performSegue(withIdentifier: "unwindToViewController", sender: self)
        }else {
            
            /*
             AlertController para mostrar cuando faltan datos
             */
            let alertController = UIAlertController(title: "No sea bruto faltan datos gonorrea ome gonorrea", message: "Revise esa vaina y no me haga perder el tiempo", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Soy bruto", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.rating = "dislike"
            self.btnDislike.backgroundColor = selectedColor
            self.btnLike.backgroundColor = defaultColor
            self.btnLovit.backgroundColor = defaultColor

        case 2:
            self.rating = "like"
            self.btnDislike.backgroundColor = defaultColor
            self.btnLike.backgroundColor = selectedColor
            self.btnLovit.backgroundColor = defaultColor
        case 3:
            self.rating = "love it"
            self.btnDislike.backgroundColor = defaultColor
            self.btnLike.backgroundColor = defaultColor
            self.btnLovit.backgroundColor = selectedColor
        default:
            break
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //TODO: Gestionar imagen del lugar
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker,animated: true,completion: nil)
                imagePicker.delegate = self
            }

        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        
        
        //Autolayout desde codigo
        let leadingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        trailingConstraint.isActive = true
        leadingConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
