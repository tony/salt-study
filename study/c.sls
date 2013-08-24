include:
  {% if pillar['vcs_pkg_sls'] is defined %}
  {% for vcs_pkg in pillar.get('vcs_pkg_sls', {}) %}
  - {{ vcs_pkg }}
  {% endfor %}
  {% endif %}
  {% if pillar['study_username'] is defined %}
  - {{ pillar['study_username'] }}
  {% endif %}


{{ pillar['study_dir'] }}c:
  file.directory:
    - user: {{ pillar['study_username'] }}
    - group: {{ pillar['study_username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['study_username'] }}


{% for vcs in pillar['study_repos']['c'].keys() %}
{% for name, repo in pillar['study_repos']['c'][vcs].iteritems() %}

c_study_{{ name }}:
  {{vcs}}.latest:
    - name: {{repo}}
    - target: {{ pillar['study_dir'] }}c/{{name}}
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c
      - pkg: {{vcs}}
{% endfor %}
{% endfor %}
