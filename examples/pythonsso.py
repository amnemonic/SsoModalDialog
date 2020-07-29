#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
Usage egample of SsoModalDialog program.
https://github.com/amnemonic/SsoModalDialog

2020 (c) Adam Mnemonic
'''


import subprocess
import urllib.parse
import re
from base64 import b64decode
import xml.dom.minidom

#run subprocess and get stdout
returned_output = subprocess.check_output('..\SsoModalDialog.exe "https://stubidp.sustainsys.com/"').decode("utf-8")

#find saml_response using regular expression
saml_response = re.findall(r"\[POST\]SAMLResponse=(.*?)\[\/POST\]",returned_output)[0].strip()

#urldecode -> base64 decode -> prettefy XML in one line
saml_rexponse_xml = xml.dom.minidom.parseString( b64decode(urllib.parse.unquote(saml_response)) ).toprettyxml(indent=' '*2)

#done
print(saml_rexponse_xml)
