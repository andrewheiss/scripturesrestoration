#!/usr/bin/env python3

# ------------------
# Site information
# ------------------
AUTHOR = 'Durham 2nd Ward'
SITENAME = 'Scriptures of the Restoration'
DESCRIPTION = ''
SITEURL = ''

PATH = 'content'

TIMEZONE = 'America/New_York'
DEFAULT_DATE_FORMAT = '%Y-%m-%d'
DEFAULT_LANG = 'en'

TYPOGRIFY = True  # Nice typographic things
TYPOGRIFY_IGNORE_TAGS = ['h1']

GOOGLE_ANALYTICS = ''


# ---------------
# Site building
# ---------------
DELETE_OUTPUT_DIRECTORY = True

# Theme
THEME = 'theme'

# Folder where everything lives
PATH = 'content'

PAGE_URL = '{slug}/'
PAGE_SAVE_AS = '{slug}/index.html'

STATIC_PATHS = ['.htaccess', 'robots.txt', 'files']
READERS = {'html': None}  # Don't parse HTML files

# No feeds
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# None of these pages
AUTHOR_SAVE_AS = ''
AUTHORS_SAVE_AS = ''
ARCHIVES_SAVE_AS = ''
TAGS_SAVE_AS = ''
CATEGORIES_SAVE_AS = ''


# ------------
# Site items
# ------------
MENUITEMS = [('Doctrine and Covenants', '/dc/'),
             ('Book of Mormon', '/bom/'),
             ('Book of Mormon Highlights', '/bom-highlights/'),
             ('Resources', '/resources/')]

DEFAULT_PAGINATION = False

PLUGIN_PATHS = ['plugins']
PLUGINS = ['pelican-bootstrapify']

MARKDOWN = {
    'extension_configs': {
        'markdown.extensions.smarty': {},
        'markdown.extensions.extra': {},
        'markdown.extensions.toc': {},
        'markdown.extensions.meta': {}
    },
    'output_format': 'html5',
}

STATIC_PATHS = ['files', 'favicon.ico', 'config.php', 'p.php']


# ---------------
# Jinja filters
# ---------------
import jinja2
import os

# Get the final basename or directory name of a path
def get_slug(url):
    slug = os.path.basename(os.path.dirname(url))
    return slug

JINJA_FILTERS = {'get_slug': get_slug}
