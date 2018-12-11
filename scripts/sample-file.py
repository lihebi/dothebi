#!/usr/bin/env python3

"""Sample files from folder.
"""

import os
import shutil
import random


def sample(src, num):
    """Sample NUM files from src directory, into the created dst
directory"""
    dst = os.path.join(os.path.dirname(src),
                       os.path.basename(src) + '-sample')
    if not os.path.exists(dst):
        os.makedirs(dst)
    total_num = len(os.listdir(src))
    prob = num / total_num
    selected_files = random.sample(os.listdir(src), num)
    for f in selected_files:
        from_file = os.path.join(src, f)
        to_file = os.path.join(dst, f)
        shutil.copytree(from_file, to_file)
        
if __name__ == '__test__':
    sample('/home/hebi/github/reading/cnn-dailymail/data/cnn/stories', 200)
    sample('/home/hebi/github/reading/cnn-dailymail/data/dailymail/stories', 200)
    sample('/home/hebi/github/reading/cnn-dailymail/cnn_stories_tokenized', 200)
    sample('/home/hebi/github/reading/cnn-dailymail/dm_stories_tokenized', 200)
    sample('/home/hebi/github/reading/cnn-dailymail/hebi', 100)
    sample('/home/hebi/github/reading/cnn-dailymail/hebi', 1000)
    sample('/home/hebi/github/reading/cnn-dailymail/hebi', 10000)
