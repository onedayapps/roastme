from django.conf.urls import url, include
from . import views

urlpatterns = [
    url(r'^', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^createroast/', views.CreateRoastView.as_view(), name='createroast')
]
