#!/bin/bash
./install_selenium.sh > .install.log
./install_influxDB.sh >> .install.log
./install_grafana.sh >> .install.log
