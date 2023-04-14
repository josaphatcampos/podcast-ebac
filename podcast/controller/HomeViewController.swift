//
//  HomeViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import UIKit
import CoreData

protocol FavoriteDelegate{
    func favoritarPodCast(_ id:String)
    func desfavoritarPodCast(_ id:String)
}

class HomeViewController: UIViewController {
    
    var dataController: DataController!
    var fetchedResultController: NSFetchedResultsController<PodCasts>?
    
    var service:PodCastService = PodCastService()
    var pod = [PodCasts]()
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var banner: UIImageView!
    
    @IBOutlet weak var hometableview: UITableView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    
    fileprivate func setUpFetchedResultController(){
        let fetchRequest: NSFetchRequest<PodCasts> = PodCasts.fetchRequest()
        let sortDescriptor =  NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        
        do{
            try fetchedResultController!.performFetch()
        }catch{
            print("No fetchedController")
        }
        
    }
    
    fileprivate func deleteData(){
        print("ENTOrU DELETE")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PodCasts.fetchRequest()
        
        let deleteRequest =  NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        print("ENTOrU DELETE antes do do")
        do{
            print("ENTOrU DELETE no do")
            let context = dataController.viewContext
            let result = try context.execute(deleteRequest)
            print("ENTOrU DELETE antes guard")
            guard let deleteResult = result as? NSBatchDeleteResult,
                  let ids = deleteResult.result as? [NSManagedObjectID] else{return}
            print("ENTOrU DELETE depois guard")
            let changes = [NSDeletedObjectsKey: ids]
            print("ENTOrU DELETE change \(changes.first)")
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            print("ENTOrU DELETE final do")
        }catch{
            print("Delete Error \(error as Any)")
        }
        print("ENTOrU DELETEfinal tudo")
        DispatchQueue.main.async {
            self.hometableview.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hometableview.dataSource = self
        hometableview.delegate = self
        
        
        
        viewConfig()
        callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpFetchedResultController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultController = nil
    }
    
    func viewConfig(){
//        scrollview.contentSize = CGSizeMake(scrollViewContentWidth, scrollViewContentHeight)
        hometableview.bounces = false
        hometableview.isScrollEnabled = false
        
    }
    
    func callAPI(){
        print("chamou")
        service.getBestPod { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let response):
                print("antes do delete")
                deleteData()
                print("depois do delete")
                for item in response {
                    let podcast = PodCasts(context: self.dataController.viewContext)
                    
                    podcast.id              = item.id
                    podcast.title           = item.title
                    podcast.country         = item.country
                    podcast.image           = item.image
                    podcast.language        = item.language
                    podcast.publisher       = item.publisher
                    podcast.totalEpisodes   = Int32(item.totalEpisodes)
                    
                    guard let imageURL = URL(string: item.image)else{return}
                    guard let imageData = try? Data(contentsOf: imageURL) else {return}
                    
                    podcast.imageData = imageData
                    
                    self.pod.append(podcast)
                    
                    try? self.dataController.viewContext.save()
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableviewHeight.constant = CGFloat(80 * (self.pod.count))
                self.hometableview.reloadData()
            }
        }
    }
    
    func callPodcastEpisodes(_ id:String){
        //epsodesTableView
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "epsodesTableView") as! EpisodesTableViewController
            controller.podcastId = id
            
            let navController = UINavigationController(rootViewController: controller)
//            navController.modalPresentationStyle = .fullScreen
            
            self.present(navController, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.sections?[section].numberOfObjects ?? 0//pod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeCellTableViewCell
        let podcast = fetchedResultController!.object(at: indexPath)//pod[indexPath.row]
        
        cell.favoriteDelegate = self
        
        
        
        cell.id = podcast.id!
        
        cell.prepare(with: podcast)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("celula \(indexPath)")
        callPodcastEpisodes(pod[indexPath.row].id!)
    }    
}

extension HomeViewController: FavoriteDelegate{
    func desfavoritarPodCast(_ id: String) {
        print("Voce Desavoritou o \(id)")
    }
    
    func favoritarPodCast(_ id: String) {
        print("Voce Favoritou o \(id)")
    }
    
    
}

extension HomeViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        hometableview.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .insert:
            if newIndexPath != nil {
                hometableview.insertRows(at: [newIndexPath!], with: .none)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                hometableview.deleteRows(at: [indexPath], with: .none)
            }
            break
        case .move, .update :
            break
        default:
            break
        }
    }
}
