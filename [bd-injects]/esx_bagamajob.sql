﻿SET @job_name = 'bagama';
SET @society_name = 'society_bagama';
SET @job_Name_Caps = 'Bagama';

INSERT INTO addon_account (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO addon_inventory (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_bagama_fridge', 'Багама (холодильник)', 1)
;

INSERT INTO datastore (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO jobs (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Бармен', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Танцовщица', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Компаньон', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Босс', 600, '{}', '{}')
;