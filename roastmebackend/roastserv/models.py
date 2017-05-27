from __future__ import unicode_literals

from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class RoastmeUser(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    userPicture = models.ImageField(blank=True, null=True) #add stuff for thumbnails
    saltReceived = models.IntegerField(default=0)
    spiciness = models.IntegerField(default=0) #sauce received
    seasoning = models.IntegerField(default=0)

@receiver(post_save, sender=User)
def handle_user_save(sender, instance, created, **kwargs):
    if created:
        RoastmeUser.objects.create(user=instance)


class Roast(models.Model):
    roastee = models.ForeignKey(User)
    picture = models.ImageField(upload_to="roast")
    caption = models.CharField(max_length=256)
    creationDate = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return str(self.id)


class RoastComment(models.Model):
    content = models.CharField(max_length=256)
    content_raw = models.CharField(max_length=256)
    upvotes = models.IntegerField(default=0)
    sauce = models.IntegerField(default=0)
    downvotes = models.IntegerField(default=0)
    roaster = models.ForeignKey(User)
    roast = models.ForeignKey(Roast)
    commentDate = models.DateTimeField(auto_now_add=True)

class CommentVote(models.Model):
    comment = models.ForeignKey(RoastComment)
    vote = models.BooleanField()

