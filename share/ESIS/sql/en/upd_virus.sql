UPDATE virus.e_alert_level SET alert_name = 'Normal' WHERE e_alert_level_id = 1;
UPDATE virus.e_alert_level SET alert_name = 'High' WHERE e_alert_level_id = 2;
UPDATE virus.e_alert_level SET alert_name = 'Very high' WHERE e_alert_level_id = 3;
UPDATE virus.e_alert_level SET alert_name = 'Extreme' WHERE e_alert_level_id = 4;
UPDATE virus.t_virus_origin SET origin = 'File' WHERE t_virus_origin_id = 1;
UPDATE virus.t_virus_origin SET origin = 'Mail' WHERE t_virus_origin_id = 2;
UPDATE virus.t_virus_origin SET origin = 'Web' WHERE t_virus_origin_id = 3;
UPDATE virus.t_virus_origin_detail SET detail = 'Local device' WHERE t_virus_origin_detail_id = 1;
UPDATE virus.t_virus_origin_detail SET detail = 'Mobile device' WHERE t_virus_origin_detail_id = 2;
UPDATE virus.t_virus_origin_detail SET detail = 'Network device' WHERE t_virus_origin_detail_id = 3;
UPDATE virus.t_virus_origin_detail SET detail = 'Internal mail' WHERE t_virus_origin_detail_id = 4;
UPDATE virus.t_virus_origin_detail SET detail = 'Incoming mail' WHERE t_virus_origin_detail_id = 5;
UPDATE virus.t_virus_origin_detail SET detail = 'Outgoing mail' WHERE t_virus_origin_detail_id = 6;
UPDATE virus.t_virus_origin_detail SET detail = 'Web' WHERE t_virus_origin_detail_id = 7;