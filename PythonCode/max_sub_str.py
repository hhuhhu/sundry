#!/usr/bin/env python
# encoding: utf-8
"""
@author: Daniel
@contact: 511735184@qq.com
@file: max_sub_str.py
@time: 2017/7/20 22:38
"""


def find_lcsubstr(s1, s2):
    """
    求最长公共字串长度
    :param s1: 序列1，为一字符串
    :param s2: 序列2，为一字符串
    :return: 最长子串长度
    """
    assert type(s1) is str, "s1需要是字符串类型"
    assert type(s2) is str, "s1需要是字符串类型"
    m = [[0 for i in range(len(s2) + 1)] for j in range(len(s1) + 1)]  # 生成0矩阵，为方便后续计算，比字符串长度多了一列
    mmax = 0  # 最长匹配的长度
    p = 0  # 最长匹配对应在s1中的最后一位
    p_mmax = {} # 字典，用于存放最长子串的末位及其长度
    # 主程，求最长子串末位及其长度
    for i in range(len(s1)):
        for j in range(len(s2)):
            if s1[i] == s2[j]:
                m[i + 1][j + 1] = m[i][j] + 1
                if m[i + 1][j + 1] >= mmax:
                    mmax = m[i + 1][j + 1]
                    p = i + 1
                    p_mmax.update({p: mmax})
    # 获得所有最长子串
    # max_length = max(p_mmax.values())
    # max_sub_str = [k for k, v in p_mmax.items() if v == max_length]
    # max_sub_str = [tuple(s1[end - max_length:end]) for end in max_sub_str]
    return mmax  # 返回最长子串长度

if __name__ == '__main__':
    s1 = 'abcmdfghhhaaakbbbbbb'
    s2 = 'abcdfghhhhaaanbbbbbb'
    print("序列最长子串长度是：{}".format(find_lcsubstr(s1, s2)))
