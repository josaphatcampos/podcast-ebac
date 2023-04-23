//
//  EpisodesTableViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import UIKit
import CoreData
import NVActivityIndicatorView

protocol DownloadEpisodeFileDelegate{
    func downloadEpisode(_ indexPath:IndexPath)
    func deleteDownloadEpisode(_ indexPath:IndexPath)
}

class EpisodesTableViewController: UITableViewController {
    
    var dataController: DataController!
    var fetchedResultController: NSFetchedResultsController<Episodes>?
    
    var service:PodCastService = PodCastService()
    var podcast:PodCasts!
    var ep = [Episodes]()
    
    let loader:NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: .ballClipRotateMultiple, color: .yellow, padding: 150)
        indicator.backgroundColor = .black.withAlphaComponent(0.4)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configload(view)
        loader.startAnimating()
        
        guard let id = podcast.id else{
            self.dismiss(animated: true)
            return
        }
        
        uiConfiguration()
        callAPI(id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpFetchedResultController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultController = nil
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchedResultController?.sections?[section].numberOfObjects ?? 0
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodescell", for: indexPath) as! EpisodesTableViewCell
        
        let episode = fetchedResultController!.object(at: indexPath)
        cell.downloadDelegate = self
        cell.prepare(episode, indexPath: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let episode = fetchedResultController?.object(at: indexPath) else{
            return
        }
        
        callPlayer(ep: episode)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // MARK: -  Configure the Podcast Session
        self.title = "Episódios"
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        header.backgroundColor = .red
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let filter = UIView()
        filter.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        filter.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let data = podcast.imageData{
            imageView.image = UIImage(data: data)
        }else if let imageUrl = URL(string: podcast?.image ?? ""){
            URLSession.shared.dataTask(with: imageUrl){data, _, error in
                guard let data = data, error == nil else {return}
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
                
            }.resume()
        }else{
            imageView.image = UIImage(named: "imagePlaceholder")
        }
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.center = CGPoint(x: 50, y: 50)
        title.textAlignment = .center
        
        title.text = podcast.title
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .white
        
        let episodios = UILabel()
        episodios.translatesAutoresizingMaskIntoConstraints = false
        episodios.textAlignment = .center
        episodios.text = "Episódios: \(String(describing: podcast?.totalEpisodes ?? 0))"
        episodios.font = episodios.font.withSize(16)
        episodios.textColor = .white
              
        
        header.addSubview(imageView)
        header.addSubview(filter)
        header.addSubview(title)
        header.addSubview(episodios)
        
        NSLayoutConstraint.activate([
            
            header.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            header.heightAnchor.constraint(equalToConstant: 200),
        
            
            imageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            filter.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            filter.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            filter.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            filter.heightAnchor.constraint(equalToConstant: 200),
            
            
            title.heightAnchor.constraint(equalToConstant: 35),
            title.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
            title.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: 51),


            episodios.heightAnchor.constraint(equalToConstant: 35),
            episodios.widthAnchor.constraint(equalTo: header.widthAnchor),
            episodios.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            episodios.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -51),
            
            
            
        ])
        
        return header
    }
    

}

extension EpisodesTableViewController{
    fileprivate func setUpFetchedResultController(){
        let fetchRequest: NSFetchRequest<Episodes> = Episodes.fetchRequest()
        let sortDescriptor =  NSSortDescriptor(key: "pubDatems", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "podCastId = %@", podcast.id!)
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        do{
            try fetchedResultController!.performFetch()
            
        }catch{
            print("No fetchedController")
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    fileprivate func deleteData(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Episodes.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "podCastId = %@ and audioData = nil", podcast.id!)
        
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
    
    func callPlayer(ep:Episodes){
        DispatchQueue.main.async {
            
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "playerViewControllerStoryboard") as! PlayerViewController
            controller.podcast = self.podcast
            controller.episode = ep
            
            
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    func callAPI(_ id:String){
        // MARK: - CALL API
        service.getepisodes(id) { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let response):
                let context = self.dataController.viewContext
                
                self.deleteData()
                
                for item in response.episodes {
                    let episode = Episodes(context: context)

                    episode.id              = item.id
                    episode.pubDatems       = item.pubDateMS
                    episode.descriptionNote = item.description
                    episode.explicitContent = item.explicitContent
                    episode.title           = item.title
                    episode.audio           = item.audio
                    episode.image           = item.image
                    episode.podCastId       = self.podcast.id
                    
                    let imageData = self.saveData(url: item.image)
                    episode.imageData = imageData
                    
                    self.ep.append(episode)
                                            
                    context.perform {
                        try? context.save()
                    }
                }
                
            case .failure(let error):
                print("error \(error.localizedDescription)")
                self.loader.stopAnimating()
                self.dispatchAlert(nil, message: "Não foi possível carregar os episódios")
            }
            
            DispatchQueue.main.async { //[weak self] in
                self.tableView.reloadData()
                if self.loader.isAnimating{
                    self.loader.stopAnimating()
                }
            }

        }
        
    }
    
    func saveData(url:String) -> Data?{
        guard let dataURL = URL(string: url) else {return nil}
        guard let data = try? Data(contentsOf: dataURL) else {return nil}
        
        return data
    }
    
    func uiConfiguration(){
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.navigationBar.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    func configload(_ view: UIView){
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            loader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            loader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
        
        loader.bringSubviewToFront(view)
    }
}

extension EpisodesTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .insert:
            if newIndexPath != nil {
                tableView.insertRows(at: [newIndexPath!], with: .none)
                print("insert")
                tableView.reloadData()
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                print("delete")
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            break
        case .update :
            if let indexPath = indexPath {
                print("update")
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            break
        case .move:
            
            break
            
        default:
            break
        }
    }
}

// MARK: - Download Audio
extension EpisodesTableViewController: DownloadEpisodeFileDelegate{
    func downloadEpisode(_ indexPath: IndexPath) {
        loader.startAnimating()
        
        guard let epdownload = fetchedResultController?.fetchedObjects?[indexPath.row] else {return}
        let context = dataController.viewContext
        
        guard let audio = epdownload.audio else{return}
        
        let audioData = saveData(url: audio)
        epdownload.setValue(audioData, forKey: "audioData")
        
        
        try? context.save()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.loader.isAnimating{
                self.loader.stopAnimating()
            }
        }
        
        
    }
    
    func deleteDownloadEpisode(_ indexPath: IndexPath) {
        guard let epdownload = fetchedResultController?.fetchedObjects?[indexPath.row] else {return}
        let context = dataController.viewContext
        
        epdownload.setValue(nil, forKey: "audioData")
        
        try? context.save()
    }
    
    
}
