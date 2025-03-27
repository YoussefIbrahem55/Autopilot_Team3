function [v,p,r,phi,psi,t_v,t_p,t_r,t_phi,t_psi] = lat_response(n_inputs,inputs,tf_num_mat,tf_dom_mat,tend,v0,p0,r0,phi0,psi0)
     
    for i = 1:1:n_inputs %n_inputs is the variable vector

        [v_s ,t_v_s] = step(tf(tf_num_mat(1,:),tf_dom_mat),tend);
        v(:,i)       = v_s * inputs(i) + v0;  % v_s is the response of the step function for v (1st tf)
        t_v(:,i)     = t_v_s;                 % t_v_s is the response time of the step function for v and so on..

        [p_s ,t_p_s] = step(tf(tf_num_mat(2,:),tf_dom_mat),tend);
        p(:,i)       = p_s * inputs(i) + p0;
        t_p(:,i)     = t_p_s;

        [r_s ,t_r_s] = step(tf(tf_num_mat(3,:),tf_dom_mat),tend);
        r(:,i)       = r_s * inputs(i) + r0;
        t_r(:,i)     = t_r_s;

        [phi_s ,t_phi_s] = step(tf(tf_num_mat(4,:),tf_dom_mat),tend);
        phi(:,i)         = phi_s * inputs(i) + phi0;
        t_phi(:,i)       = t_phi_s;

        [psi_s ,t_psi_s] = step(tf(tf_num_mat(5,:),tf_dom_mat),tend);
        psi(:,i)         = psi_s * inputs(i) + psi0;
        t_psi(:,i)       = t_psi_s;

    end

end