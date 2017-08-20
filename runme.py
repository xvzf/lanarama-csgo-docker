#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import sys
import os
from binascii import hexlify
import struct
import socket
import argparse
import smtplib
from _thread import start_new_thread

def send_mail(serverip, msg):
    receivers = ["matthias@xvzf.tech"]
    server = smtplib.SMTP('hosted.mailcow.de:587')
    server.starttls()
    server.login("lanarama@xvzf.tech", "1Rl5ZhlL28TR4hqd")
    for i in receivers: server.sendmail("lanarama@xvzf.tech", i, "\r\n".join(["From: lanarama@xvzf.tech","To: %s" % i, "Subject: CSGO SERVER IP:%s" % serverip, "", msg]))
    server.quit()

class csvetovote:

    maps =      ["de_dust2", "de_inferno", "de_nuke", "de_mirage", "de_cache", "de_cobblestone", "de_overpass"]

    teams=      ["placeholder", "placeholder"]
    teamturn=   0


    IP=         ""
    PLAYERS=     5

    def __init__(self):
        parser = argparse.ArgumentParser(description="CSGO Server launcher with veto vote")
        parser.add_argument("--ip", help="host IP", nargs=1)
        parser.add_argument("--players", help="number of players - 1,2,3,5", nargs=1)

        self.args = parser.parse_args()

        self.setup_teams()

    def handlefinalmap(self):
        send_mail(self.get_ip, "Final Map: %s" % self.maps[0])

    def handleget(self, path):
        if path.split("/")[1] not in self.teams or len(path.split("/")) != 2:
            return str(self.maps)

        if len(self.maps) == 1:
            return "<h> Final map: %s</h>" % self.maps[0]
        else:
            buffer = "<h> %s on %s" % (self.PLAYERS, self.PLAYERS)
            if path.split("/")[1] == self.teams[self.teamturn]:
                buffer += "<h> Please vote <h>"
            else:
                buffer += "<h> Please wait for the opposite team to vote </h>"

            buffer += "<form action=\"\" method=\"post\">"
            for i in self.maps:
                buffer += "<button name=\"" + path.split("/")[1] + "\" value=\"" + i + "\">" + i + "</button></br>"
            buffer += "</form>"
            buffer += "<script>setTimeout(function(){window.location.reload(1);},2500);</script>"
            return buffer

    def handlepost(self, postmessage):

        _team = postmessage.split("=")[0]
        _map = postmessage.split("=")[1]

        print(_team, _map)
        print(self.teamturn)
        buffer = ""

        if _team == self.teams[self.teamturn]:
            self.maps.remove(_map)
            print("Team: %s removed %s" % (_team, _map))
            buffer += "<h> You removed %s from the map list</h>" % _map

            if self.teamturn == 1:
                self.teamturn = 0
            else:
                self.teamturn = 1
        else:
            buffer += "<h> YOU ARE NOT ALLOWED TO VOTE, WAIT FOR THE OTHER TEAM TO FINISH THEIR CHOICE</h>"

        buffer += "<script>window.setTimeout('window.location = \"%s\"',1000);</script>" % _team
        return buffer

    def setup_teams(self):
        if struct.unpack('b', os.urandom(1))[0] > 0:
            self.teamturn = 0
        else:
            self.teamturn = 1

        self.teams[0] = hexlify(os.urandom(32)).decode("utf-8")
        self.teams[1] = hexlify(os.urandom(32)).decode("utf-8")
        IP = self.get_ip()
        print("TEAMLINK 1:  http://%s/%s" % (IP, self.teams[0]))
        print("TEAMLINK 2:  http://%s/%s" % (IP, self.teams[1]))
        print("TEAMTURN  : %s" % self.teams[self.teamturn])

        send_mail(IP, "\r\n".join(["TEAMLINK 1:  http://%s/%s" % (IP, self.teams[0]), "TEAMLINK 2:  http://%s/%s" % (IP, self.teams[1])]))

        return True

    def get_ip(self):
        return self.args.ip[0]



# HTTP SERVER
cssolver = csvetovote() #quickndirty
class mapvoteserver(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write(bytes(cssolver.handleget(self.path), "utf8"))
        return


    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(bytes(cssolver.handlepost(post_data.decode("UTF-8")), "utf-8"))
        return




# ===============================================================================================

def run(handler_class=mapvoteserver, server_class=HTTPServer):
    server_address = ('', 8080)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()

if __name__ == "__main__":
    run()
