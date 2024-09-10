import pandas as pd
from django.contrib import messages
from django.http import HttpRequest
from surprise import SVD, KNNBasic
from surprise import Dataset, Reader, Prediction

import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project.settings")
django.setup()

from django.contrib.auth.models import User
from music.models import UserProfile, Music
r'''
SVD，即奇异值分解（Singular Value Decomposition），是线性代数中一种重要的矩阵分解方法。它将一个复数或实数矩阵分解为三个特定的矩阵的乘积，形式如下：

A = U \Sigma V^T

其中：
-  A  是需要分解的原始矩阵。
-  U  是一个正交矩阵，其列被称为左奇异向量。
-  \Sigma  是一个对角矩阵，对角线上的非负实数称为奇异值，并且按降序排列。
- V  是另一个正交矩阵，其列被称为右奇异向量。
-  V^T  表示  V  的转置。

### 应用场景：
1. **数据降维**：通过保留前几个最大的奇异值和对应的奇异向量，可以近似原始矩阵，从而实现数据的降维。
2. **图像压缩**：在图像处理中，SVD可以用来去除图像中的噪声，实现图像压缩。
3. **推荐系统**：在协同过滤推荐系统中，SVD可以用于发现用户和物品之间的潜在因子，从而提供个性化推荐。
4. **文本挖掘**：在自然语言处理中，SVD可以用于文本数据的矩阵分解，帮助识别文档和词汇之间的潜在关系。
5. **信号处理**：在信号处理领域，SVD可以用于噪声过滤和信号恢复。

SVD是一种强大的工具，广泛应用于数据科学、机器学习和信号处理等领域。

'''

# 获取数据库中的所有用户数据
def build_df():
    data = []
    for user_profile in UserProfile.objects.all():  # 获取所有用户信息
        for like_music in user_profile.likes.all():  # 循环获取所有用户喜欢的歌曲
            data.append([user_profile.user.id, like_music.pk, 1])  # 保存数据data[[1,1,1]]
        for dislike_music in user_profile.dislikes.all():  # 循环获取所有用户不喜欢的歌曲
            data.append([user_profile.user.id, dislike_music.pk, 0])  # 保存数据为data[[1,2,0]]

    return pd.DataFrame(data, columns=['userID', 'itemID', 'rating'])  # 存储格式


'''
userID itemId rating
2      1      1
2      4      0
2      3      1
将歌曲的喜欢和不喜欢用数字的方法传递给机器处理
'''


# 根据用户评分数据来构建预测模型，并返回一组推荐的音乐列表
def build_predictions(df: pd.DataFrame, user: User):
    userId = user.id
    profile = UserProfile.objects.filter(user=user)  # 查找用户的个人资料信息
    if profile.exists():
        profile_obj: UserProfile = profile.first()
    else:
        return []
    # 预处理 使用Surprise库中的Reader和Dataset来构建评分数据集
    # 指定评分范围在0到1之间的连续值
    reader = Reader(rating_scale=(0, 1))
    # 将数据集加载到评分数据集中
    data = Dataset.load_from_df(df[['userID', 'itemID', 'rating']], reader)
    # 使用评分数据集构建训练集
    train_set = data.build_full_trainset()
    # 生成模型,创建一个SVD对象
    algo = SVD()
    # 通过alog.fit(train_set)方法训练算法，将数据集拟合到算法中
    algo.fit(train_set)
    # 生成推荐 取出当前所有人有评分过的歌曲，并去重
    subsets = df[['itemID']].drop_duplicates()

    # 定义一个测试集
    test_set = []
    # 从评分中提取出所有被评分过的音乐，并将其作为测试集
    for row in subsets.iterrows():
        # 测试集中的评分被设置为零，因为我们只是想预测用户是否会喜欢这些音乐，不关心具体的评分值
        test_set.append([userId, row[1].values[0], 0])
    # 用训练好的算法对测试集进行预测，返回包含预测结果的列表
    predictions = algo.test(test_set, verbose=True)
    '''
    预测结果：用户id为4的用户对物品id为1的物品评分预测为0.883423521
    '''
    result_set = []

    user_like = profile_obj.likes.all()  # 当前用户喜欢的
    user_dislike = profile_obj.dislikes.all()  # 当前用户不喜欢的
    # 遍历所有预测结果
    for item in predictions:
        prediction: Prediction = item
        # 对于预测评分高于0.99的音乐，它从数据库中获取相应的音乐对象
        if prediction.est > 0.99:
            music = Music.objects.get(pk=prediction.iid)
            # 检查用户是否喜欢该音乐或者不喜欢该音乐，如果有就跳过
            if music in user_like:
                continue
            if music in user_dislike:
                continue
            result_set.append((music, prediction.est))
    # 如果数量太少就让用户多增加一些数据
    if len(result_set) == 0:
        messages.error(current_request, '你听的歌太少了，多听点歌再来吧~')

    return result_set


def build_random_recommendations(user: User, num_recommendations: int = 20):
    user_profile = UserProfile.objects.get(user=user)
    user_like = user_profile.likes.all()
    user_dislike = user_profile.dislikes.all()

    all_music = Music.objects.exclude(pk__in=[music.pk for music in user_like]).exclude(
        pk__in=[music.pk for music in user_dislike])
    random_recommendations = all_music.order_by('?')[:num_recommendations]

    return list(random_recommendations)


# 获取用户流派进行推荐
def build_genre_predictions(user: User):
    predictions = []  # 定义一个空列表进行存储
    profile = UserProfile.objects.filter(user=user)  # 用户信息
    if profile.exists():
        profile_obj: UserProfile = profile.first()
    else:
        return predictions

    genre_subscribe = profile_obj.genre_subscribe.split(',')  # 获取用户订阅的流派
    user_like = profile_obj.likes.all()  #
    user_dislike = profile_obj.dislikes.all()

    # 遍历查找用户喜欢的流派的所有音乐
    for music in Music.objects.filter(genre_ids__in=genre_subscribe):
        # 如果有喜欢的和不喜欢的就直接跳过
        if music in user_like:
            continue
        if music in user_dislike:
            continue
        predictions.append((music, None))  # 将不在喜欢不和不喜欢中挑选并添加到列表中返回

    return predictions


# 获取用户喜欢语种的数据进行推荐，同上
def build_language_predictions(user: User):
    predictions = []
    profile = UserProfile.objects.filter(user=user)
    if profile.exists():
        profile_obj: UserProfile = profile.first()
    else:
        return predictions

    language_subscribe = profile_obj.language_subscribe.split(',')
    user_like = profile_obj.likes.all()
    user_dislike = profile_obj.dislikes.all()

    for music in Music.objects.filter(language__in=language_subscribe):
        if music in user_like:
            continue
        if music in user_dislike:
            continue
        predictions.append((music, None))

    return predictions


def build_recommend(request: HttpRequest, user: User):
    global current_request
    current_request = request
    predictions = []  # 定义一个列表储存
    predictions.extend(build_predictions(build_df(), user))  # 算法预测
    predictions.extend(build_genre_predictions(user))  # 流派推荐
    predictions.extend(build_language_predictions(user))  # 语言推荐

    if len(predictions) == 0:
        predictions.extend(build_random_recommendations(user))  # 数据过少进行一个随机推荐
    return predictions[:20]


if __name__ == '__main__':
    # print(build_df())
    # print(build_predictions(build_df(), User.objects.get(pk=4)))
    # print(build_genre_predictions(User.objects.get(pk=2)))
    # print(build_language_predictions(User.objects.get(pk=2)))
    print(build_recommend(User.objects.get(pk=1)))
