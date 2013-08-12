include:
  - devel.git
  - tony

/home/{{ pillar['username'] }}/study/node:
  file.directory:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['username'] }}

https://github.com/isaacs/npm.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/node/npm
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/node
      - pkg: git

{% for name, repo in pillar['study']['node']['git'].iteritems() %}
{{repo}}:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/node/{{name}}
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/node
      - pkg: git
{% endfor %}
