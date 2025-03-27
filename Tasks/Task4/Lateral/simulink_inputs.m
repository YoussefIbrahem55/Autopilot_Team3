% target_block is from 1 to 4 for the next 
%                          aileron
%                          rudder
%                          elevator
%                          thrust

function [states] = simulink_inputs(n_inputs,inputs,target_block)
  
    % reset the inputs
    set_param('Aircraft_Simulator_LAT/rudder','Value' ,num2str( 0 ))
    set_param('Aircraft_Simulator_LAT/elevator','Value' , num2str( 0 ))
    set_param('Aircraft_Simulator_LAT/aileron','Value' , num2str( 0 ))
    set_param('Aircraft_Simulator_LAT/thrust','Value' , num2str( 0 ))
    

    % choose the block target
    switch target_block
        case 1
           blockhandle = getSimulinkBlockHandle('Aircraft_Simulator_LAT/aileron',true);
        case 2
            blockhandle = getSimulinkBlockHandle('Aircraft_Simulator_LAT/rudder',true);
        case 3
            blockhandle = getSimulinkBlockHandle('Aircraft_Simulator_LAT/elevator',true);
        case 4
            blockhandle = getSimulinkBlockHandle('Aircraft_Simulator_LAT/thrust',true);

    end


    if(n_inputs == size(inputs,2))

        for i = 1:1:n_inputs
            set_param(blockhandle,'Value' , num2str( inputs(i) ) );
            sim('Aircraft_Simulator_LAT')
            states(:,i,1)  = out_u;
            states(:,i,2)  = out_v;
            states(:,i,3)  = out_w;
            states(:,i,4)  = out_p; % in deg
            states(:,i,5)  = out_q;
            states(:,i,6)  = out_r;
            states(:,i,7)  = out_phi; 
            states(:,i,8)  = out_theta;
            states(:,i,9)  = out_x ;
            states(:,i,10) = out_y ;
            states(:,i,11) = out_z;
%             states(:,i,12) = psi;
%             states(:,i,13) = alpha;
%             states(:,i,14) = beta;

        end

    else
        warning('the inputs are not the same number as given,simulink Func')

    end

end
