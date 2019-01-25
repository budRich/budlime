# -*- encoding: utf-8 -*-

import xml.etree.ElementTree as ET
from textwrap import dedent
import sublime
import os
import re

SANE_EXTENSION = '.sane-snippet'

class Snippet:

    templates = {
        'xml': dedent("""\
                        <snippet>
                            <content><![CDATA[{content}]]></content>
                            <tabTrigger>{tabTrigger}</tabTrigger>
                            <scope>{scope}</scope>
                            <description>{description}</description>
                        </snippet>
                        """),
        'sane': dedent("""\
                        ---
                        description: {description}
                        tabTrigger:  {tabTrigger}
                        scope:       {scope}
                        ---
                        {content}
                        """)
    }

    re_sane = re.compile(r'---\n(?P<header>.*?)\n---\n(?P<content>.*)', re.DOTALL)
    re_sane_header_line = re.compile(r'^(?:(?P<comment>#.*)|(?P<key>[a-zA-Z]+): *(?P<value>.*))$')

    def __init__(self, file_name):
        self.file_name = file_name
        self.format = self.get_format()

    def get_format(self):
        if self.file_name.endswith('.sane-snippet'):
            return 'sane'
        elif self.file_name.endswith('.sublime-snippet'):
            return 'xml'
        else:
            raise ValueError('Unknown file format')

    def parse(self):
        cls = self.__class__
        if self.format == 'xml':
            root = ET.parse(self.file_name).getroot()
            content = getattr(root.find('content'), 'text', '')
            if content.startswith('\n'):
                content = content[1:]
            if content.endswith('\n'):
                content = content[:-1]
            return {
                'content': content,
                'tabTrigger': getattr(root.find('tabTrigger'), 'text', ''),
                'scope': getattr(root.find('scope'), 'text', ''),
                'description': getattr(root.find('description'), 'text', ''),
            }
        elif self.format == 'sane':
            with open(self.file_name, 'r', encoding='utf-8') as fp:
                matchobj = cls.re_sane.match(fp.read())
            header, content = matchobj.group('header'), matchobj.group('content')
            if content.endswith('\n'):
                content = content[:-1]

            infos = {}
            for line in header.splitlines():
                matchobj = cls.re_sane_header_line.match(line)
                if not matchobj or matchobj.group('comment'):
                    continue
                infos[matchobj.group('key')] = matchobj.group('value')

            return {
                'content': content,
                'tabTrigger': infos.get('tabTrigger', ''),
                'scope': infos.get('scope', ''),
                'description': infos.get('description', ''),
            }


    def convert(self, force=False):
        if self.format == 'xml':
            snippet_string = self.__class__.templates['sane'].format(**self.parse())
        elif self.format == 'sane':
            snippet_string = self.__class__.templates['xml'].format(**self.parse())

        dst = self.get_dst()

        if os.path.exists(dst) and not force:
            with open(dst, encoding='utf-8') as fp:
                if fp.read() == snippet_string:
                    return
            raise FileExistsError("The file '{}' already exists "
                                  "(and the content differs)".format(dst))

        with open(dst, 'w', encoding='utf-8') as fp:
            fp.write(snippet_string)

    def get_dst(self):
        extension = '.sublime-snippet' if self.format == 'sane' else '.sane-snippet'
        return os.path.normpath(
                os.path.join(os.path.dirname(self.file_name),
                             os.path.splitext(os.path.basename(self.file_name))[0] + extension))

    def __str__(self):
        return "<Snippet '{}' at '{}'>".format(self.format, self.file_name)

    def __repr__(self):
        return str(self)
