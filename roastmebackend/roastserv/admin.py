from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import Roast, RoastComment, RoastmeUser


class RoastmeUserInline(admin.StackedInline):
    model = RoastmeUser
    can_delete = False
    verbose_name_plural = 'RoastmeUser'


# Define a new User admin
class UserAdmin(BaseUserAdmin):
    inlines = (RoastmeUserInline, )

# Re-register UserAdmin
admin.site.unregister(User)
admin.site.register(User, UserAdmin)

@admin.register(Roast)
class RoastAdmin(admin.ModelAdmin):
    list_display = ('roastee', 'creationDate', 'caption')

@admin.register(RoastComment)
class RoastComment(admin.ModelAdmin):
    list_display = ('content', 'upvotes', 'sauce', 'salt', 'roaster', 'roast', 'commentDate')


