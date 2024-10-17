# MusicRecommend
基于用户画像以及协同过滤的音乐推荐系统
根据 https://github.com/zhuxiangyualter/MusicRecommend 的项目进行修改


1.将基于用户的协同过滤算法与用户画像相结合进行推荐，提高推荐列表数据的成熟度。

2.系统在Windows平台上搭建，采用Python3实现各项功能；采取MySQL进行数据的存储，通过Django框架连接系统的前、后端。


3.自己网易云歌单里面的音乐数据


4.针对数据集使用SVD矩阵分解进行相似相关度的计算分析，根据已有的评分情况，
分析出评分者对各个因子的喜好程度以及歌曲包含各个因子的程度，最后再反过来根据分析结果预测评分，根据评分的结果生成推荐列表。
## Deploy
### Requirements
因数据集过大，不便放进项目文件夹中，故请将打包处理好后的sql文件直接导入到数据库,运行时请先修改settings.py中的数据库配置信息。


Create a virtual environment and install dependencies:
```sh
$ pip install -r requirements.txt
```

Migrate database:

```sh
$ py manage.py migrate
```

Run server:

```sh
$ py manage.py runserver
```

Visit http://localhost:8000
### Note
超级管理员用户

自行设置

音乐数据来自于网易云，用户数据请使用者运行后自行添加。

## Contributor
<div>
<a href="https://github.com/zgXhei">
<img src="https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.nga.178.com%2Fattachments%2Fmon_202407%2F07%2F-9lddQ19k-b89wXkZ5hT3cS2i9-3h0.jpg&refer=http%3A%2F%2Fimg.nga.178.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1728544632&t=f50bf1b62b55ca9e59ac151b898770ad" height=50px; width=50px;>
</a>
</div>


