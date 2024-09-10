from django.db import models
from django.contrib.auth.models import User


# 用户信息
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    likes = models.ManyToManyField('Music', blank=True, related_name='like_users')
    dislikes = models.ManyToManyField('Music', blank=True, related_name='dislike_users')
    first_run = models.BooleanField('是否第一次运行 执行冷启动策略', default=True)
    genre_subscribe = models.TextField('流派订阅', blank=True)
    language_subscribe = models.TextField('语言订阅', blank=True)

    def __str__(self):
        return self.user.username

    class Meta:
        verbose_name = '用户资料'
        verbose_name_plural = verbose_name


# 音乐
class Music(models.Model):
    song_name = models.CharField('歌曲名称', max_length=200)
    song_length = models.IntegerField('歌曲长度 单位为ms')
    genre_ids = models.CharField('歌曲流派', max_length=100)
    artist_name = models.CharField('歌手', max_length=200)
    composer = models.CharField('作曲', max_length=200)
    lyricist = models.CharField('作词', max_length=200)
    language = models.CharField('语种', max_length=20)
    url = models.TextField('音乐文件URL', default='')  # 添加的新字段

    def __str__(self):
        return self.song_name

    class Meta:
        verbose_name = '音乐'
        verbose_name_plural = verbose_name


# 评论区
class Comment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='用户名')
    song = models.ForeignKey(Music, on_delete=models.CASCADE, verbose_name='歌曲')
    comment = models.TextField('评论内容')
    comment_time = models.DateTimeField('评论时间', auto_now_add=True)  # 使用auto_now_add自动设置创建时间

    def __str__(self):
        return f"{self.user.username} 在 {self.comment_time} 评论了 {self.song.song_name}"

    class Meta:
        verbose_name = '评论'
        verbose_name_plural = verbose_name






