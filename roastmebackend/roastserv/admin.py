from django.contrib import admin
from .models import Roast

@admin.register(Roast)
class RoastAdmin(admin.ModelAdmin):
    list_display = ('roastee', 'creationDate', 'caption')
