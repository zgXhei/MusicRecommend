"""music_recommend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from music import views

urlpatterns = [
    path('grappelli/', include('grappelli.urls')),  # 后台
    path('admin/', admin.site.urls),  # 后台
    path('', views.home),  # 首页
    path('recommend', views.recommend),  # 推荐
    path('sign_in', views.sign_in),  # 登录
    path('register', views.register),  # 注册
    path('logout', views.user_logout),  # 退出
    path('like/<int:pk>', views.like),  # 喜欢
    path('dislike/<int:pk>', views.dislike),  # 不喜欢
    path('play', views.play),  # 播放
    path('play/<int:pk>', views.play),  # 播放
    path('user', views.user_center),  # 用户中心
    path('search', views.search),  # 搜索
    path('taolun', views.taolun),  # 讨论
    path('create_comment/<int:pk>/', views.create_comment, name='create_comment'),  # 讨论
]

