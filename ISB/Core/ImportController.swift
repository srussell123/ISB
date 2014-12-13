//
//  ImportController.swift
//  ISB
//
//  Created by Christopher Martin on 11/22/14.
//
//

import Foundation

enum ImportStatus {
    case NotStarted
    case Running (Float) //percent done (approximate)
    case Succeeded (NSData) //raw data for audio track
    case Failed (NSError) //error that occured
}

protocol ImportControllerDelegate {
    func status(ImportStatus) -> Void
    func didStart(ImportStatus) -> Void
    func didFinish(ImportStatus) -> Void
}

class ImportController {

    internal var delegate: ImportControllerDelegate

    init(delegate: ImportControllerDelegate) {
        self.delegate = delegate
    }

    internal func startImport(fromUrl:NSURL!) {
        println("Starting Import")
        delegate.didStart((ImportStatus.Running(0.0)))
        
        //TODO this should maybe happen on a background thread since we're doing network stuff
        println("Parsing URL")
        let info = YoutubeParser.h264VideosForYoutubeUrl(youtubeUrl: fromUrl)
        println("Got Url")
        delegate.status(ImportStatus.Running(10.0))
        
        println("Loading stream into AVFoundation")
        delegate.status(ImportStatus.Running(50.0))

        println("Almost Done")
        delegate.status(ImportStatus.Running(99.9))

        println("Finished")
        delegate.status(ImportStatus.Succeeded("Finished".dataUsingEncoding(NSUTF8StringEncoding)!))
    }
}