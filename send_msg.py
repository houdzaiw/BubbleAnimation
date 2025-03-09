import sys
sys.path.append('/Users/li/Library/Python/3.9/lib/python/site-packages')
import subprocess
from dingtalkchatbot.chatbot import DingtalkChatbot, ActionCard, CardItem
# # WebHook地址
webhook = 'https://oapi.dingtalk.com/robot/send?access_token=b70a6004b668a17952ef704f69a4fedec14ccd018999392b46d0edec3c9d8843'
secret = 'SEC99ed0136be5b39fe17ccc251ca6d7edca0f168afbefb78fcedcd76a6185f19f5'  # 可选：创建机器人勾选“加签”选项时使用# WebHook地址
# # 初始化机器人小丁
xiaoding = DingtalkChatbot(webhook, secret=secret)
# 获取最新的提交信息
# commit_info = subprocess.check_output(
#     ['git', 'log', '-1', '--pretty=format:%H by %an on %ad%n%s', '--date=short'],
#     encoding='utf-8'
# ).strip()
# 获取最新的提交信息，仅保留提交信息部分
commit_info = subprocess.check_output(
    ['git', 'log', '-1', '--pretty=format:%s'],
    encoding='utf-8'
).strip()
# 发送 Markdown 消息，包含提交信息
xiaoding.send_markdown(
    title='Auki iOS打包',
    text=f'[Auki_iOS线上包_v1.0.0 👉点击下载](https://www.pgyer.com/idoWP9yR)\n\n'
         '#### 安装密码：123456 \n\n'
         '> ![下载](https://www.pgyer.com/app/qrcode/idoWP9yR?pixsize=258)\n\n'
         '>  \n\n'
         f'### 🆕 提测试内容：\n'
         f'> {commit_info}\n\n',
    at_mobiles=['13104888483']
)
