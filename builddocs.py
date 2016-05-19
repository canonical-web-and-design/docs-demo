#!/usr/bin/env python

import os
import sys

project_name = sys.argv[1]
directory = os.path.abspath('./pages/' + project_name)
prefix_template = '---\nlayout: ' + project_name + '-default\ntitle: {title}\npermalink: {permalink}\n---\n'

def get_title_and_content(content, filename):
     title = ''
     new_content = []
     for line in content.splitlines():
          if line.startswith('Title: '):
               title = line[len('Title: '):]
               continue
          new_content.append(line)

     if not title:
          title = filename.capitalize();
          title = title.replace('-', ' ').replace('.md', '')

     if title == "Index":
          title = project_name + ' documentation'

     return title, '\n'.join(new_content)

def get_permalink(filename):
    if filename == 'index.md':
        return '/' + project_name + '/'
    filename = filename.replace('.md', '')
    return '/' + project_name + '/' + filename + '/'

def main():
     for fn in os.listdir('./pages/' + project_name):
          path = os.path.join(directory, fn)
          if not os.path.isfile(path):
               continue
          with open(path, 'r+') as f:
               content = f.read()
               f.seek(0)
               title, content = get_title_and_content(content, fn)
               content = content.replace('./media', '/docs-demo/media/' + project_name)
               prefix = prefix_template.format(title=title, permalink=get_permalink(fn))
               if content.startswith(prefix):
                    continue
               f.write(prefix + content)

if __name__ == '__main__':
    main()
