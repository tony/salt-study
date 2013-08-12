include:
  - devel.git
  - devel.mercurial
  - lang.python.python-libs
  - tony

/home/{{ pillar['username'] }}/study/python:
  file.directory:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['username'] }}


{% for vcs in pillar['study']['python'].keys() %}
{% for name, repo in pillar['study']['python'][vcs].iteritems() %}

python_study_{{ name }}:
  {{vcs}}.latest:
    - name: {{repo}}
    - target: /home/{{ pillar['username'] }}/study/python/{{name}}
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/python
      - pkg: {{vcs}}
      - pkg: python2
  virtualenv.managed:
    - name: /home/{{ pillar['username'] }}/.virtualenvs/{{ name }}
    - no_site_packages: True
    - system_site_packages: True
    - runas: {{ pillar['username'] }}
    #- requirements: salt://salt/dev/requirements.txt
    - template: jinja
    - require:
      - {{vcs}}.latest: python_study_{{name}}
      - pip: virtualenvwrapper
      - pip: virtualenv
  pip.installed:
    - name: /home/{{ pillar['username'] }}/study/python/{{name}}
    - editable: file:///home/{{ pillar['username'] }}/study/python/{{name}}
    # temporarily, https://github.com/saltstack/salt/issues/3751
    #- editable: True # equivalent to python -e
    - user: {{ pillar['username'] }}
    - bin_env: /home/{{ pillar['username'] }}/.virtualenvs/{{name}}/bin/pip
    - require:
      - virtualenv.managed: python_study_{{ name }}

{% endfor %}
{% endfor %}
