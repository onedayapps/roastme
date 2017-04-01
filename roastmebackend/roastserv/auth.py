from rest_framework.authentication import TokenAuthentication
from django.contrib.auth.models import User

class TokenAuthenticationBackend(object):

    def authenticate(self, request=None):
        auth_response = TokenAuthentication().authenticate(request)
        return auth_response[0] if auth_response else None

    def get_user(self, user_id):
        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return None
