include:
  - devel.git
  - tony

/home/{{ pillar['username'] }}/study/c++:
  file.directory:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['username'] }}

git://git.musicpd.org/master/mpd.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c++/mpd
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c++
      - pkg: git

git://git.musicpd.org/master/libmpd.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c++/libmpd
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c++
      - pkg: git

git://git.musicpd.org/mirror/ncmpcpp.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c++/ncmpcpp
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c++
      - pkg: git

git://git.musicpd.org/master/libmpdclient.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c++/libmpdclient
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c++
      - pkg: git

https://github.com/joyent/node.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c++/node
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c++
      - pkg: git

https://github.com/zeromq/libzmq.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c++/libzmq
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c++
      - pkg: git
