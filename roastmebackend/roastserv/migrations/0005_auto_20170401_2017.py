# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-04-02 02:17
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('roastserv', '0004_auto_20170326_0210'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='roastcomment',
            name='roastee',
        ),
        migrations.AddField(
            model_name='roastcomment',
            name='roaster',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
            preserve_default=False,
        ),
    ]
