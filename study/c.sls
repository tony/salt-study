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

git://git.musicpd.org/master/ncmpc.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c/ncmpc
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c
      - pkg: git


git://git.code.sf.net/p/tmux/tmux-code:
  git.latest:
    - target: {{ pillar['study_dir'] }}c/tmux
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c
      - pkg: git

https://github.com/git/git.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c/git
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c
      - pkg: git
