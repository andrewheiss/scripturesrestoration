#!/usr/bin/env python3

# Site development flag
DEVELOPING_SITE = True

DELETE_OUTPUT_DIRECTORY = True


# ------------------
# Site information
# ------------------
AUTHOR = 'Durham 2nd Ward'
SITENAME = 'The Scriptures of the Restoration'
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
# Theme
THEME = 'theme'

# Folder where everything lives
PATH = 'content'

PAGE_URL = '{slug}/'
PAGE_SAVE_AS = '{slug}/index.html'

STATIC_PATHS = ['.htaccess', 'robots.txt', 'files']
READERS = {'html': None}  # Don't parse HTML files

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# ------------
# Site items
# ------------
MENUITEMS = [('Book of Mormon', '/bom/'),
             ('Doctrine and Covenants', '/dc/'),
             ('Book of Mormon Highlights', '/bom-highlights/')]

DEFAULT_PAGINATION = False

PLUGIN_PATHS = ['plugins']
PLUGINS = ['pelican-bootstrapify']


# os.path.basename(os.path.dirname(y))

# ---------------
# Jinja filters
# ---------------
import jinja2
import os

# Remove <p>s surrounding Markdown output
def get_slug(url):
    slug = os.path.basename(os.path.dirname(url))
    return slug

JINJA_FILTERS = {'get_slug': get_slug}

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True
