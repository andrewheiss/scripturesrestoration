# Scriptures of the Restoration

The Durham 2nd ward's 2017 goal is to have every member read one of the scriptures of the restoration during the year—either the [Book of Mormon](https://www.lds.org/scriptures/bofm) or the [Doctrine and Covenants](https://www.lds.org/scriptures/dc-testament).

This repository contains code for generating the [goal's website](http://scripturesoftherestoration.org) with [Pelican](http://docs.getpelican.com/en/stable/). It also includes code for generating the weekly reading lists with [R](https://www.r-project.org/). 

## How to run

It's best to install Pelican and its dependencies in a Python virtual environment. Here's how:

1. In a terminal, navigate to this directory: `cd path/to/wherever/this/is`
2. Create a new Python 3 virtual environment: `virtualenv -p python3 pelican`
3. Activate the virtual environment: `source pelican/bin/activate`
4. Install Pelican and dependencies: `pip3 install -r requirements.txt`
5. Deactivate the environment when you're all done: `deactivate`

When you want to regenerate the site, activate the virtual environment and use `make` (see the Makefile for a list of commands, or run `make help`). Here's my typical workflow:

1. Activate the virtual environment: `source pelican/bin/activate`
2. Run a local development server at http://localhost:8000: `make devserver`
3. Edit files, make changes, check the changes, etc.
4. Stop the development server: `make stopserver`
5. Generate the production version of the site: `make publish`
6. Or, generate the production version of the site and upload it to the remote server with `rsync` at the same time: `make rsync_upload`
7. Deactivate the environment when you're all done: `deactivate`
