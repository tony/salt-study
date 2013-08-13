{{ pillar['study_dir'] }}:
  file.directory:
    - user: {{ pillar['study_username'] }}
    - group: {{ pillar['study_username'] }}
    - mode: 775
    - makedirs: True
    - require:
      - user: {{ pillar['study_username'] }}
