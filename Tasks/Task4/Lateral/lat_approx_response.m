function [states_res , states_res_t] = lat_approx_response(states_number,inputs,tf_num_mat,tf_dom_mat,tend,Ics)
    
t= 0: 0.01 :tend;

if ( (size(Ics,2) == size(tf_num_mat,1)) &&  (states_number == size(Ics,2)) )

    n_inputs = size(inputs,2);      %n_inputs is the variable vector 

    for state = 1:1: states_number
        
        for i = 1:1:n_inputs

            [state_vec , state_t_vec] = step( tf(tf_num_mat(state,:) , tf_dom_mat), t);
    
            states_res(state,i,:)   = state_vec * inputs(i) + Ics(state);        % states_res is the response of the step function for v (1st tf)
            states_res_t(state,i,:) = state_t_vec;                               % states_res_t is the response time of the step function for v and so on..
                           
        end

    end


else
    warning('The number of states and the number of ICs are not the same')
end

end