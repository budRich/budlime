# -*- encoding: utf-8 -*-
import os

def min_length(arr, length, fill=None):
    return arr + [fill] * (length - len(arr))

def walk_tree(path):

    for dirname, dirs, files in os.walk(path):
        for dir in ['.git', '.svn', 'node_modules']:
            if dir in dirs:
                dirs.remove(dir)

        yield dirname, dirs, files
