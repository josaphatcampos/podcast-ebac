//
//  Podcast.swift
//  meu podcast
//
//  Created by Josaphat Campos Pereira on 07/04/23.
//

import Foundation
struct PodcastData{
    let id, title, publisher: String?
    let image, thumbnail: String?
    let listennotesURL: String?
    let listenScore, listenScoreGlobalRank: String?
    let totalEpisodes, audioLengthSEC, updateFrequencyHours: Int?
    let explicitContent: Bool?
    let description: String?
    let itunesID: Int?
    let rss: String?
    let latestPubDateMS: Int?
    let latestEpisodeID: String?
    let earliestPubDateMS: Int?
    let language, country: String?
    let website: String?
    let isClaimed: Bool?
    let email, type: String?
    let genreIDS: [Int]?
    
    init(id: String?, title: String?, publisher: String?, image: String?, thumbnail: String?, listennotesURL: String?, listenScore: String?, listenScoreGlobalRank: String?, totalEpisodes: Int?, audioLengthSEC: Int?, updateFrequencyHours: Int?, explicitContent: Bool?, description: String?, itunesID: Int?, rss: String?, latestPubDateMS: Int?, latestEpisodeID: String?, earliestPubDateMS: Int?, language: String?, country: String?, website: String?, isClaimed: Bool?, email: String?, type: String?, genreIDS: [Int]?) {
        self.id = id
        self.title = title
        self.publisher = publisher
        self.image = image
        self.thumbnail = thumbnail
        self.listennotesURL = listennotesURL
        self.listenScore = listenScore
        self.listenScoreGlobalRank = listenScoreGlobalRank
        self.totalEpisodes = totalEpisodes
        self.audioLengthSEC = audioLengthSEC
        self.updateFrequencyHours = updateFrequencyHours
        self.explicitContent = explicitContent
        self.description = description
        self.itunesID = itunesID
        self.rss = rss
        self.latestPubDateMS = latestPubDateMS
        self.latestEpisodeID = latestEpisodeID
        self.earliestPubDateMS = earliestPubDateMS
        self.language = language
        self.country = country
        self.website = website
        self.isClaimed = isClaimed
        self.email = email
        self.type = type
        self.genreIDS = genreIDS
    }
}
