//
//  KeychainManager.swift
//  LifeBoardSecurity
//
//  Secure credential storage using Keychain
//  Supports app group sharing between iOS and tvOS
//

import Foundation
import Security

/// Manages secure credential storage using Keychain
/// Supports app group sharing for cross-platform access
public final class KeychainManager {
    
    /// Shared singleton instance
    public static let shared = KeychainManager()
    
    /// App group identifier for keychain sharing
    private let appGroup: String
    
    private init() {
        // App group identifier for keychain sharing
        // Update this to match your App Group from Xcode capabilities
        self.appGroup = "group.com.lifeboardapp.lifeBoard"
    }
    
    // MARK: - Public Methods
    
    /// Saves a value to Keychain
    /// - Parameters:
    ///   - value: String value to save
    ///   - key: Key identifier
    ///   - service: Service identifier (default: "lifeBoard")
    /// - Returns: Success or error
    @discardableResult
    public func save(_ value: String, forKey key: String, service: String = "lifeBoard") -> Bool {
        guard let data = value.data(using: .utf8) else {
            return false
        }
        
        // Delete existing item if present
        delete(forKey: key, service: service)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecAttrAccessGroup as String: appGroup,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// Retrieves a value from Keychain
    /// - Parameters:
    ///   - key: Key identifier
    ///   - service: Service identifier (default: "lifeBoard")
    /// - Returns: Retrieved value or nil
    public func get(forKey key: String, service: String = "lifeBoard") -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecAttrAccessGroup as String: appGroup,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    /// Deletes a value from Keychain
    /// - Parameters:
    ///   - key: Key identifier
    ///   - service: Service identifier (default: "lifeBoard")
    /// - Returns: Success or error
    @discardableResult
    public func delete(forKey key: String, service: String = "lifeBoard") -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecAttrAccessGroup as String: appGroup
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
    
    /// Deletes all items for a service
    /// - Parameter service: Service identifier (default: "lifeBoard")
    /// - Returns: Success or error
    @discardableResult
    public func deleteAll(service: String = "lifeBoard") -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccessGroup as String: appGroup
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}

