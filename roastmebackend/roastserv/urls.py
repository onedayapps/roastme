from django.conf.urls import url, include
from . import views
from rest_framework import routers
from rest_framework.urlpatterns import format_suffix_patterns

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)
router.register(r'roasts', views.RoastViewSet)
router.register(r'rids', views.roastCountViewSet)



urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^createroastcomment/', views.NewRoastComment.as_view(), name='createcomment'),
    url(r'^createroast/', views.CreateRoastView.as_view(), name='createroast'),
    url(r'^roasts/(?P<rid>[0-9]+)/$', views.singleRoast.as_view()),
    url(r'^comments/(?P<rid>[0-9]+)/$', views.RoastCommentList.as_view()),
    url(r'^roastcount/', views.roastCount, name='roastCount'),
    url(r'^comments/(?P<cid>[0-9]+)/upvote/$', views.UpvoteComment.as_view()),
    url(r'^comments/(?P<cid>[0-9]+)/downvote/$', views.DownvoteComment.as_view())

]


