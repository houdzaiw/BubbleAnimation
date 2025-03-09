#!/bin/bash
cd /Users/li/.jenkins/workspace/Bubble
fastlane Bubble
python3 send_msg.py
