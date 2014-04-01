% === WFS point source ===================================================
% results for Y=-0.75m
files_ps(:,1) = { ...
    'VP01_wfs_Y-0.75m_ps_2013-02-20_14-05-12.csv'; ...
    'VP02_wfs_Y-0.75m_ps_2013-02-28_10-19-60.csv'; ...
    'VP03_wfs_Y-0.75m_ps_2013-02-26_14-01-25.csv'; ...
    'VP04_wfs_Y-0.75m_ps_2013-02-22_15-59-15.csv'; ...
    'VP05_wfs_Y-0.75m_ps_2013-02-22_10-03-55.csv'; ...
    'VP06_wfs_Y-0.75m_ps_2013-02-25_11-23-47.csv'; ...
    %'VP07_wfs_Y-0.75m_ps_2013-02-22_15-05-39.csv'; ... % did not complete experiment
    'VP08_wfs_Y-0.75m_ps_2013-02-27_12-27-41.csv'; ...
    'VP09_wfs_Y-0.75m_ps_2013-02-25_13-43-14.csv'; ...
    'VP10_wfs_Y-0.75m_ps_2013-03-01_10-23-05.csv'; ...
    'VP11_wfs_Y-0.75m_ps_2013-02-26_17-19-02.csv'; ...
    'VP12_wfs_Y-0.75m_ps_2013-03-01_11-38-58.csv'; ...
    'VP13_wfs_Y-0.75m_ps_2013-02-22_09-23-02.csv'; ...
    };
% results for Y=0.00m
files_ps(:,2) = { ...
    'VP01_wfs_Y0.00m_ps_2013-02-21_11-41-23.csv'; ...
    'VP02_wfs_Y0.00m_ps_2013-02-21_10-27-55.csv'; ...
    'VP03_wfs_Y0.00m_ps_2013-02-26_14-23-59.csv'; ...
    'VP04_wfs_Y0.00m_ps_2013-02-21_16-27-11.csv'; ...
    'VP05_wfs_Y0.00m_ps_2013-02-26_16-20-22.csv'; ...
    'VP06_wfs_Y0.00m_ps_2013-02-22_11-28-34.csv'; ...
    'VP08_wfs_Y0.00m_ps_2013-02-27_13-05-19.csv'; ...
    'VP09_wfs_Y0.00m_ps_2013-02-28_11-21-37.csv'; ...
    'VP10_wfs_Y0.00m_ps_2013-03-01_10-36-07.csv'; ...
    'VP11_wfs_Y0.00m_ps_2013-02-26_17-14-01.csv'; ...
    'VP12_wfs_Y0.00m_ps_2013-02-28_12-47-11.csv'; ...
    'VP13_wfs_Y0.00m_ps_2013-02-22_09-27-48.csv'; ...
    };
% results for Y=0.75m
files_ps(:,3) = { ...
    'VP01_wfs_Y0.75m_ps_2013-02-20_14-14-28.csv'; ...
    'VP02_wfs_Y0.75m_ps_2013-02-28_10-35-44.csv'; ...
    'VP03_wfs_Y0.75m_ps_2013-02-26_14-14-32.csv'; ...
    'VP04_wfs_Y0.75m_ps_2013-02-21_16-14-16.csv'; ...
    'VP05_wfs_Y0.75m_ps_2013-02-26_16-46-24.csv'; ...
    'VP06_wfs_Y0.75m_ps_2013-02-25_11-16-16.csv'; ...
    %'VP07_wfs_Y0.75m_ps_2013-02-22_14-50-21.csv'; ... % did not complete experiment
    'VP08_wfs_Y0.75m_ps_2013-02-25_13-07-15.csv'; ...
    'VP09_wfs_Y0.75m_ps_2013-02-28_11-06-32.csv'; ...
    'VP10_wfs_Y0.75m_ps_2013-02-26_15-30-16.csv'; ...
    'VP11_wfs_Y0.75m_ps_2013-02-26_17-09-31.csv'; ...
    'VP12_wfs_Y0.75m_ps_2013-02-28_13-12-54.csv'; ...
    'VP13_wfs_Y0.75m_ps_2013-02-25_09-23-50.csv'; ...
    };


% === WFS plane wave =====================================================
% results for Y=-0.75m
files_pw(:,1) = { ...
   'VP01_wfs_Y-0.75m_pw_2013-02-21_11-37-52.csv'; ...
   'VP02_wfs_Y-0.75m_pw_2013-02-21_10-22-25.csv'; ...
   'VP03_wfs_Y-0.75m_pw_2013-02-21_14-55-35.csv'; ...
   'VP04_wfs_Y-0.75m_pw_2013-02-21_16-23-26.csv'; ...
   'VP05_wfs_Y-0.75m_pw_2013-02-22_10-54-45.csv'; ...
   'VP06_wfs_Y-0.75m_pw_2013-02-22_11-20-29.csv'; ...
   'VP08_wfs_Y-0.75m_pw_2013-02-27_12-40-25.csv'; ...
   'VP09_wfs_Y-0.75m_pw_2013-02-27_13-16-04.csv'; ...
   'VP10_wfs_Y-0.75m_pw_2013-02-26_15-26-58.csv'; ...
   'VP11_wfs_Y-0.75m_pw_2013-02-26_17-29-33.csv'; ...
   'VP12_wfs_Y-0.75m_pw_2013-03-01_11-25-46.csv'; ...
   'VP13_wfs_Y-0.75m_pw_2013-02-25_09-12-34.csv'; ...
    };
% results for Y=0.00m
files_pw(:,2) = { ...
    'VP01_wfs_Y0.00m_pw_2013-02-21_11-15-17.csv'; ...
    'VP02_wfs_Y0.00m_pw_2013-02-28_10-39-54.csv'; ...
    'VP03_wfs_Y0.00m_pw_2013-02-21_15-18-57.csv'; ...
    'VP04_wfs_Y0.00m_pw_2013-02-22_16-20-52.csv'; ...
    'VP05_wfs_Y0.00m_pw_2013-02-26_16-14-24.csv'; ...
    'VP06_wfs_Y0.00m_pw_2013-02-22_12-07-30.csv'; ...
    'VP08_wfs_Y0.00m_pw_2013-02-27_13-09-19.csv'; ...
    'VP09_wfs_Y0.00m_pw_2013-02-28_11-28-03.csv'; ...
    'VP10_wfs_Y0.00m_pw_2013-03-01_10-32-33.csv'; ...
    'VP11_wfs_Y0.00m_pw_2013-02-27_14-19-03.csv'; ...
    'VP12_wfs_Y0.00m_pw_2013-02-28_12-37-55.csv'; ...
    'VP13_wfs_Y0.00m_pw_2013-02-25_09-18-07.csv'; ...
    };
% results for Y=0.75m
files_pw(:,3) = { ...
    'VP01_wfs_Y0.75m_pw_2013-02-20_13-51-50.csv'; ...
    'VP02_wfs_Y0.75m_pw_2013-02-28_10-13-55.csv'; ...
    'VP03_wfs_Y0.75m_pw_2013-02-26_13-48-16.csv'; ...
    'VP04_wfs_Y0.75m_pw_2013-02-22_15-56-16.csv'; ...
    'VP05_wfs_Y0.75m_pw_2013-02-22_10-44-32.csv'; ...
    'VP06_wfs_Y0.75m_pw_2013-02-22_11-42-05.csv'; ...
    %'VP07_wfs_Y0.75m_pw_2013-02-22_15-31-18.csv'; ... % did not complete experiment
    'VP08_wfs_Y0.75m_pw_2013-02-25_12-39-00.csv'; ...
    %'VP08_wfs_Y0.75m_pw_2013-02-27_12-49-09.csv'; ... % problem with first run
    'VP09_wfs_Y0.75m_pw_2013-02-27_13-33-26.csv'; ...
    'VP10_wfs_Y0.75m_pw_2013-03-01_10-15-40.csv'; ...
    'VP11_wfs_Y0.75m_pw_2013-02-26_17-25-57.csv'; ...
    'VP12_wfs_Y0.75m_pw_2013-03-01_12-01-31.csv'; ...
    'VP13_wfs_Y0.75m_pw_2013-02-25_09-55-56.csv'; ...
    };


% === WFS focused source =================================================
% results for Y=-0.75m
files_fs(:,1) = { ...
    'VP01_wfs_Y-0.75m_fs_2013-02-21_11-31-40.csv'; ...
    'VP02_wfs_Y-0.75m_fs_2013-02-21_10-40-56.csv'; ...
    'VP03_wfs_Y-0.75m_fs_2013-02-21_15-13-37.csv'; ...
    'VP04_wfs_Y-0.75m_fs_2013-02-22_16-09-41.csv'; ...
    'VP05_wfs_Y-0.75m_fs_2013-02-26_16-50-39.csv'; ...
    'VP06_wfs_Y-0.75m_fs_2013-02-22_11-59-36.csv'; ...
    'VP08_wfs_Y-0.75m_fs_2013-02-27_12-17-48.csv'; ...
    'VP09_wfs_Y-0.75m_fs_2013-02-25_14-19-05.csv'; ...
    'VP10_wfs_Y-0.75m_fs_2013-03-01_10-43-25.csv'; ...
    'VP11_wfs_Y-0.75m_fs_2013-02-27_14-13-37.csv'; ...
    'VP12_wfs_Y-0.75m_fs_2013-02-28_13-00-25.csv'; ...
    'VP13_wfs_Y-0.75m_fs_2013-02-25_09-51-08.csv'; ...
    };
% results for Y=0.00m
files_fs(:,2) = { ...
    'VP01_wfs_Y0.00m_fs_2013-02-21_11-26-23.csv'; ...
    'VP02_wfs_Y0.00m_fs_2013-02-28_10-49-24.csv'; ...
    'VP03_wfs_Y0.00m_fs_2013-02-21_14-47-16.csv'; ...
    'VP04_wfs_Y0.00m_fs_2013-02-21_16-41-51.csv'; ...
    'VP05_wfs_Y0.00m_fs_2013-02-26_16-41-08.csv'; ...
    'VP06_wfs_Y0.00m_fs_2013-02-25_11-54-60.csv'; ...
    %'VP07_wfs_Y0.00m_fs_2013-02-22_14-30-48.csv'; ... % did not complete experiment
    'VP08_wfs_Y0.00m_fs_2013-02-25_12-46-57.csv'; ...
    %'VP08_wfs_Y0.00m_fs_2013-02-27_12-44-16.csv'; ... % problem with first run
    'VP09_wfs_Y0.00m_fs_2013-02-27_13-24-40.csv'; ...
    'VP10_wfs_Y0.00m_fs_2013-02-26_15-21-45.csv'; ...
    'VP11_wfs_Y0.00m_fs_2013-02-27_14-32-58.csv'; ...
    'VP12_wfs_Y0.00m_fs_2013-03-01_12-06-16.csv'; ...
    'VP13_wfs_Y0.00m_fs_2013-02-22_09-00-43.csv'; ...
    };
% results for Y=0.75m
files_fs(:,3) = { ...
    'VP01_wfs_Y0.75m_fs_2013-02-21_11-19-10.csv'; ...
    'VP02_wfs_Y0.75m_fs_2013-02-28_10-24-57.csv'; ...
    'VP03_wfs_Y0.75m_fs_2013-02-26_14-19-25.csv'; ...
    'VP04_wfs_Y0.75m_fs_2013-02-21_16-18-36.csv'; ...
    'VP05_wfs_Y0.75m_fs_2013-02-26_16-36-52.csv'; ...
    'VP06_wfs_Y0.75m_fs_2013-02-25_12-03-06.csv'; ...
    'VP08_wfs_Y0.75m_fs_2013-02-25_12-57-35.csv'; ...
    'VP09_wfs_Y0.75m_fs_2013-02-28_11-34-45.csv'; ...
    'VP10_wfs_Y0.75m_fs_2013-02-26_15-37-13.csv'; ...
    'VP11_wfs_Y0.75m_fs_2013-02-27_14-38-35.csv'; ...
    'VP12_wfs_Y0.75m_fs_2013-02-28_13-06-30.csv'; ...
    'VP13_wfs_Y0.75m_fs_2013-02-22_08-53-51.csv'; ...
    };

