from django.contrib.auth.models import User, Group
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from django.core.files import File

from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework import permissions, viewsets

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status, generics
from utils import profanity_filter

from .serializers import UserSerializer, RoastSerializer, GroupSerializer, RoastCommentSerializer, NewRoastCommentSerializer, roastIDSerializer

import time
import os

from .models import Roast, RoastComment
from .utils import profanity_filter

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



class NewRoastComment(APIView):
    """
    curl -X PUT -H "Authorization: Token bae7f50e8870d6e0fcec4cd07485942014b625c2" -f "content=firstcomment"  "roast=1"
    """
    permission_classes = (permissions.IsAuthenticated,)

    def put(self, request):
        roast = get_object_or_404(Roast, pk=int(request.data["roast"]))
        RoastComment(
            content=profanity_filter(request.data["content"]),
            content_raw=request.data["content"],
            roaster=request.user,
            roast=roast
        ).save()
        return Response({'msg': 'success'}, status.HTTP_200_OK)

class UserViewSet(viewsets.ModelViewSet):

    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer

class GroupViewSet(viewsets.ModelViewSet):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer

class RoastViewSet(viewsets.ModelViewSet):
   queryset = Roast.objects.all()
   serializer_class = RoastSerializer


class singleRoast(generics.CreateAPIView):
    serializer_class = RoastSerializer
    def get_queryset(self):
        queryset = Roast.objects.all().filter(roast_id=request.query_params.get('rid', None))

class RoastCommentList(generics.ListCreateAPIView):
    serializer_class = RoastCommentSerializer
    #queryset = RoastComment.objects.all()
    def get_queryset(self):
        roastid = self.kwargs['rid']
        return RoastComment.objects.all().filter(roast_id=roastid)

def roastCount(request):
    return HttpResponse(Roast.objects.count())

class roastCountViewSet(viewsets.ModelViewSet):
    queryset = Roast.objects.all()
    serializer_class = roastIDSerializer

# Dont Need this right now
#class RoastCommentDetail(generics.RetrieveUpdateDestroyAPIView):
#   queryset = RoastComment.objects.all()
#  serializer_class = RoastCommentSerializer
