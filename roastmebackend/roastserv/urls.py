from django.conf.urls import url, include
from . import views
from rest_framework import routers
from rest_framework.urlpatterns import format_suffix_patterns

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)
router.register(r'roasts', views.RoastViewSet)


urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^createroastcomment/', views.NewRoastComment.as_view(), name='createcomment'),
    url(r'^createroast/', views.CreateRoastView.as_view(), name='createroast'),
    url(r'^roasts/(?P<rid>[0-9]+)/$', views.singleRoast.as_view()),
    url(r'^roastscomments/(?P<rid>[0-9]+)/$', views.RoastCommentList.as_view())

]


