//
//  EthereumNode.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import Foundation

import BigInt
//ETH
import web3swift
import Web3Core

final class EthereumNode: ObservableObject {
    
    static var adapter: EthereumAdapter?
    
    static func queryAccount(completion: @escaping() -> Void) {
        EthereumNode.adapter = EthereumAdapter(mnemonics: Constants.mnemonic ?? "")
    }
    
    static let provider: Web3Provider = Web3HttpProvider(url: URL(string: "https://eth-sepolia.g.alchemy.com/v2/DfktXkoRgHi1sOYyXYw2YUrgF5DLYnBk")!, network: .Custom(networkID: 11155111))
    
    static func getBalance() async -> String {
        let web3 = Web3(provider: provider)
        
        do {
            if let balance = try? await web3.eth.getBalance(for: EthereumAddress(from: EthereumNode.adapter?.wallet?.address ?? "")!) {
                print("잔액: ", balance)
                
                return String(balance)
            } else {
                print("잔액 에러")
                return ""
            }
        } catch {
            print("Get Ballance Error!")
            return ""
        }
    }
    
    static func sendCoin(toAddress: String, value: BigUInt) async throws -> TransactionSendingResult? {
        let web3 = Web3(provider: provider)
        
        var gas = try await web3.eth.gasPrice()
        print("Gas: ", gas)
        print("저장된 이더 주소: ", EthereumNode.adapter?.wallet?.address ?? "이더 주소 없음")
        
        var transaction: CodableTransaction = .emptyTransaction
        
        //nonce
        transaction.nonce = try await web3.eth.getTransactionCount(for: EthereumAddress(EthereumNode.adapter?.wallet?.address ?? "")!)
        print("Nonce: ",transaction.nonce)
        
        //ChainID
        transaction.chainID = 11155111
        print("ChainID: ",transaction.chainID)
        
        //From Address
        transaction.from = EthereumAddress(EthereumNode.adapter?.wallet?.address ?? "") ?? transaction.sender//EthereumAddress(EthereumNode.adapter?.wallet?.address ?? "") ?? transaction.sender // `sender` one is if you have private key of your wallet address, so public key e.g. your wallet address could be interpreted
        print("From Address: ", (EthereumAddress(EthereumNode.adapter?.wallet?.address ?? "") ?? transaction.sender!).address)
                      
        //To Address
        transaction.to = EthereumAddress(toAddress)!
        
        //Value
        transaction.value = value
        
        print("Value: ", gas * 2)
        
        //Gas Limit
        transaction.gasLimit = BigUInt(9_000_000)
        print("Gas Limit: ", transaction.gasLimit)
        
        //Gas Price
        transaction.gasPrice = gas
        print("Gas price: ", transaction.gasPrice)
        
        //Sign
        do {
            try transaction.sign(privateKey: Constants.ethPrivKey!)
            print("Private Key: ", (Constants.ethPrivKey!).toHexString())
            print("Public Key: ", (Constants.ethPrivKey!).toHexString())
        } catch {
            print("Sign 실패")
        }
        
        let txData = transaction.encode()
        
        do {
            let result = try await web3.eth.send(raw: txData!)
            print("🔴🔴🔴 이더리움 보내기 성공")
            return result
        } catch {
            print("🔴🔴🔴 이더리움 보내기 실패 🔴🔴")
//            print(Web3Error)

            print(error.localizedDescription)
            throw Web3Error.dataError
        }
    }
}
