 stateNames = state_labels_filename(ind_1);
 inputNames = input_labels_latex([3,4]);
systemsTable=table() ;
systemsTable.lineSpec = {'b-'; 'r--'};
systemsTable.sys = {sys_FL_long; sys_SP};
systemsTable.modeName = {'Linear Full Model'; 'Short Period Approx'};
index=[2,3];



export_system_comparison(systemsTable, stateNames, inputNames, index);

 stateNames = state_labels_filename(ind_2);
 inputNames = input_labels_latex([3,4]);
systemsTable=table() ;
systemsTable.lineSpec = {'b-'; 'r--'};
systemsTable.sys = {sys_FL_long; sys_LP};
systemsTable.modeName = {'Linear Full Model'; 'Long Period Approx'};
index=[1,4];



export_system_comparison(systemsTable, stateNames, inputNames, index);
