import requests
headers = {
"User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36",
}


def test():
    zhuye_url = str(input("请输入聊天内容: \n "))
    url = "http://81.70.100.130/api/xiaoai.php?msg=%s&n=text"%zhuye_url
    response = requests.get(url=url, headers=headers).text
    print(response)

    for  i in range(100):
        i=test()
if __name__ == '__main__':
    test()