#!/usr/bin/env python3

import sys
import re
import requests

DOWNLOAD_PATH = "/downloads/"
QBITTORRENT_URL = "http://qbittorrent.lab.com"
USERNAME = "admin"
PASSWORD = "adminadmin"


def construct_packet_login(username, password):
    "construct a packet for login"
    headers = {
        'Accept': '*/*',
        'Accept-Language': 'en-us,en;q=0.9',
        'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Origin': QBITTORRENT_URL,
        'Proxy-Connection': 'keep-alive',
        'Referer': QBITTORRENT_URL,
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36'}
    payload = {
        'username': username,
        'password': password}
    return headers, payload

def construct_packet_add(cookie,
                         magnet,
                         download_path=DOWNLOAD_PATH):
    "construct a packet for adding magnet"
    headers = {
        'Cookie': f"{cookie}",
        'User-Agent': "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36"}
    payload = {'urls': magnet,
               'autoTMM': "false",
               'save-path': download_path,
               'paused': "false",
               'contentLayout': "Original"}
    return headers, payload

if __name__ == '__main__':
    magnet_link = sys.argv[1]

    # login
    headers, payload = construct_packet_login(USERNAME, PASSWORD)
    QBITTORRENT_API_LOGIN = f"{QBITTORRENT_URL}/api/v2/auth/login"
    login_result = requests.post(QBITTORRENT_API_LOGIN, headers=headers, data=payload)
    if login_result.status_code == 200 and login_result.headers.get('set-cookie'):
        cookie = re.match(r'(^SID=.*?);\s', login_result.headers.get('set-cookie')).group(1)
        print(f"Successfully Login, cookie set: {cookie}")
    else:
        print(f"failed, http code = {login_result.status_code}, message = {login_result.text}")
        sys.exit()

    # add magnet link
    headers, payload = construct_packet_add(cookie, magnet_link)
    QBITTORRENT_API_ADD= f"{QBITTORRENT_URL}/api/v2/torrents/add"
    add_result = requests.post(QBITTORRENT_API_ADD, headers=headers, data=payload)
    print(add_result.text)
