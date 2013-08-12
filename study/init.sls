/home/{{ pillar['username'] }}/study/:
  file.directory:
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['username'] }}
