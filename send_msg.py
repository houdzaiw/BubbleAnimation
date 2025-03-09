import sys
sys.path.append('/Users/li/Library/Python/3.9/lib/python/site-packages')
from dingtalkchatbot.chatbot import DingtalkChatbot, ActionCard, CardItem
# WebHook地址
webhook = 'https://oapi.dingtalk.com/robot/send?access_token=b70a6004b668a17952ef704f69a4fedec14ccd018999392b46d0edec3c9d8843'
secret = 'SEC99ed0136be5b39fe17ccc251ca6d7edca0f168afbefb78fcedcd76a6185f19f5'  # 可选：创建机器人勾选“加签”选项时使用# WebHook地址
#webhook = 'https://oapi.dingtalk.com/robot/send?access_token=5fedcc94bb64580ebd2ba5f8f4e9622fd18e4e1758cb7af8b5cfa5af91627eb9'
#secret = 'SEC77eb820be3d777b2942804a1dee79ef88852fb1a28ea62f2b37c06492f0b614f'  # 可选：创建机器人勾选“加签”选项时使用
# 初始化机器人小丁
xiaoding = DingtalkChatbot(webhook, secret=secret)
# Markdown消息@所有人
xiaoding.send_markdown(
title='Auki iOS打包',
text='[Auki_iOS线上包_1.0.0 👉点击下载](https://www.pgyer.com/idoWP9yR)\n\n'
                           '#### 安装密码：123456 \n\n'
                           '> ![下载](https://www.pgyer.com/app/qrcode/idoWP9yR?pixsize=258)\n\n'
                           '>  \n\n',
                           
                           
at_mobiles=['唐佳', '陈晓丽'])
