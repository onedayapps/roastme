from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import User

class RoastmeUser(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    userPicture = models.ImageField(blank=True, null=True) #add stuff for thumbnails
    saltReceived = models.IntegerField(default=0)
    spiciness = models.IntegerField(default=0) #sauce received
    seasoning = models.IntegerField(default=0)

class Roast(models.Model):
    roastee = models.ForeignKey(User)
    picture = models.ImageField(upload_to="roast")
    caption = models.CharField(max_length=256)
    creationDate = models.DateTimeField(auto_now_add=True)

class RoastComment(models.Model):
    content = models.CharField(max_length=256)
    upvotes = models.IntegerField(default=0)
    sauce = models.IntegerField(default=0)
    salt = models.IntegerField(default=0)
    roastee = models.ForeignKey(RoastmeUser)
    roast = models.ForeignKey(Roast)
    commentDate = models.DateTimeField(auto_now_add=True)
