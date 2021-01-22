//
//  AppDelegate.swift
//  MenuBarTODO
//
//  Created by Shunzhe Ma on R 3/01/21.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    
    let persistenceController = StorageHelper.shared

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // ポップオーバーの中にSwiftUIビューを設定
        let contentView = ContentView().environment(\.managedObjectContext, persistenceController.storageContext)
        // ポップオーバーを設定
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 350, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        // ステータスバーアイコンを設定
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        guard let button = self.statusBarItem.button else { return }
        button.image = NSImage(systemSymbolName: "checkmark.circle.fill", accessibilityDescription: nil)
        button.action = #selector(showHidePopover(_:))
    }
    
    @objc func showHidePopover(_ sender: AnyObject?) {
        guard let button = self.statusBarItem.button else { return }
        if self.popover.isShown {
            self.popover.performClose(sender)
        } else {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            self.popover.contentViewController?.view.window?.becomeKey()
        }
    }

}

