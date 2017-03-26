# -*- coding: utf-8 -*-
# Generated by Django 1.10.6 on 2017-03-26 07:15
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('roastserv', '0002_auto_20170325_2218'),
    ]

    operations = [
        migrations.AlterField(
            model_name='roast',
            name='roastee',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]