include:
  {% if pillar['vcs_pkg_sls'] is defined %}
  {% for vcs_pkg in pillar.get('vcs_pkg_sls', {}) %}
  - {{ vcs_pkg }}
  {% endfor %}
  {% endif %}
  {% if pillar['study_username'] is defined %}
  - {{ pillar['study_username'] }}
  {% endif %}
  {% if pillar['python_sls'] is defined %}
  - {{ pillar['python_sls'] }}
  {% endif %}


{{ pillar['study_dir'] }}python:
  file.directory:
    - user: {{ pillar['study_username'] }}
    - group: {{ pillar['study_username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['study_username'] }}


{% for vcs in pillar['study_repos']['python'].keys() %}
{% for name, repo in pillar['study_repos']['python'][vcs].iteritems() %}

python_study_{{ name }}:
  {{vcs}}.latest:
    - name: {{repo}}
    - target: {{ pillar['study_dir'] }}python/{{name}}
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}python
      - pkg: {{vcs}}
      - pkg: python2
  virtualenv.managed:
    - name: /home/{{ pillar['study_username'] }}/.virtualenvs/{{ name }}
    - no_site_packages: True
    - system_site_packages: True
    - runas: {{ pillar['study_username'] }}
    #- requirements: salt://salt/dev/requirements.txt
    - template: jinja
    - require:
      - {{vcs}}.latest: python_study_{{name}}
      - pip: virtualenvwrapper
      - pip: virtualenv
  pip.installed:
    - name: {{ pillar['study_dir'] }}python/{{name}}
    - editable: file://{{ pillar['study_dir'] }}python/{{name}}
    # temporarily, https://github.com/saltstack/salt/issues/3751
    #- editable: True # equivalent to python -e
    - user: {{ pillar['study_username'] }}
    - bin_env: /home/{{ pillar['study_username'] }}/.virtualenvs/{{name}}/bin/pip
    - require:
      - virtualenv.managed: python_study_{{ name }}

{% endfor %}
{% endfor %}
