from django.shortcuts import render
from django.http import HttpResponse
from django.core.files import File

from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework import permissions

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
import time
import os

from .models import Roast

def index(request):
    return HttpResponse("Roastme")


class CreateRoastView(APIView):
    """
    curl -X PUT -H "Authorization: Token <token>" -F "roastimage_file=@/path/to/image.jpg" -f "caption=blah" url:port
    """

    permission_classes = (permissions.IsAuthenticated,)
    parser_classes = (MultiPartParser, FormParser,)

    def put(self, request):
        roast = Roast(
            roastee=request.user,
            caption=request.data["caption"]
        )
        remote_image_file = request.FILES["roastimage"]
        image_format = os.path.splitext(remote_image_file.name)[1][1:]
        roast.picture.save(
            "%s_%s.%s" % (request.user.username, time.strftime("%d%m%Y_%H%M%S"), image_format),
            File(remote_image_file)
        )
        roast.save()

        return Response({'msg': 'success'}, status.HTTP_200_OK)