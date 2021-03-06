from django.contrib.auth.models import User, Group
from rest_framework import serializers
from rest_framework.fields import HiddenField, CurrentUserDefault

from .models import Roast, RoastComment, CommentVote

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email', 'roasts')


class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ('url', 'name')


class RoastSerializer(serializers.ModelSerializer):
    class Meta:
        model = Roast
        fields = ('roastee', 'picture', 'caption', 'creationDate')

class RoastCommentSerializer(serializers.ModelSerializer):
    roaster = serializers.CharField(source='roaster.username')

    class Meta:
        model = RoastComment
        fields = ('content', 'upvotes', 'sauce', 'downvotes', 'roaster', 'roast', 'commentDate')

class NewRoastCommentSerializer(serializers.ModelSerializer):
    roaster = HiddenField(default=CurrentUserDefault())

    class Meta:
        model = RoastComment
        fields = ('content', 'roaster', 'roast')

class roastIDSerializer(serializers.ModelSerializer):
    id = serializers.ReadOnlyField()

    class Meta:
        model = Roast
        fields = ('id',)

class CommentVote(serializers.ModelSerializer):
    class Meta:
        model  = CommentVote
        fields = ('comment', 'vote')