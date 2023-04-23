//
//  DownloadsTableViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 15/04/23.
//

import UIKit
import CoreData

protocol DeleteEpisodeDelegate{
    func deleteEpisode(indexPath:IndexPath)
}

class DownloadsTableViewController: UITableViewController {
    
    var dataController: DataController!
    var fetchedResultController: NSFetchedResultsController<Episodes>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Downloads"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpFetchedResultController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultController = nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.fetchedObjects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "downloadcell", for: indexPath) as! DownloadTableViewCell

        let episode = fetchedResultController!.object(at: indexPath)
      
        let podcast = loadPodCast(id: episode.podCastId!)
        cell.deleteDelegate = self
        cell.indexPath = indexPath
        cell.prepare(episode, podcast: podcast)
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let episode = fetchedResultController?.object(at: indexPath) else{
            return
        }
        
        guard let podcast = loadPodCast(id: episode.podCastId!) else{return}
        
        callPlayer(ep: episode, podcast: podcast)
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension DownloadsTableViewController{
    func callPlayer(ep:Episodes, podcast:PodCasts){
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "playerViewControllerStoryboard") as! PlayerViewController
            controller.podcast = podcast
            controller.episode = ep
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    fileprivate func setUpFetchedResultController(){
        let fetchRequest: NSFetchRequest<Episodes> = Episodes.fetchRequest()
        let sortDescriptor =  NSSortDescriptor(key: "pubDatems", ascending: false)
        let predicate = NSPredicate(format: "audioData != nil")
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        
        do{
            try fetchedResultController!.performFetch()
        }catch{
            print("No fetchedController")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    fileprivate func deleteData(id:String){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Episodes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        let deleteRequest =  NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        do{
            let context = dataController.viewContext
            let result = try context.execute(deleteRequest)
            
            guard let deleteResult = result as? NSBatchDeleteResult,
                  let ids = deleteResult.result as? [NSManagedObjectID] else{return}
            
            let changes = [NSDeletedObjectsKey: ids]
            
            context.perform {
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            }
                
        }catch{
            print("Delete Error \(error as Any)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadPodCast(id:String) -> PodCasts? {
        var fetchPodcastResultController:NSFetchedResultsController<PodCasts>?
        let request:NSFetchRequest<PodCasts> =  PodCasts.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        fetchPodcastResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchPodcastResultController?.delegate = self
        
        do{
            try fetchPodcastResultController?.performFetch()
        }catch{
            print("Erro: \(error.localizedDescription)")
        }
        
        return fetchPodcastResultController?.fetchedObjects?.first ?? nil
        
    }
}
extension DownloadsTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .insert:
            if newIndexPath != nil {
                tableView.insertRows(at: [newIndexPath!], with: .none)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .none)
            }
            break
        case .move, .update:
            break
        default:
            break
        }
    }
}

extension DownloadsTableViewController: DeleteEpisodeDelegate{
    
    func deleteEpisode(indexPath: IndexPath) {
        
        guard let epdownload = fetchedResultController?.fetchedObjects?[indexPath.row] else {return}
        let context = dataController.viewContext
        
        epdownload.setValue(nil, forKey: "audioData")
        
        try? context.save()
        
    }
    
    
}
