saltstack source code library
=============================

Study the latest source code of open source projects.

If this is causing you an error or you have a feature request file an issue.

`Start learning Salt today <http://docs.saltstack.com/topics/installation/index.html>`_!

Features
--------

* Clone / checkout open source projects en masse, seperated by programming language
* Update all projects at once
* VCS support: git, hg (should work with svn, cvs too). Have a pkg dependency
  you need to include? add it via the pillar file (for python only as of
  2013-08-13)
* Python only: automatically creates virtualenvwrapper compatible environments
  for code. So you can `workon` the same code you are studying.

Setup
-----

.. code:: bash

   git clone https://github.com/tony/salt-study.git /srv/salt/tony-study


Edit master file `/etc/salt/master` and / or `/etc/salt/minion` file:

.. code:: yaml

    pillar_roots:
        base:
            - .. your current pillars
            - /srv/salt/tony-study/pillar

    file_roots:
        base:
            - .. your current file_roots
            - /srv/salt/tony-study

Add `study_repos` to your highest pillar `top.sls` file.

Copy ``pillar/study_repos.sls.example`` to ``pillar/study_repos.sls``.

Config variables
````````````````

================== =============
Variable           Use
================== =============
**study_username** User and Group for file ownership
------------------ -------------
**study_dir**      The directory with the study repos will be cloned to. I use `/home/tony/study/`. Remember trailing slash.
------------------ -------------
**vcs_pkg_sls**    List of vcs sls packages to include as dependencies
------------------ -------------
**python_sls**     Name of python sls package to include if you have dependencies for python / virtualenv / virtualenvwrapper.
------------------ -------------
**study repos**    Categorized by subject -> vcs -> { projectname: 'repo url' }
================== =============


To do
-----

- Convert the rest of the sample subjects to the pillar data format (`c.sls`
  and `c++.sls` isn't yet.
- Allow the other pillars to have package dependencies from pillar config,
  `study_sls_pkg` for all study sls subjects.
