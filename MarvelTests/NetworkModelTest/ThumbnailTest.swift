import XCTest
@testable import Marvel

class ThumbnailTest: XCTestCase {
    
    var thumbnail: Thumbnail!
    
    override func setUp() {
        thumbnail = Thumbnail()
    }
    
    override func tearDown() {
        
    }
    
    func testInit_defaultValues(){
        XCTAssertNotNil(thumbnail)
        XCTAssertEqual(thumbnail.path, "")
        XCTAssertEqual(thumbnail.extensions, "")
    }
    
    func testImageUrl_returnsCompleteUrl(){
        thumbnail.path = "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73"
        thumbnail.extensions = "jpg"
        let image = "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/portrait_xlarge.jpg"
        XCTAssertEqual(image, thumbnail.getImage(imageSize: ImageSize.portrait_xlarge))
    }
    
    
}
