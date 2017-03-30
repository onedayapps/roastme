from django.conf.urls import url, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)
router.register(r'roasts', views.RoastViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^createroast/', views.CreateRoastView.as_view(), name='createroast')
]
