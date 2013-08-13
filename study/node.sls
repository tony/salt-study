include:
  {% if pillar['vcs_pkg_sls'] is defined %}
  {% for vcs_pkg in pillar.get('vcs_pkg_sls', {}) %}
  - {{ vcs_pkg }}
  {% endfor %}
  {% endif %}
  {% if pillar['study_username'] is defined %}
  - {{ pillar['study_username'] }}
  {% endif %}


{{ pillar['study_dir'] }}node:
  file.directory:
    - user: {{ pillar['study_username'] }}
    - group: {{ pillar['study_username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['study_username'] }}

https://github.com/isaacs/npm.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}node/npm
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}node
      - pkg: git

{% for name, repo in pillar['study_repos']['node']['git'].iteritems() %}
{{repo}}:
  git.latest:
    - target: {{ pillar['study_dir'] }}node/{{name}}
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}node
      - pkg: git
{% endfor %}
