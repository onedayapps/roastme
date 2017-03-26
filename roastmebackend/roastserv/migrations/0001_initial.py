# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-03-26 04:09
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Roast',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('picture', models.ImageField(upload_to=b'')),
                ('creationDate', models.DateTimeField(auto_now_add=True)),
                ('caption', models.CharField(max_length=256)),
            ],
        ),
        migrations.CreateModel(
            name='RoastComment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=256)),
                ('upvotes', models.IntegerField(default=0)),
                ('sauce', models.IntegerField(default=0)),
                ('salt', models.IntegerField(default=0)),
                ('commentDate', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='RoastmeUser',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('userPicture', models.ImageField(blank=True, null=True, upload_to=b'')),
                ('saltReceived', models.IntegerField(default=0)),
                ('spiciness', models.IntegerField(default=0)),
                ('sauceInventory', models.IntegerField(default=0)),
                ('saltInventory', models.IntegerField(default=0)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddField(
            model_name='roastcomment',
            name='roastee',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='roastserv.RoastmeUser'),
        ),
        migrations.AddField(
            model_name='roast',
            name='roastComment',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='roastserv.RoastComment'),
        ),
        migrations.AddField(
            model_name='roast',
            name='roastee',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='roastserv.RoastmeUser'),
        ),
    ]
