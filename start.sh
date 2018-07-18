#!/bin/bash

navigationStart = browser.execute_script("return window.performance.timing.navigationStart")
responseStart = browser.execute_script("return window.performance.timing.responseStart")
domComplete = browser.execute_script("return window.performance.timing.domComplete")

print(navigationStart, responseStart, domComplete)
virtFold="venv"


source $virtFold/bin/activate

python3 get_home_page.py

deactivate