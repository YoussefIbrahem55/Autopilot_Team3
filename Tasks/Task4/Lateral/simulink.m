
%due to da inputs

[states_sim_da_mat] = simulink_inputs(4,da_input,1);

  v_sim_da     = squeeze(states_sim_da_mat(:,:,2) );
  p_sim_da     = squeeze(states_sim_da_mat(:,:,7) );
  r_sim_da     = squeeze(states_sim_da_mat(:,:,9) );
  phi_sim_da   = squeeze(states_sim_da_mat(:,:,10));
  psi_sim_da   = squeeze(states_sim_da_mat(:,:,12));


%due to dr inputs

[states_sim_dr_mat] = simulink_inputs(4,dr_input,2);

  v_sim_dr     = squeeze(states_sim_dr_mat(:,:,2) );
  p_sim_dr     = squeeze(states_sim_dr_mat(:,:,7) );
  r_sim_dr     = squeeze(states_sim_dr_mat(:,:,9) );
  phi_sim_dr   = squeeze(states_sim_dr_mat(:,:,10));
  psi_sim_dr   = squeeze(states_sim_dr_mat(:,:,12));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%due to da inputs

[states_sim_da_mat] = simulink_inputs(4,da_input,1);

  v_sim_da     = squeeze(states_sim_da_mat(:,:,2) );
  p_sim_da     = squeeze(states_sim_da_mat(:,:,7) );
  r_sim_da     = squeeze(states_sim_da_mat(:,:,9) );
  phi_sim_da   = squeeze(states_sim_da_mat(:,:,10));
  psi_sim_da   = squeeze(states_sim_da_mat(:,:,12));
  alpha_sim_da = squeeze(states_sim_da_mat(:,:,13));
  beta_sim_da  = squeeze(states_sim_da_mat(:,:,14));

%due to dr inputs

[states_sim_dr_mat] = simulink_inputs(4,dr_input,2);

  v_sim_dr     = squeeze(states_sim_dr_mat(:,:,2) );
  p_sim_dr     = squeeze(states_sim_dr_mat(:,:,7) );
  r_sim_dr     = squeeze(states_sim_dr_mat(:,:,9) );
  phi_sim_dr   = squeeze(states_sim_dr_mat(:,:,10));
  psi_sim_dr   = squeeze(states_sim_dr_mat(:,:,12));
  alpha_sim_dr  = squeeze(states_sim_dr_mat(:,:,13));
  beta_sim_dr   = squeeze(states_sim_dr_mat(:,:,14));
