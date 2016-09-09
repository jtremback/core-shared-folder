''' Babel service
'''

import os

from core.service import CoreService, addservice
from core.misc.ipaddr import IPv4Prefix, IPv6Prefix

class BabelRef(CoreService):
    ''' This is for babel
    '''
    # a unique name is required, without spaces
    _name = "BabelRef"
    # you can create your own group here
    _group = "Routing"
    # this controls the starting order vs other enabled services
    _startindex = 50
    # list of startup commands, also may be generated during startup
    _startup = ('sh /home/jehan2/host/myservices/babel/startup.sh',)
    # list of shutdown commands
    _shutdown = ('sh /home/jehan2/host/myservices/babel/shutdown.sh',)

# this line is required to add the above class to the list of available services
addservice(BabelRef)