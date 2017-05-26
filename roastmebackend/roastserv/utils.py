import socket
import re

def get_local_ip():
    if (socket.gethostname() == 'Anthonys-Mac.local'):
        return '192.168.1.83'
    else:
        return [l for l in ([ip for ip in socket.gethostbyname_ex(socket.gethostname())[2] if not ip.startswith("127.")][:1], [[(s.connect(('8.8.8.8', 53)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]]) if l][0][0]


def profanity_filter(filterText):
    originalText = filterText

    profanity = {
        'shit':'rainbow',
        'fuck':'marshmallow',
        'ass':'cupcakes'
    }

    pattern = re.compile(r'\b(' + '|'.join(profanity.keys()) + r')\b')
    result = pattern.sub(lambda x: profanity[x.group()], originalText)
    return result
