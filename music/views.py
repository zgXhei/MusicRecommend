from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.core.paginator import Paginator
from django.shortcuts import render, get_object_or_404, redirect
from .models import Music, UserProfile, Comment
from Data.recommend import build_recommend
from Data.subscribe import build_genre_ids, build_languages
from .decorators import cold_boot
import requests as rq

current_play = None

current_recommend = []


@login_required(login_url='/sign_in')
def home(request):
    return all(request)


@cold_boot
def all(request):
    page_number = request.GET.get('page', 1)
    queryset = Music.objects.all()
    paginator = Paginator(queryset, 20)  # 分页
    musics = paginator.page(page_number)
    context = {
        'musics': musics,
        'user_likes': [],
        'user_dislikes': []
    }
    # 如果登录的首页
    if request.user.is_authenticated:
        user_profile = UserProfile.objects.filter(user=request.user)
        if user_profile.exists():
            user_profile = user_profile.first()  # 用户信息
            context['user_likes'] = user_profile.likes.all()  # 获取用户喜欢或不喜欢的数据
            context['user_dislikes'] = user_profile.dislikes.all()
    return render(request, 'list.html', context)


# 注册页面
def register(request):
    # 如果是post请求就提交表单，不是就直接返回注册页面
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        if User.objects.filter(username=username).exists():
            messages.add_message(request, messages.ERROR, '用户名已存在！')
        else:
            user_obj = User.objects.create_user(username=username, password=password)
            UserProfile.objects.create(user=user_obj)
            messages.add_message(request, messages.SUCCESS, '注册成功！')
            return HttpResponseRedirect('/')  # 注册成功跳转到首页
    return render(request, 'register.html')


# 登录页面
def sign_in(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user=user)
            messages.success(request, '登录成功')
            print('登录成功')
            return HttpResponseRedirect('/')  # 登录成功跳转首页
        else:
            messages.add_message(request, messages.ERROR, '用户名或密码错误！')
            print('登录失败')
    return render(request, 'sign_in.html')


# 退出登录
@login_required(login_url='/sign_in')
def user_logout(request):
    logout(request)
    messages.info(request, '退出登录')
    return HttpResponseRedirect('/')


# 推荐算法
@login_required(login_url='/sign_in')
@cold_boot
def recommend(request):
    page_number = request.GET.get('page', 1)
    # --------------------推荐---------------------
    recommend_set = build_recommend(request, request.user)  # 获取request.user的请求码，根据用户信息分析推荐数据
    # --------------------推荐---------------------
    paginator = Paginator(recommend_set, 20)  # 分页
    musics = paginator.page(page_number)  # 推荐的音乐
    context = {
        'musics': musics,
        'user_likes': [],
        'user_dislikes': []
    }
    user_profile = UserProfile.objects.filter(user=request.user)

    # 将根据用户获取到的推荐音乐进行渲染返回到前端
    if user_profile.exists():
        user_profile = user_profile.first()
        context['user_likes'] = user_profile.likes.all()
        context['user_dislikes'] = user_profile.dislikes.all()
    return render(request, 'recommend.html', context)


# 用户将音乐添加到喜欢，和数据库进行交互
@login_required(login_url='/sign_in')
def like(request, pk: int):
    user_obj = UserProfile.objects.get(user=request.user)
    music_obj = get_object_or_404(Music.objects.all(), pk=pk)  # 通过ID查找歌曲信息
    user_obj.likes.add(music_obj)  # 添加喜欢
    user_obj.dislikes.remove(music_obj)  # 删除不喜欢
    messages.add_message(request, messages.INFO, '已经添加到我喜欢')
    redirect_url = request.GET.get('from', '/')
    if 'action' in request.GET:
        redirect_url += f'&action={request.GET["action"]}'
    return HttpResponseRedirect(redirect_url)


#用户添加不喜欢
@login_required(login_url='/sign_in')
def dislike(request, pk: int):
    user_obj = UserProfile.objects.get(user=request.user)
    music_obj = get_object_or_404(Music.objects.all(), pk=pk)  #根据id查找歌曲信息
    user_obj.dislikes.add(music_obj)  # 添加到不喜欢
    user_obj.likes.remove(music_obj)  # 删除掉喜欢
    messages.add_message(request, messages.INFO, '已经添加到我不喜欢')
    redirect_url = request.GET.get('from', '/')
    if 'action' in request.GET:
        redirect_url += f'&action={request.GET["action"]}'
    return HttpResponseRedirect(redirect_url)


# 导入login_required装饰器，确保只有登录用户可以访问该视图
@login_required(login_url='/sign_in')
# 定义视图函数play，接受请求对象request和音乐的主键pk
def play(request, pk: int = 0):
    # 使用global关键字声明current_play为全局变量，以便在函数内部修改它
    global current_play

    # 如果提供了有效的音乐ID（pk > 0）
    if pk > 0:
        # 使用Django ORM查询Music模型，寻找匹配的主键
        music_obj = Music.objects.filter(pk=pk)
        # 如果查询结果存在
        if music_obj.exists():
            # 将查询结果的第一个对象赋值给current_play
            current_play = music_obj.first()

    # 如果current_play为None，表示没有找到音乐对象
    if current_play is None:
        # 使用Django消息框架添加一条错误消息
        messages.error(request, '当前没有正在播放的音乐')
        # 重定向用户到首页
        return HttpResponseRedirect('/')

    # 如果成功找到音乐对象，渲染play.html模板
    # 将当前音乐对象current_play作为上下文传递给模板
    headers = {
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6',
        'Cache-Control': 'max-age=0',
        'If-Modified-Since': 'Fri, 26 Apr 2024 09:50:16 GMT',
        'If-None-Match': '"869bb693272b5fb2b82669a1191b8e26"',
        'Proxy-Connection': 'keep-alive',
        'Range': 'bytes=0-1048575',
        'Upgrade-Insecure-Requests': '1',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0',
    }
    rsp = rq.get(r'http://music.163.com/song/media/outer/url?id='+current_play.url, headers=headers)  # 拼接字符串带上请求头进行请求
    music_url = rsp.url
    print(music_url)  # 输出结果

    return render(request, 'play.html', context={'music': current_play, 'music_url': music_url})  # 将数据返回到前端

# 用户信息
@login_required(login_url='/sign_in')
def user_center(request):
    user_profile = UserProfile.objects.filter(user=request.user)  # 去寻找用户信息
    if user_profile.exists():
        profile_obj: UserProfile = user_profile.first()
    else:
        messages.error(request, '找不到用户资料，请重新登录')
        logout(request)
        return HttpResponseRedirect('/')
    # 添加个人信息，对感兴趣的流派和语种进行选择提交
    if request.method == 'POST':
        genres = request.POST.getlist('genres[]', '')
        languages = request.POST.getlist('languages[]', '')
        profile_obj.first_run = False

        # 标志位，检测是否进行了修改
        genre_modified = False
        language_modified = False

        if len(genres) > 0:
            profile_obj.genre_subscribe = ','.join(genres)
            genre_modified = True
        elif not profile_obj.first_run:
            profile_obj.genre_subscribe = ''
            genre_modified = True

        if len(languages) > 0:
            profile_obj.language_subscribe = ','.join(languages)
            language_modified = True
        elif not profile_obj.first_run:
            profile_obj.language_subscribe = ''
            language_modified = True

        # 保存并返回消息
        if genre_modified:
            profile_obj.save()
            messages.success(request, '修改流派订阅成功！')
        if language_modified:
            profile_obj.save()
            messages.success(request, '修改语言订阅成功！')

    context = {
        'user_likes': profile_obj.likes.all(),
        'user_dislikes': profile_obj.dislikes.all(),
        'genres': build_genre_ids(),
        'languages': build_languages(),
        'genre_subscribe': profile_obj.genre_subscribe.split(','),
        'language_subscribe': []
    }

    # 去除空字符
    for lang in profile_obj.language_subscribe.split(','):
        lang = lang.strip()
        context['language_subscribe'].append(lang)

    return render(request, 'user.html', context=context)


# 搜索栏
@login_required(login_url='/sign_in')
def search(request):
    if 'keyword' not in request.GET:
        messages.error(request, '请输入搜索关键词')
        return HttpResponseRedirect('/')

    keyword = request.GET.get('keyword')
    action = request.GET.get('action')

    musics = []

    # 两种搜索方式，歌曲和歌手
    if action == 'song_name':
        musics = Music.objects.filter(song_name__contains=keyword)  # 在music这个表中根据keyword搜索
    if action == 'artist_name':
        musics = Music.objects.filter(artist_name__contains=keyword)

    messages.info(request, f'搜索关键词：{keyword}，找到 {len(musics)} 首音乐')
    # 将再数据库中搜索到的数据进行返回到前端进行渲染
    context = {
        'musics': musics,
        'user_likes': [],
        'user_dislikes': []
    }
    if request.user.is_authenticated:
        user_profile = UserProfile.objects.filter(user=request.user)
        if user_profile.exists():
            user_profile = user_profile.first()
            context['user_likes'] = user_profile.likes.all()
            context['user_dislikes'] = user_profile.dislikes.all()

    return render(request, 'list.html', context)


@login_required(login_url='/sign_in')
def taolun(request):
    page_number = request.GET.get('page', 1)
    queryset = Comment.objects.all()
    paginator = Paginator(queryset, 10)  # 分页
    comments = paginator.page(page_number)
    context = {'comments': comments}
    print(queryset)
    return render(request, 'taolun.html', context)
1

def create_comment(request, pk: int = 0):
    if request.method == 'POST':
        # 从POST数据中获取评论内容
        comment_text = request.POST.get('comment', '').strip()
        user = request.user
        song_id = pk
        song = Music.objects.get(id=song_id)
        new_comment = Comment.objects.create(user=user, song=song, comment=comment_text)
        new_comment.save()
        return HttpResponseRedirect(f'/play/{pk}')
    return render(request, 'create_comment.html', {'pk': pk})
