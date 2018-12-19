# #/usr/bin/python3
# # -*-coding:Utf-8 -*
# #oc+lm180718.1210
# # import re
# import time

# from pyvirtualdisplay import Display
# from selenium import webdriver

# # ####
# # #CONSTANTS
# # ####
# source = "https://epfl.ch"

# # # Set screen resolution to 1920x 1080  like most laptops
# display = Display(visible=0, size=(1920, 1080))
# display.start()

# driver = webdriver.Firefox()
# driver.get(source)

# navigationStart = driver.execute_script("return window.performance.timing.navigationStart")
# responseStart = driver.execute_script("return window.performance.timing.responseStart")
# domComplete = driver.execute_script("return window.performance.timing.domComplete")

# backendPerformance = responseStart - navigationStart
# frontendPerformance = domComplete - responseStart

# print("Back End: %s" % backendPerformance)
# print("Front End: %s" % frontendPerformance)

# driver.quit()


from pyvirtualdisplay import Display
from selenium import webdriver
import time

display = Display(visible=0, size=(800, 600))
display.start()

browser = webdriver.Firefox()

browser.get('http://www.python.org')

navigationStart = browser.execute_script("return window.performance.timing.navigationStart")
responseStart = browser.execute_script("return window.performance.timing.responseStart")
domComplete = browser.execute_script("return window.performance.timing.domComplete")

print(navigationStart, responseStart, domComplete)
print(responseStart-navigationStart, domComplete-navigationStart)

browser.quit()

display.stop()