//
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Andres on 1/11/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var placeImageView: UIImageView!
 
    @IBOutlet var recipeTableView: UITableView!
    var place : Place!
    
    
    @IBOutlet var ratingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeTableView.estimatedRowHeight = 44.0
        self.recipeTableView.rowHeight = UITableViewAutomaticDimension
        self.placeImageView.image = UIImage(data: self.place.image! as Data)
        self.recipeTableView.backgroundColor = UIColor(red:0.9, green:0.9, blue:0.9, alpha: 0.25)
        self.recipeTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.recipeTableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.6)
        self.title = place.name
        let image = UIImage(named: self.place.rating!)
        self.ratingButton.setImage(image, for: .normal)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        return true
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

extension DetailViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceDetailViewCell", for: indexPath) as! PlaceDetailViewCell
        cell.backgroundColor = UIColor.clear

            switch indexPath.row{
            case 0:
                cell.keyLabel.text = "Nombre"
                cell.valueLabel.text = self.place.name
                break
            case 1:
                cell.keyLabel.text = "Tipo"
                cell.valueLabel.text = "\(self.place.type)"
                break
            case 2:
                cell.keyLabel.text = "Localización"
                cell.valueLabel.text = "\(self.place.location)"
                break
            case 3:
                cell.keyLabel.text = "Contácto"
                cell.valueLabel.text = "\(self.place.phone)"
                break
            case 4:
                cell.keyLabel.text = "Website"
                cell.valueLabel.text = "\(self.place.website)"
                break
            default:
                break
            }

        return cell
    }
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        switch section {
        case 1:
            title = "Ingredientes"
        case 2:
            title = "Pasos"
        default:
            break;
        }
        return title
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap"{
            let destinationViewController = segue.destination as! MapViewController
            destinationViewController.place =  self.place
        }
    }
    @IBAction func close(segue : UIStoryboardSegue){
        if let reviewVC = segue.source as? ReviewViewController{
            if let rating = reviewVC.ratingSelected{
                self.place.rating = rating
                let image = UIImage(named: self.place.rating!)
                self.ratingButton.setImage(image, for: .normal)
            }
        }
    }
}
extension DetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            //Cuando se seleccione el row de geolocalización
            self.performSegue(withIdentifier: "showMap", sender: nil)
            break;
        default:
            break;
        }
    }
}
