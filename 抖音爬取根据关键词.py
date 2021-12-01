# # -*- codeing = utf-8 -*-
# # @Time : 2021/11/21 15:02
# # @Author :康康
# # @File :数据分析练习.py
# # @Sofware: PyCharm

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
    for x in range(1,99,2):    #range作用是从1-30直接然后除于4的执行次数
        time.sleep(1)
        j = x / 9
        js = "window.scrollTo(0, document.body.scrollHeight)"      #下滑到最底部

        driver.execute_script(js)

driver = webdriver.Chrome() #将谷歌浏览器实例化，也可以自己换成Firefox浏览器，需要调用谷歌浏览器驱动，可以自己核对浏览器版本进行下载谷歌浏览器是chromedriver，Firefox是geckodriver，浏览器版本可以在帮助里面关于Google浏览器，需要和脚本在统一目录下

driver.get("https://www.douyin.com/search/%s?publish_time=0&sort_type=0&source=normal_search&type=video"%zhuye_url)   #使用浏览器打开该网站
time.sleep(50)    #停止2秒
drop_down()   #调用函数

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36',
    'cookie': 'douyin.com; ttcid=2917f258143c4ef796bcf19c180a6b3234; ttwid=1%7CyJVrMJJdgWuDu-KnLh2b3_GME_1R90nBzsQvqx2RSSU%7C1638209768%7C8492ea22afb9e5e9a46866e0da55abab6aa8ba5846f0f039969f9307ee6a1312; _tea_utm_cache_6383=undefined; douyin.com; home_can_add_dy_2_desktop=0; AB_LOGIN_GUIDE_TIMESTAMP=1638209797930; MONITOR_WEB_ID=114521a0-a5b9-4e0c-8af2-a81a75a9d0c9; s_v_web_id=verify_kwkzteyw_dzdryOXU_WnVX_4X2u_8upu_ntoLmqO2jWRX; passport_csrf_token_default=37d2d6e25da4a61970b7c0e40663ddfb; passport_csrf_token=37d2d6e25da4a61970b7c0e40663ddfb; _tea_utm_cache_1300=undefined; _tea_utm_cache_2018=undefined; n_mh=RFxkDGPA95JG6P8Sv1LVrwqrsRqZ2aUayVb5P52hhws; sso_uid_tt=bb42171a5bc99125cd0c277afec29697; sso_uid_tt_ss=bb42171a5bc99125cd0c277afec29697; toutiao_sso_user=4b5af75fa434064fb5b8dcbfbdf0e7b3; toutiao_sso_user_ss=4b5af75fa434064fb5b8dcbfbdf0e7b3; odin_tt=b9112e77758d247e3710e5f3b3c1e751957f186720503ff504be442cb296710b4ec597ac032cf32830ccf444aa28ea44; passport_auth_status_ss=56ead8c0dd46cd031bd902d93d073589%2C; sid_guard=6d234d6a101b93735f8066b5f9ea3b1b%7C1638209915%7C5183998%7CFri%2C+28-Jan-2022+18%3A18%3A33+GMT; uid_tt=90f22b318e1d662f848c928ca7930717; uid_tt_ss=90f22b318e1d662f848c928ca7930717; sid_tt=6d234d6a101b93735f8066b5f9ea3b1b; sessionid=6d234d6a101b93735f8066b5f9ea3b1b; sessionid_ss=6d234d6a101b93735f8066b5f9ea3b1b; sid_ucp_v1=1.0.0-KGM3MDNlNjYzMTg2NmQxZjI3YTgyODVkYzdhYjY4ZGMzMzY3YjEwN2IKFQjllsP01AEQ-7KUjQYY7zE4BkD0BxoCbGYiIDZkMjM0ZDZhMTAxYjkzNzM1ZjgwNjZiNWY5ZWEzYjFi; ssid_ucp_v1=1.0.0-KGM3MDNlNjYzMTg2NmQxZjI3YTgyODVkYzdhYjY4ZGMzMzY3YjEwN2IKFQjllsP01AEQ-7KUjQYY7zE4BkD0BxoCbGYiIDZkMjM0ZDZhMTAxYjkzNzM1ZjgwNjZiNWY5ZWEzYjFi; passport_auth_status=56ead8c0dd46cd031bd902d93d073589%2C; IS_HIDE_THEME_CHANGE=1; THEME_STAY_TIME=299553; FOLLOW_LIVE_POINT_INFO=MS4wLjABAAAAAUYcfIdX_7wOKwmVYJigUk4zt7uJV55OJwSjMG7YB_0%2F1638288000000%2F0%2F1638224764391%2F0; msToken=9_bhDCwp_JjnyhBv_ppWillFn0f5n1ekXd0OTqqYhw-Ke2JE132FKRMGafZpNqCin8ysqEVdtIToQyXzzvbRO58BqpIePCWEt0goaT7qPrsclItjgiTEkfqc9TU=; __ac_nonce=061a63a770058fd94a60e; __ac_signature=_02B4Z6wo00f01KyObfAAAIDBz4Stm2N5I.SsqmlAAEqKaEX3yKgK-Epl7JwYf8WuYbevLFRiJyhhdNCuDwSqUUL96sfhVD.wUtvTYj6Pru2cQhIOvjwqhrJ31hJrTTUy--.0WHqDpbsfr6h214; tt_scid=cpxs3PgBeox0R5xpq6CetCcGyvm9vipQwlaN2CknpZgW8d3N3.0dWjgXvv7ueTnoea22; msToken=1Z731eNi-U5ZRUGAXw2RIcE7bXdDUj7d8q7lz2tfzpFe1kbeJgQ0V05nIxDKVKAWsLxDaW2ye652pGwglXte8S9mIBDQNorv-TexJ_fcd8uifLQIgr-8aWZo'
}      #将user-agent和cookie 改成自己浏览器里面的参数，可以浏览器打开上面的网站先访问，然后按f12调出浏览器开发工具，f5重新刷新点进network有一个抖音网址可以在里面查看
for lis in driver.find_elements(By.XPATH,'//*[@class="_863f6ea4f8ed8c3f88c51527f1ea8d43-scss"]/a'):     #查看该网站的class的属性
    a = lis.get_attribute('href')   #查看class属性下面的href类
    response = requests.get(a,headers=headers)  #发送请求并调用头部信息
    test = response.text  #将test变量定义成respnose 解码后的一个字符串
    title = re.findall('<title data-react-helmet="true">(.*?)</title', response.text)[0]  # 数据解析,提取视频以及标题和视频播放地址
    title = re.sub(r'[\\\/\:\*\?\"\<\>\|\ \ -\  - \ ]', '_', title)  # 使用正则过滤掉解析数据里面的特殊符合替换成_线
    print(title)
    herf = re.findall('src(.*?)%26vl%3D%26vr%3D', response.text)[1]        #将真实视频的url过滤出来
    print(herf)
    video_url = requests.utils.unquote(herf).replace('":"', "https:")      #将真实的url过滤出来的数据把：符号替换成https：这样可以直接访问
    video_content = requests.get(url=video_url,headers=headers).content     #向真实下载网址发送请求
    # #
    with open('美女.video/' + title + '.mp4' , mode='wb') as f:               #保存在此脚本同目录下面的美女.video目录下面，wb是以二进制的读写写入的，如果没有该文件就创建
        f.write(video_content)
    print(video_url)
    # print(video_content)
driver.quit()                       #退出浏览器