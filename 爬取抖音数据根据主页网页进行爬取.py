from selenium import  webdriver
from selenium.webdriver.common.keys import Keys

import time
from urllib import request
import requests
import re
zhuye_url = str(input("请输入你要爬取的主页链接: \n "))
def drop_down():
    """执行页面下滑滚动操作"""#javascript
    for x in  range(1, 99,2):    #range作用是从1-99直接如何处于2的执行次数
        time.sleep(1)
        j = x / 9
        js = "window.scrollTo(0, document.body.scrollHeight)"      #下滑到最底部

        driver.execute_script(js)




driver = webdriver.Firefox()  #实例化浏览器对象

driver.get(zhuye_url)
# print("为了更好的爬取视频请在30秒内进行扫码登录倒计时开始")
#
# time_left = 30
# while time_left > 0:
#     print('倒计时(s):',time_left)
#     time.sleep(1)
#     time_left = time_left - 1
time.sleep(2)
drop_down()

lis = driver.find_elements_by_css_selector('#root > div > div:nth-child(2) > div > div._67f6d320f692f9e5f19d66f4c8a1ecf9-scss > div._927ae3b0dd790b5b62eae61c7d2fa0bc-scss > div:nth-child(2) > ul > li')
#获取li标签
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0',
    'cookie': 'douyin.com; MONITOR_DEVICE_ID=a9aa8e11-bda4-4f92-8364-bb2811ef6bf7; __ac_nonce=0619f15350038792576d9; __ac_signature=_02B4Z6wo00f01Dl1mDgAAIDAO9JxktYid7w5VbyAAG.J77; ttcid=465996dfbf2c43d7a0909bd05dacadaf40; ttwid=1%7ChuXHWdYQ7l7RB5OJO7HDmYfHQquzqLUr8yvBEPgG5l8%7C1637815606%7C6efe7f29e888df5c809a50539f11b1c81289815f66b4719ba9265c88af8b6277; _tea_utm_cache_6383=undefined; MONITOR_WEB_ID=68428810-35b9-4c78-bb6f-408edfc692a0; s_v_web_id=verify_e4f7c82c7431fef74b7fb87af19e5c53; _tea_utm_cache_2018=undefined; msToken=ytl1_Aw9IRPjt3VyXSY3TVIUifTuwLTMK0HkhkoHlub6rvbt9PDXBz-Bo1blckd3Lcvn1ZSncWxpt7S4Fs9QNyq5nppSfEFZ-RVMgq26o6PwIjMsJirr0g==; passport_csrf_token_default=f5696ccaf19ba9d8b7bf5b7820119bae; passport_csrf_token=f5696ccaf19ba9d8b7bf5b7820119bae; tt_scid=iFSVDdkOMQRm9KdBMPv19e05ARqYLWQwD9tlF2l7V6RYilUq-vN1Isu.RiLMKGbw7050'
}
for li in lis:
    herf = li.find_element_by_css_selector('a').get_attribute('href')  #提取li标签里面的a里面的href内容
    #print(herf)    #打印herf里面的内容
    response = requests.get(url=herf,headers=headers)  #发送请求并调用头部信息
    title = re.findall('<title data-react-helmet="true">(.*?)</title',response.text)[0]    #数据解析,提取视频以及标题和视频播放地址
    title = re.sub(r'[\\\/\:\*\?\"\<\>\|\ \ -\  - \ ]', '_', title)  # 使用正则过滤掉解析数据里面
    herf = re.findall('src(.*?)vr%3D%2', response.text)[1]
    video_url = requests.utils.unquote(herf).replace('":"', "https:")#将真实的url过滤出来的数据把：符号替换成https：这样可以直接访问
    video_content = requests.get(url=video_url,headers=headers).content #向真实下载网址发送请求

    with open('test/' + title + '.mp4' , mode='wb') as f:
        f.write(video_content)
    print(video_url)
    print(video_content)

driver.quit()                       #退出浏览器


