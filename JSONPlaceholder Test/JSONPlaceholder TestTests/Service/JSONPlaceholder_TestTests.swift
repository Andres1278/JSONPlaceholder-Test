//
//  JSONPlaceholder_TestTests.swift
//  JSONPlaceholder TestTests
//
//  Created by Pedro Andres Villamil on 20/08/22.
//

import XCTest

@testable import JSONPlaceholder_Test
final class JSONPlaceholder_TestTests: XCTestCase {
    
    func testUserModelWithMock() {
        guard let data = UserListMockupTest.list.data(using: .utf8) else {
            XCTFail("data doesn't exits")
            return
        }
        
        do {
            guard JSONSerialization.isValidJSONObject(data) else {
                return
            }
            let data = try JSONSerialization.data(withJSONObject: data, options: [])
            let entries = try JSONDecoder().decode([User].self, from: data as Data)
            XCTAssertNotNil(entries)
        } catch let error {
            XCTFail("\(error as? DecodingError)")
        }
        
    }
    
    func testPostModelWithMock() {
        guard let data = PostListMockupTest.list.data(using: .utf8) else {
            XCTFail("data doesn't exits")
            return
        }
        
        do {
            guard JSONSerialization.isValidJSONObject(data) else {
                return
            }
            let data = try JSONSerialization.data(withJSONObject: data, options: [])
            let entries = try JSONDecoder().decode([Post].self, from: data as Data)
            XCTAssertNotNil(entries)
        } catch let error {
            XCTFail("\(error as? DecodingError)")
        }
        
    }
    
    func testCommentModelWithMock() {
        guard let data = CommentListMockupTest.list.data(using: .utf8) else {
            XCTFail("data doesn't exits")
            return
        }
        
        do {
            guard JSONSerialization.isValidJSONObject(data) else {
                return
            }
            let data = try JSONSerialization.data(withJSONObject: data, options: [])
            let entries = try JSONDecoder().decode([Comment].self, from: data as Data)
            XCTAssertNotNil(entries)
        } catch let error {
            XCTFail("\(error as? DecodingError)")
        }
    }
}
