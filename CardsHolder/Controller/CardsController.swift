//
//  CardsController.swift
//  CardsHolder
//
//  Created by Рома on 23.01.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import UIKit

class CardsController: UITableViewController {
    
    //MARK: - override methods
    override func viewDidLoad() {
        super.viewDidLoad()
       //убрать пустые ячейки
        tableView.tableFooterView = UIView()
        
        Model.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Action
    //по нажатию переходим на OneCardController и заполнять поля уже там
    @IBAction func pushAddAction(_ sender: Any) {
        selectedCard = nil
        performSegue(withIdentifier: "goToOneCard", sender: self)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CardCell
        
        //картинка на превью карточки
        cell.imageCard.image = dataArray[indexPath.row].image
        //имя
        cell.labelName.text = dataArray[indexPath.row].name
        //телефон
        cell.phoneName.text = dataArray[indexPath.row].phone
        
        return cell
    }
    
    
    //MARK: - Table View Delegate - Deleting
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataArray.remove(at: indexPath.row)
            Model.saveData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
    //MARK: - Navigation
    var selectedCard: VisitCard?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCard = dataArray[indexPath.row]
        
        //переход на OneCardController
        performSegue(withIdentifier: "goToOneCard", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOneCard" {
            (segue.destination as! OneCardController).card = selectedCard
        }
    }
}

