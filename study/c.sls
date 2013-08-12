include:
  - devel.git
  - tony

/home/{{ pillar['username'] }}/study/c:
  file.directory:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['username'] }}

git://git.musicpd.org/master/ncmpc.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c/ncmpc
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c
      - pkg: git


git://git.code.sf.net/p/tmux/tmux-code:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c/tmux
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c
      - pkg: git

https://github.com/git/git.git:
  git.latest:
    - target: /home/{{ pillar['username'] }}/study/c/git
    - runas: tony
    - submodules: True
    - require:
      - file: /home/{{ pillar['username'] }}/study/c
      - pkg: git
