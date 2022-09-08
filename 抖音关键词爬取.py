# # -*- codeing = utf-8 -*-
# # @Time : 2021/11/21 15:02
# # @Author :康康
# # @File :数据分析练习.py
# # @Sofware: PyCharm
import pyautogui
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
from urllib import request
import requests
import re
from selenium.webdriver.common.by import By
zhuye_url = str(input("请输入你要爬取的关键词: \n "))
def drop_down():  #定义一个函数
    """执行页面下滑滚动操作"""    #javascript
    for x in range(1,4,2):    #range作用是从1-30直接然后除于4的执行次数
        time.sleep(1)
        j = x / 9
        js = "window.scrollTo(0, document.body.scrollHeight)"      #下滑到最底部

        driver.execute_script(js)
options = webdriver.ChromeOptions()
options.add_experimental_option('useAutomationExtension', False)
options.add_experimental_option("excludeSwitches", ['enable-automation'])
options.add_argument('--start-maximized')

# options.add_argument('disable-infobars')

driver = webdriver.Chrome(chrome_options=options) #将谷歌浏览器实例化，也可以自己换成Firefox浏览器，需要调用谷歌浏览器驱动，可以自己核对浏览器版本进行下载谷歌浏览器是chromedriver，Firefox是geckodriver，浏览器版本可以在帮助里面关于Google浏览器，需要和脚本在统一目录下

driver.get("https://www.douyin.com/search/%s?publish_time=0&sort_type=0&source=normal_search&type=video"%zhuye_url)   #使用浏览器打开该网站
time.sleep(2)    #停止2秒
# print("为了更好的抓取，请进行扫码登录")
# qddl = pyautogui.locateOnScreen(image='dydl.jpg')
# # 输出坐标
# if not qddl:
#     print('未识别到确定登录按钮')
# else:
#     print('登录成功')
# # 利用center()函数获取目标图像在系统中的中心坐标位置
# x, y = pyautogui.center(qddl)
# print('你的登录的X,Y坐标是：', x, y)
# # 对识别出的目标图像进行点击
# # 参数x,y代表坐标位置，clicks代表点击次数,button可以设置为左键或者右键
# pyautogui.click(x=x, y=y, clicks=1, button='left')
# time.sleep(2)
drop_down()   #调用函数


headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36',
    'cookie': 'ttwid=1%7CMGvsMfYA6WUT2LF4K52YbolC9y0balc6jxndU1GMu9I%7C1661916400%7C1ea6c232900f865cffa0bf4cf7f67c6972f4af2c2549ca2c62a46bacaecac47a; s_v_web_id=verify_l7h246l8_FpGABFUl_Xmlw_411a_AV1l_zqwcVrK0yjI9; passport_csrf_token=5f270767b09be070a60d94015be9c6bf; passport_csrf_token_default=5f270767b09be070a60d94015be9c6bf; ttcid=7f940b98e47041a29226f597962b015916; SEARCH_RESULT_LIST_TYPE=%22single%22; strategyABtestKey=1662359670.013; n_mh=TDhO6M6uaAyUzFa1rE8nD_37aZ3GQvP7zUDTFXEso8Q; sso_uid_tt=c85a1686c5ad0fadd3f773305c58df30; sso_uid_tt_ss=c85a1686c5ad0fadd3f773305c58df30; toutiao_sso_user=e119fd846277ef56a63dc37bfbb6d9a0; toutiao_sso_user_ss=e119fd846277ef56a63dc37bfbb6d9a0; sid_ucp_sso_v1=1.0.0-KDRmMmYxMzVkOTYxOGE4MDAyMzE3MTAyYjNjNDhlYzAyMGY0ZGZlNDIKHQjllsP01AEQh7HWmAYY7zEgDDDClO_FBTgGQPQHGgJsZiIgZTExOWZkODQ2Mjc3ZWY1NmE2M2RjMzdiZmJiNmQ5YTA; ssid_ucp_sso_v1=1.0.0-KDRmMmYxMzVkOTYxOGE4MDAyMzE3MTAyYjNjNDhlYzAyMGY0ZGZlNDIKHQjllsP01AEQh7HWmAYY7zEgDDDClO_FBTgGQPQHGgJsZiIgZTExOWZkODQ2Mjc3ZWY1NmE2M2RjMzdiZmJiNmQ5YTA; odin_tt=563c81f2d5e00b8d6efe91c5a887a39cefc91f7a0808d8ca437fbcf72ed24591111d91d20f9a8d5dc2b7d89fe113042c; passport_auth_status=f493b3353a84482ed134410aa8b042f4%2C; passport_auth_status_ss=f493b3353a84482ed134410aa8b042f4%2C; sid_guard=3cb6595b3b90c714d39cc02dc21467f6%7C1662359688%7C5183999%7CFri%2C+04-Nov-2022+06%3A34%3A47+GMT; uid_tt=ad9f6e3e941dee28c273f262b1a6d816; uid_tt_ss=ad9f6e3e941dee28c273f262b1a6d816; sid_tt=3cb6595b3b90c714d39cc02dc21467f6; sessionid=3cb6595b3b90c714d39cc02dc21467f6; sessionid_ss=3cb6595b3b90c714d39cc02dc21467f6; sid_ucp_v1=1.0.0-KGIwYjcxZjc3MDg1ZjRjOGRmODJmN2VmYTc5NWMzZTQ5MDdhYTI1ZGYKFwjllsP01AEQiLHWmAYY7zEgDDgGQPQHGgJobCIgM2NiNjU5NWIzYjkwYzcxNGQzOWNjMDJkYzIxNDY3ZjY; ssid_ucp_v1=1.0.0-KGIwYjcxZjc3MDg1ZjRjOGRmODJmN2VmYTc5NWMzZTQ5MDdhYTI1ZGYKFwjllsP01AEQiLHWmAYY7zEgDDgGQPQHGgJobCIgM2NiNjU5NWIzYjkwYzcxNGQzOWNjMDJkYzIxNDY3ZjY; THEME_STAY_TIME=%22299679%22; IS_HIDE_THEME_CHANGE=%221%22; FOLLOW_NUMBER_YELLOW_POINT_INFO=%22MS4wLjABAAAAAUYcfIdX_7wOKwmVYJigUk4zt7uJV55OJwSjMG7YB_0%2F1662393600000%2F0%2F1662359982947%2F0%22; FOLLOW_LIVE_POINT_INFO=%22MS4wLjABAAAAAUYcfIdX_7wOKwmVYJigUk4zt7uJV55OJwSjMG7YB_0%2F1662393600000%2F0%2F1662361360480%2F0%22; download_guide=%223%2F20220905%22; __ac_nonce=06316d58000e304226129; __ac_signature=_02B4Z6wo00f01hpheowAAIDDkSrhbmanS8YaQX4AAOWckkWbjQ1cyyARO6o4maEQ5t4imV3Xy3WWYLo8zOvRfysRNkfi7-0Y0cJaodglQ-tM39wPmGqryRnpxTl9OQ0WisZjZ8aFzIM6TdME05; home_can_add_dy_2_desktop=%221%22; msToken=mMwtcOLsfjKhxYjESC6S50LV6ji4-rr6jGsZ4LHRl2kjXUMj8RBfSC0bxx7r_QwJThZNx3lxVDbXIL4yNRSMa7-Y_k97NdOfOMqp9lBolvVSlwwn2UHmqXNWl3tZ_lY=; tt_scid=nCcpWnJB8iGxRg70pb4qM8x-Xr9Ok.63dmnTsXeLmzq4ba8qGJfNJnRKn-ghQ7076c6a; msToken=buAprZvllbzafV9S74Neuf6W_WdTejsIRzmgr0lYkCHTPFc1Yd8Fa4KLzFKephaKC1PBfy3QYY15gHcLpsQFk0QBR5-ZcDPAn_mFk2IJfR-PA4Y62c07DwjCT3EMq5g='
}      #将user-agent和cookie 改成自己浏览器里面的参数，可以浏览器打开上面的网站先访问，然后按f12调出浏览器开发工具，f5重新刷新点进network有一个抖音网址可以在里面查看
for lis in driver.find_elements(By.XPATH,'//*[@class="gd20_QLx"]/a'):     #查看该网站的class的属性
    a = lis.get_attribute('href')   #查看class属性下面的href类
    response = requests.get(a,headers=headers)  #发送请求并调用头部信息
    test = response.text  #将test变量定义成respnose 解码后的一个字符串
    title = re.findall('<title data-react-helmet="true">(.*?)</title', response.text)[0]  # 数据解析,提取视频以及标题和视频播放地址
    title = re.sub(r'[\\\/\:\*\?\"\<\>\|\ \ -\  - \ ]', '_', title)  # 使用正则过滤掉解析数据里面的特殊符合替换成_线
    print(title)
    # print(response.text)
    herf = re.findall('src(.*?)video_mp4', response.text)[1]        #将真实视频的url过滤出来
    # print(herf)
    video_url = requests.utils.unquote(herf).replace('":"', "https:")      #将真实的url过滤出来的数据把：符号替换成https：这样可以直接访问
    video_content = requests.get(url=video_url,headers=headers).content     #向真实下载网址发送请求
    # print(video_content)
    with open('美女.video/' + title + '.mp4' , mode='wb') as f:               #保存在此脚本同目录下面的美女.video目录下面，wb是以二进制的读写写入的，如果没有该文件就创建
        f.write(video_content)
    print(video_url)
    # print(video_content)
driver.quit()                       #退出浏览器