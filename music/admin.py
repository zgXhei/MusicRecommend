from django.contrib import admin
from .models import Music, UserProfile


# Register your models here.
@admin.register(Music)
class MusicAdmin(admin.ModelAdmin):
    list_display = ['song_name', 'song_length', 'genre_ids', 'artist_name', 'composer', 'lyricist', 'language']

    search_fields = ['song_name', 'artist_name', 'composer', 'language']

    list_filter = ['language']

    list_per_page = 12

    ordering = ['id']


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['pk', 'user_id', 'user', 'first_run', 'genre_subscribe', 'language_subscribe']

    search_fields = ['user']

    list_filter = ['genre_subscribe', 'language_subscribe']

    list_per_page = 12

    ordering = ['id']

    def user_id(self, obj: UserProfile):
        return obj.user.id
