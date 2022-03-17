//
//  ChatViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 25.09.2021.
//

import UIKit
import MessageKit

// MARK: - Structs

struct Message: MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}

struct Sender: SenderType {
    var photoURL: String
    
    var senderId: String
    
    var displayName: String
}

class ChatVC: MessagesViewController {

    // MARK: - Properties
    
    private var messages = [Message]()
    
    private var selfSender = Sender(photoURL: "", senderId: "1", displayName: "Joe Smith")
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello World")))
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello World, Hello World,Hello World,Hello World")))
        
        setupDelegates()
    }
    
    
    // MARK: - Setup
    
    func setupDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
}

extension ChatVC: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}
