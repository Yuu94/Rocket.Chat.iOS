//
//  DeleteMessageRequest.swift
//  Rocket.Chat
//
//  Created by Matheus Cardoso on 1/11/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import Foundation

import SwiftyJSON

typealias DeleteMessageResult = APIResult<SendMessageRequest>

class DeleteMessageRequest: APIRequest {
    let requiredVersion = Version(0, 48, 0)

    let method: HTTPMethod = .post
    let path = "/api/v1/chat.delete"

    let roomId: String
    let msgId: String
    let asUser: Bool

    init(roomId: String, msgId: String, asUser: Bool) {
        self.msgId = msgId
        self.roomId = roomId
        self.asUser = asUser
    }

    func body() -> Data? {
        let body = JSON([
            "roomId": roomId,
            "msgId": msgId,
            "asUser": asUser
        ])

        return body.rawString()?.data(using: .utf8)
    }
}

extension APIResult where T == DeleteMessageRequest {
    var success: Bool? {
        return raw?["success"].boolValue
    }
}
