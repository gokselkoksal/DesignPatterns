//: [Previous](@previous)

import Foundation

protocol StorageStrategy {
    func save(_ data: Data)
}

class FileSystemStorage: StorageStrategy {
    func save(_ data: Data) {
        print("Saved in file system.")
    }
}

class CloudStorage: StorageStrategy {
    func save(_ data: Data) {
        print("Saved in cloud.")
    }
}

class InMemoryStorage: StorageStrategy {
    func save(_ data: Data) {
        print("Saved in memory.")
    }
}

class ImageManager {
    
    let storage: StorageStrategy
    
    init(storage: StorageStrategy) {
        self.storage = storage
    }
    
    func download(file: String) -> Data {
        print("Downloading \(file)...")
        let data = Data()
        storage.save(data)
        return data
    }
}

let imageFile = "search.png"

let imageManager1 = ImageManager(storage: FileSystemStorage())
imageManager1.download(file: imageFile)

let imageManager2 = ImageManager(storage: CloudStorage())
imageManager2.download(file: imageFile)

let imageManager3 = ImageManager(storage: InMemoryStorage())
imageManager3.download(file: imageFile)

//: [Next](@next)
