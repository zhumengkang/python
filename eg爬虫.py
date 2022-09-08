from urllib import request
import re
from bs4 import BeautifulSoup
import requests
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36'
}
for i in range(10,48):
 step=0
 zhuye_url='http://egonlin.com/?paged='
 test='&cat=3'
 url_paged=zhuye_url+str(step+i)+test
 print(url_paged)
 rp = request.Request(url=url_paged,headers=headers)
 resp = request.urlopen(rp)
 title=re.findall('post-title" href="https://egonlin.com/\?p=(.*?)">(.*?)<',resp.read().decode())[1]
 # title_url='https://egonlin.com/?p='+str()
 title_gl=str(title)
 title_url_gl = re.findall("'(.*?)',",title_gl)[0]
 title_qwe=re.findall (", '(.*?)'",title_gl)[0]
 print(title)
 print(title_qwe)
 title_url='https://egonlin.com/?p='+str(title_url_gl)
 print(title_url)
 def get_html(titile_url):
     res = requests.get(f'{titile_url}')
     return res.text
 def run():
     html = get_html(title_url)
     soup = BeautifulSoup(html, 'html.parser')
     article = soup.select('#main article')[0]
     html_file = open(f"{title_qwe}.html", mode="w",encoding='utf-8')
     html_file.write(article.prettify())
     txt_file = open(f"{title_qwe}.txt", mode="w",encoding='utf-8')
     txt_file.write(article.text)
 if __name__ == '__main__':
     run()