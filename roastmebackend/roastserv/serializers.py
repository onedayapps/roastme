from django.contrib.auth.models import User, Group
from rest_framework import serializers
from .models import Roast

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email', 'roasts')


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ('url', 'name')


class RoastSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Roast
        fields = ('roastee', 'picture', 'caption', 'creationDate')