#!/usr/bin/env python3
# sshl.py
# diphia@2021, refactored@2022
# This script is used to show the saved ssh targets

def parse_lines(lines):
    """ parse a list of lines to Host object

    >>> target = ["Host router", "    HostName 10.0.0.1", "    User root", "    Port 22", "    IdentityFile /Users/diphia/.ssh/id_rsa"]
    >>> router = parse_lines(target)
    >>> print(router)
    router: root@10.0.0.1:22
    """
    kwmap = {}
    for l in lines:
        segments = l.strip().split(" ")
        key, value = segments[0].lower(), segments[1].lower()
        kwmap[key] = value
    kwmap.setdefault('port', '22')
    kwmap.setdefault('identityfile', '')
    kwmap.setdefault('preferredauthentications', '')
    return Host(kwmap.get('host'), kwmap.get('hostname'), kwmap.get('user'), kwmap.get('port'))


def slice_file(config_file):
    """ slice whole file, return a list of segments shaped in list

    >>> file = open("/Users/diphia/temp/ssh_config_test", 'r', encoding = "UTF-8")
    >>> segments = slice_file(file)
    >>> print(parse_lines(segments[0]))
    router: root@10.0.0.1:22
    >>> print(parse_lines(segments[1]))
    hecs: diphia@124.71.123.123:22
    >>> file.close()
    """
    segment, result = [], []
    for current_line in config_file:
        if current_line.strip()[0] == '#':
            continue
        if current_line.split(' ')[0] == 'Host' and segment:
            result.append((list(segment)))
            segment = []
        segment.append(current_line)
    result.append((list(segment)))
    return result


class Host:
    """
    >>> router = Host("router", "10.0.0.1", "root")
    >>> router
    < Host router >
    >>> print(router)
    router: root@10.0.0.1:22
    >>> remote_mac = Host("remote_mac", "17.0.0.1", "diphia", 6022)
    >>> print(remote_mac)
    remote_mac: diphia@17.0.0.1:6022
    """
    def __init__(self, label, hostname, user, port='22'):
        self.label = label
        self.hostname = hostname
        self.user = user
        self.port = port

    def show_with_align(self):
        "show info with align, will padding spaces and truncate long hostnames"
        port_output = "" if self.port == '22' else f":{self.port}"
        return f"{self.label[:10].ljust(10)}: {self.user} @ {self.hostname}{port_output}"

    def __repr__(self):
        return f"< Host {self.label} >"

    def __str__(self):
        return f"{self.label}: {self.user}@{self.hostname}:{self.port}"

if __name__ == "__main__":
    PATH = "/Users/diphia/.ssh/config"
    with open(PATH, encoding="UTF-8") as f:
        slices = slice_file(f)
        host_objects = map(parse_lines, slices)
        for host in host_objects:
            print(host.show_with_align())
