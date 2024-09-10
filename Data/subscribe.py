import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project.settings")
django.setup()

from music.models import UserProfile, Music

language_labels = {
    '3.0': '华语',
    '31.0': '韩语',
    '52.0': '英语',
    '17.0': '日语',
    '10.0': '台语',
    '38.0': '台语',
    '-1.0': '纯音乐',
    '59.0': '纯音乐',
    '24.0': '粤语',
    '45.0': '粤语'
}

genre_labels = {"465": "朋克", "444": "蓝调", "458": "拉丁", "726": "蓝调", "864": "后摇", "857": "后摇", "850": "世界音乐", "843": "后摇", "1572": "古风", "275": "民族", "2122": "雷鬼", "359": "世界音乐", "338": "乡村", "303": "乡村", "1131": "乡村",
                "1089": "乡村", "1266": "乡村", "670": "乡村", "252": "乡村", "2238": "乡村", "1944": "乡村", "2029": "乡村", "1033": "乡村", "979": "乡村", "": "古风", "352": "英伦", "1169": "R&B/Soul", "282": "R&B/Soul", "416": "R&B/Soul",
                "2065": "R&B/Soul", "2245": "R&B/Soul", "656": "R&B/Soul", "1201": "R&B/Soul", "1007": "R&B/Soul", "2045": "R&B/Soul", "289": "R&B/Soul", "1995": "民族", "765": "古典", "2052": "古典", "2194": "古典",
                "2183": "古典", "2206": "古典", "502": "古典", "1988": "古典", "993": "古典", "986": "古典", "1110": "古典", "1047": "古典", "2157": "后摇", "95": "民族", "1054": "民族", "2248": "民族", "1162": "民族", "965": "民族", "198": "民族",
                "531": "民族", "2116": "民族", "751": "民族", "488": "民族", "808": "民族", "2032": "英伦", "1273": "英伦", "1145": "英伦", "212": "英伦", "972": "英伦", "2213": "英伦", "1026": "英伦", "177": "英伦", "2215": "英伦", "205": "英伦",
                "2144": "英伦", "1609": "朋克", "663": "金属", "1208": "金属", "2100": "金属", "1103": "金属", "381": "金属", "331": "金属", "1096": "金属", "509": "金属", "1040": "金属", "1981": "金属", "1011": "后摇", "698": "金属", "242": "拉丁",
                "139": "朋克", "873": "朋克", "1955": "朋克", "2022": "朋克", "786": "朋克", "947": "朋克", "1259": "朋克", "921": "朋克", "2107": "朋克", "451": "古风", "880": "蓝调", "481": "蓝调", "125": "蓝调", "109": "蓝调", "798": "蓝调",
                "1082": "蓝调", "545": "蓝调", "437": "蓝调", "829": "蓝调", "1969": "蓝调", "388": "蓝调", "94": "蓝调", "1152": "拉丁", "430": "古风", "409": "雷鬼", "893": "雷鬼", "1616": "雷鬼", "712": "雷鬼", "958": "拉丁", "940": "世界音乐",
                "2130": "雷鬼", "2086": "雷鬼", "1568": "雷鬼", "1138": "雷鬼", "474": "世界音乐", "1180": "世界音乐", "1068": "世界音乐", "423": "世界音乐", "184": "世界音乐", "744": "世界音乐", "691": "世界音乐", "2189": "世界音乐", "2072": "世界音乐",
                "1977": "世界音乐", "402": "拉丁", "1287": "拉丁", "2079": "拉丁", "2176": "拉丁", "1605": "拉丁", "1019": "拉丁", "719": "拉丁", "367": "拉丁", "374": "拉丁", "822": "古风", "2058": "古风", "1155": "古风", "1633": "古风",
                "310": "古风", "900": "古风", "2109": "古风", "1280": "古风", "2093": "古风", "1630": "古风", "118": "后摇", "516": "后摇", "907": "后摇", "102": "后摇", "1598": "后摇", "191": "后摇", "1124": "R&B/Soul"}


# 构建音乐流派id字典
def build_genre_ids():
    data = {}
    genre_ids = Music.objects.values_list('genre_ids')
    # 有些歌曲存在多种流派，需要分隔开
    for genre_id in genre_ids:
        if '|' not in genre_id[0]:
            genre = genre_id[0]
            data[genre] = True
        else:
            for genre in genre_id[0].split('|'):
                data[genre] = True
    # 去除空值
    if '' in data:
        del data['']
    print(data.keys())
    return list(data.keys())


def build_languages():
    data = {}
    languages = Music.objects.values_list('language')

    for language in languages:
        if '|' not in language[0]:
            lang = language[0].strip()
            data[lang] = True
        else:
            for lang in language[0].split('|'):
                lang = lang.strip()
                data[lang] = True

    if '' in data:
        del data['']
    return list(data.keys())


if __name__ == '__main__':
    print(build_genre_ids())

    print(build_languages())
