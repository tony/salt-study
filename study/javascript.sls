include:
  - devel.git
  - devel.mercurial
  - tony


/home/{{ pillar['username'] }}/study/javascript:
  file.directory:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['username'] }}

{% for name, repo in pillar['study']['javascript']['git'].iteritems() %}
{{repo}}:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/javascript/{{name}}
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/javascript
      - pkg: git
{% endfor %}
