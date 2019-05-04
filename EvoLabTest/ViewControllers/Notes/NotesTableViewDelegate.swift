//
//  NotesTableViewDelegate.swift
//  EvoLabTest
//
//  Created by md760 on 4/20/19.
//  Copyright © 2019 md760. All rights reserved.
//

import UIKit

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: ConstValue.storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ConstValue.detailsVCIdentifier) as! AddNoteViewController
        vc.isEdit = true
        vc.note = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if let note = notes?[indexPath.row] {
                try! realm.write {
                    realm.delete(note)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}

extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeholderImage.isHidden = notes.count != 0
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NoteCell
        
        let note = notes[indexPath.row] 
        cell.noteText.text = note.noteText
        cell.dateLabel.text = note.noteDate?.getDateStringFromDate(nil)
        cell.timeLabel.text = note.noteDate?.getDateStringFromDate("HH:mm")
        return cell
    }
    
}
