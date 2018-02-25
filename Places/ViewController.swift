//
//  ViewController.swift
//  MisRecetas
//
//  Created by Andres on 23/10/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var places : [Place] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view, typically from a nib.
        var place = Place(name: "AlexanderPlatz", type: "Plaza", location: "10178 Berlín, Alemania", image: #imageLiteral(resourceName: "alexanderplatz"),phone : "5555555", website: "https://www.disfrutaberlin.com/alexanderplatz")
        places.append(place);
        place = Place(name: "Atomium", type: "Museo", location: "1020 Bruxelles, Belgica", image: #imageLiteral(resourceName: "atomium"),phone:"España:+34 518 900 112" ,website:"https://www.bruselas.net/atomium")
        places.append(place)
        place = Place(name: "Big Ben", type: "Monumento", location: "Westminster, Londres SW1A 0AA, Reino Unido", image: #imageLiteral(resourceName: "bigben"),phone: "1234567890",website: "http://www.parliament.uk/bigben")
        places.append(place)
        place = Place(name: "Cristo redentor", type: "Monumento", location: "Parque Nacional da Tijuca - Alto da Boa Vista, Rio de Janeiro - RJ, Brasil", image: #imageLiteral(resourceName: "cristoredentor"), phone: "faleconosco@cristoredentoroficial.com.br", website: "https://cristoredentoroficial.com.br/")
        places.append(place)
        place = Place(name: "Torre Eiffel", type: "Monumento", location: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France", image:#imageLiteral(resourceName: "torreeiffel"), phone: "https://www.toureiffel.paris/fr/utile/contact", website: "https://www.toureiffel.paris/fr")
        places.append(place)
        place = Place(name: "Gran muralla china", type: "Monumento", location: "Mu Tian Yu Chang Cheng Huairou Qu, Beijing Shi China", image:#imageLiteral(resourceName: "murallachina"), phone: "800-2682918", website: "https://www.chinahighlights.com/greatwall/")
        places.append(place)
        place = Place(name: "Torre de Pisa", type: "Monumento", location: "Piazza del Duomo, 56126 Pisa PI, Italia", image:#imageLiteral(resourceName: "torrepisa"), phone: "+39 050 835011/12", website: "http://www.opapisa.it/")
        places.append(place)
        place = Place(name: "La seu de Mallorca", type: "Catedral", location: "Plaza Almoina, s/n, 07001 Palma, Illes Balears, España", image:#imageLiteral(resourceName: "mallorca"), phone: "info@catedraldemallorca.org", website: "http://catedraldemallorca.org/")
        places.append(place)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        let cellId = "PlaceCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlaceCell
        cell.recipeImg.image = place.image
        cell.recipeName.text = place.name
        cell.recipeTime.text = place.type
        cell.recipeIngredientes.text = place.location
        /*cell.recipeImg.layer.cornerRadius = 42.0
         cell.recipeImg.clipsToBounds = true*/
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            self.places.remove(at: indexPath.row)
        }
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let shareDefaultText = "Estoy visitando el lugar \(self.places[indexPath.row].name)"
            let activityController = UIActivityViewController(activityItems:[shareDefaultText], applicationActivities: nil)
            
            self.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor.init(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        //Borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Eliminar") { (action, indexPath) in
            self.places.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
            
            
        }
        return [shareAction,deleteAction]
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    //Enviar informacion entre viewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail")
        {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let selectedPlace = self.places[indexPath.row]
                //Es destinationViewController en swift 3
                let destinaionViewController = segue.destination as! DetailViewController
                destinaionViewController.place = selectedPlace
            }
            
        }
    }
    @IBAction func unwindToViewController(segue: UIStoryboardSegue){
        
    }
}


