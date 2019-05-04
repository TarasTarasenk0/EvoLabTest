//
//  DetailsViewController.swift
//  EvoLabTest
//
//  Created by md760 on 4/20/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit
import RealmSwift

final class AddNoteViewController: UIViewController {
    
    //MARK: Property
    let realm = try! Realm()
    var isEdit = false
    var note: Note?
    
    //IBOutlet
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEdit {
            saveButton.title = ConstValue.editButtonTitle
            noteTextView.text = note?.noteText
            noteTextView.isEditable = false
            
        }
    }
    
    //MARK: Actions
    @IBAction func share(_ sender: Any) {
        let text = note?.noteText
        let activityViewController = UIActivityViewController(activityItems: [text as Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = shareButton
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let note = Note()
        note.noteText = noteTextView.text
        note.noteDate = Date()
        
        if isEdit {
            saveButton.title = ConstValue.saveButtonTitle
            noteTextView.isEditable = true
            isEdit = false
            
        } else if self.note == nil {
            do {
                try? realm.write {
                    realm.add(note)
                    navigationController?.popViewController(animated: true)
                }
            }
        } else {
            noteTextView.isEditable = false
            do {
                try? realm.write {
                    self.note?.noteText = noteTextView.text
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
