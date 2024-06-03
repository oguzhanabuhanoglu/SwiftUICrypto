//
//  CoinImageService.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 25.05.2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
   
    var imageSubscription: AnyCancellable?
    
    private let coin: CoinModel
    private let filemanager = LocalFileManager.instance
    private let imageName: String
    private let folderName = "coin_images"
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = filemanager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from FileManager!")
        }else {
            downloadImage()
            print("Downloading Image Now")
        }
    }
    
    private func downloadImage() {
        
        guard let url = URL(string: coin.image) else { return }
            
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadingImage = returnedImage else { return }
                self.image = downloadingImage
                self.imageSubscription?.cancel()
                self.filemanager.saveImage(image: downloadingImage, folderName: self.folderName, imageName: self.imageName)
            })
    }
}
