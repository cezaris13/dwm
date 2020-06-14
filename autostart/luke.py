from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
from selenium.webdriver.common.action_chains import ActionChains
PATH="/home/pijus/Downloads/chromedriver"
options = Options()
options.add_argument('--headless')
options.add_argument('--disable-gpu')  # Last I checked this was necessary.
driver = webdriver.Chrome(PATH, chrome_options=options)
driver.get("https://lbry.tv/@Luke:7")
time.sleep(10)
html_source = driver.page_source
f = open('/home/pijus/.config/dwm/autostart/result', 'w')
f.write(html_source)
driver.quit() 
