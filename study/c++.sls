include:
  {% if pillar['vcs_pkg_sls'] is defined %}
  {% for vcs_pkg in pillar.get('vcs_pkg_sls', {}) %}
  - {{ vcs_pkg }}
  {% endfor %}
  {% endif %}
  {% if pillar['study_username'] is defined %}
  - {{ pillar['study_username'] }}
  {% endif %}

{{ pillar['study_dir'] }}c++:
  file.directory:
    - user: {{ pillar['study_username'] }}
    - group: {{ pillar['study_username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['study_username'] }}

git://git.musicpd.org/master/mpd.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c++/mpd
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c++
      - pkg: git

git://git.musicpd.org/master/libmpd.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c++/libmpd
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c++
      - pkg: git

git://git.musicpd.org/mirror/ncmpcpp.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c++/ncmpcpp
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c++
      - pkg: git

git://git.musicpd.org/master/libmpdclient.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c++/libmpdclient
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c++
      - pkg: git

https://github.com/joyent/node.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c++/node
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c++
      - pkg: git

https://github.com/zeromq/libzmq.git:
  git.latest:
    - target: {{ pillar['study_dir'] }}c++/libzmq
    - runas: {{ pillar['study_username'] }}
    - submodules: True
    - require:
      - file: {{ pillar['study_dir'] }}c++
      - pkg: git
