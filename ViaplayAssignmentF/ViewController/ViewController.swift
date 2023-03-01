//
//  ViewController.swift
//  ViaplayAssignment
//
//  Created by Abhishek Babladi on 2022-11-06.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  var coreDataSections: [NSManagedObject] = []
  private var dataViewModel = DataViewModel()
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
  }()
  var sections: [ViaplaySection] = []
  let defaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    initialSetup()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
    tableView.separatorColor = UIColor.clear
  }

  func initialSetup() {
    // Network Call is initiated and the table initial setup is carried out in this function
    dataViewModel.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    Task {
      await dataViewModel.getData()
    }
  }
}

extension ViewController: ResultManagerDelegate, UITableViewDelegate, UITableViewDataSource {
  // Sucessfully data is fetched and assigned to the local variable for further usage
  func didUpdateWithResult(_ dataManager: DataViewModel, result: DataInfoViewModel) {
      fetchSectionsAndSaveIfNeeded(result: result)
  }
  // Error handelling while getting back the result
  func didFailWithError(error: Error) {
    print(error)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = self.sections[indexPath.section].name
    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.sections.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.sections[section].title
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    view.tintColor = .systemGray
    let header = view as? UITableViewHeaderFooterView
      header?.textLabel?.textColor = .blue
  }

}

extension ViewController {
    func fetchSectionsAndSaveIfNeeded(result: DataInfoViewModel) {
        Task {
            self.sections = result.dataInfo.links.viaplaySections
            if !defaults.bool(forKey: "isSaved") {
                saveSectionsToCoreData(sections: self.sections)
                defaults.set(true, forKey: "isSaved")
            }
            self.tableView.reloadData()
        }
    }

    func saveSectionsToCoreData(sections: [ViaplaySection]) {
        for section in sections {
            _ = DataManager.shared.sec(id: section.id,
                                       title: section.title,
                                       href: section.href,
                                       type: section.type,
                                       name: section.name,
                                       templated: section.templated)
            DataManager.shared.saveContext()
        }
    }

}

struct Constants {
    static let numberOfRows: Int = 1
}
