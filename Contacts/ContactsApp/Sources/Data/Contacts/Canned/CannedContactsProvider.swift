/**
 * Copyright (c) 2017 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import Contacts

// MARK: CannedContactsProvider

class CannedContactsProvider {
  
  // MARK: Private
  
  private func fetch(_ callback: @escaping ([CNContact]) -> Void) {
    let store = CNContactStore()
    
    store.requestAccess(for: .contacts) { (granted, error) in
      guard error == nil else {
        print("Failed to fetch contacts with error: \(String(describing: error))")
        return callback([])
      }
      
      guard granted == true else {
        print("Not granted priviliges for Contacts access.")
        return callback([])
      }
      
      var contacts: [CNContact] = []
      let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,
                  CNContactPhoneNumbersKey] as [CNKeyDescriptor]
      let request = CNContactFetchRequest(keysToFetch: keys)
      
      try? store.enumerateContacts(with: request,
                                   usingBlock: { contact,_ in  contacts.append(contact) })
      
      callback(contacts)
    }
  }
  
}

extension CannedContactsProvider: ContactsProvider {
  func all(_ callback: @escaping ([CNContact]) -> Void) {
    fetch(callback)
  }
}
