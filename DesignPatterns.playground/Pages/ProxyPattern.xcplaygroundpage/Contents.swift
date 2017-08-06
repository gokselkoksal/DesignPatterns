//: [Previous](@previous)

import Foundation

protocol Image {
    func data() -> Data
}

struct LocalImage: Image {
    
    let imageData: Data
    
    init(file: String) {
        self.imageData = LocalImage.load(fromFile: file)
    }

    func data() -> Data {
        return imageData
    }
    
    static func load(fromFile fileName: String) -> Data {
        print("Loading image \(fileName)...")
        return Data()
    }
}

class ProxyLocalImage: Image {
    
    let file: String
    private var localImage: LocalImage?
    
    init(file: String) {
        self.file = file
    }
    
    func data() -> Data {
        let image = localImage ?? LocalImage(file: file)
        localImage = image
        print("Returned image data for \(file).")
        return image.data()
    }
}

let image = ProxyLocalImage(file: "search-icon.png")
image.data() // Load should only happen here.
print("--")
image.data()
print("--")
image.data()

//: [Next](@next)
