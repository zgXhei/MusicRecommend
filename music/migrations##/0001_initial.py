# Generated by Django 5.0.6 on 2024-08-06 09:09

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Music',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('song_name', models.CharField(max_length=200, verbose_name='歌曲名称')),
                ('song_length', models.IntegerField(verbose_name='歌曲长度 单位为ms')),
                ('genre_ids', models.CharField(max_length=100, verbose_name='歌曲流派')),
                ('artist_name', models.CharField(max_length=200, verbose_name='歌手')),
                ('composer', models.CharField(max_length=200, verbose_name='作曲')),
                ('lyricist', models.CharField(max_length=200, verbose_name='作词')),
                ('language', models.CharField(max_length=20, verbose_name='语种')),
            ],
            options={
                'verbose_name': '音乐',
                'verbose_name_plural': '音乐',
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_run', models.BooleanField(default=True, verbose_name='是否第一次运行 执行冷启动策略')),
                ('genre_subscribe', models.TextField(blank=True, verbose_name='流派订阅')),
                ('language_subscribe', models.TextField(blank=True, verbose_name='语言订阅')),
                ('dislikes', models.ManyToManyField(blank=True, related_name='dislike_users', to='music.music')),
                ('likes', models.ManyToManyField(blank=True, related_name='like_users', to='music.music')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': '用户资料',
                'verbose_name_plural': '用户资料',
            },
        ),
    ]