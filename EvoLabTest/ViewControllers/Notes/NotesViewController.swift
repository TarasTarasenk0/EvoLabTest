//
//  ViewController.swift
//  EvoLabTest
//
//  Created by md760 on 4/20/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit
import RealmSwift

final class NotesViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var noteSearchBar: UISearchBar!
    
    //MARK: Property
    let cellId = "NoteCellId"
    var realm = try! Realm()
    var notes: Results<Note>!
    var noteArray = [Note]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noteSearchBar.delegate = self
        setupView()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
    private func setupView() {
        notesTableView.register(UINib(nibName: ConstValue.notesNibName, bundle: nil), forCellReuseIdentifier: cellId)
        notes = realm.objects(Note.self)
    }
    
    @IBAction private func sort(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: ConstValue.cancelTitle, style: .cancel, handler: nil)
        
        let ascending = UIAlertAction(title: ConstValue.ascendingTitle, style: .default) { [weak self] action in
            guard let `self` = self else { return }
            self.notes = self.realm.objects(Note.self).sorted(byKeyPath: ConstValue.noteKeyPath, ascending: false)
            self.reload()
        }
        
        let descending = UIAlertAction(title: ConstValue.descendingTitle, style: .default) { [weak self] action in
            guard let `self` = self else { return }
            self.notes = self.realm.objects(Note.self).sorted(byKeyPath: ConstValue.noteKeyPath, ascending: true)
            self.reload()
        }
        actionSheet.addAction(ascending)
        actionSheet.addAction(descending)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func reload() {
        notesTableView.reloadData()
    }

}

extension NotesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if (searchText.count) > 0 {
                let predicate = NSPredicate(format: "noteText CONTAINS [c] %@", searchBar.text!)
                self.notes = self.realm.objects(Note.self).filter(predicate)
                self.reload()
            } else {
                self.notes = self.realm.objects(Note.self)
                self.reload()
            }
        }
    }
}

