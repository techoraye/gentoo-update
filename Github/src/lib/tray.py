#!/usr/bin/env python3
"""
Gentoo-Update Systray Applet
SPDX-License-Identifier: GPL-3.0-or-later

A PyQt6-based system tray application for monitoring Gentoo updates.
"""

import sys
import os
import subprocess
import json
from datetime import datetime
from pathlib import Path

try:
	from PyQt6.QtWidgets import QApplication, QSystemTrayIcon, QMenu
	from PyQt6.QtGui import QIcon, QPixmap
	from PyQt6.QtCore import QTimer, Qt
except ImportError:
	print("Error: PyQt6 is required for the systray applet")
	print("Install it with: pip install PyQt6")
	sys.exit(1)


class GentooUpdateTray:
	"""System tray applet for Gentoo-Update monitoring"""
	
	def __init__(self):
		self.app = QApplication(sys.argv)
		self.app.setApplicationName("Gentoo-Update Tray")
		self.setup_tray()
		self.setup_update_timer()
	
	def setup_tray(self):
		"""Initialize the system tray icon and menu"""
		self.tray = QSystemTrayIcon(self.app)
		self.tray.setIcon(self.get_icon("gentoo-update"))
		
		menu = QMenu()
		menu.addAction("Check for Updates", self.check_updates)
		menu.addAction("Show Updates", self.show_updates)
		menu.addSeparator()
		menu.addAction("Settings", self.open_settings)
		menu.addAction("Quit", self.app.quit)
		
		self.tray.setContextMenu(menu)
		self.tray.show()
	
	def setup_update_timer(self):
		"""Set up periodic update checks"""
		self.timer = QTimer()
		self.timer.timeout.connect(self.check_updates)
		self.timer.start(3600000)  # Check every hour
	
	def get_icon(self, icon_name):
		"""Get icon from system or fallback"""
		icon_paths = [
			f"/usr/share/icons/hicolor/scalable/apps/{icon_name}.svg",
			f"/usr/local/share/icons/hicolor/scalable/apps/{icon_name}.svg",
			f"{Path.home()}/.local/share/icons/hicolor/scalable/apps/{icon_name}.svg",
		]
		
		for path in icon_paths:
			if os.path.exists(path):
				return QIcon(path)
		
		# Fallback to default icon
		return QIcon.fromTheme("system-software-update")
	
	def check_updates(self):
		"""Check for available updates"""
		try:
			result = subprocess.run(
				["gentoo-update", "--check"],
				capture_output=True,
				text=True,
				timeout=30
			)
			
			if result.returncode == 0:
				# Update tray icon based on result
				self.tray.setIcon(self.get_icon("gentoo-update"))
		except subprocess.TimeoutExpired:
			print("Update check timed out")
		except FileNotFoundError:
			print("gentoo-update command not found")
	
	def show_updates(self):
		"""Display available updates"""
		subprocess.Popen(["gentoo-update", "-l"])
	
	def open_settings(self):
		"""Open settings dialog"""
		subprocess.Popen(["gentoo-update", "--edit-config"])
	
	def run(self):
		"""Run the application"""
		return self.app.exec()


def main():
	"""Main entry point"""
	tray = GentooUpdateTray()
	sys.exit(tray.run())


if __name__ == "__main__":
	main()
