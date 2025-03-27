function root_lat_plot (transferFunctions,state_cases,state,input)
    
    k = size( transferFunctions ,2);
    subtitles = {'linearized full model','3DOF Duch roll Approximation','3DOF Spiral Approximation', '2DOF Duch roll Approximation' , '1DOF Roll Approximation'};
    main_titlle = sprintf('The root locus of $%s$ due to $%s$', state , input);% u due de 
    % title_str = sprintf('Temperature: %d°C', temperature);
    h=1;
    for i= 1:1:5
        
        if (1 == state_cases(i))
        
            subtitle_new(h) = subtitles(i);
            h=h+1;

        else
        
        end
    end
    

    figure

    for i = 1:1:k

        subplot(k,1,i)
        rlocus(transferFunctions{i})
        title(subtitle_new(i))  
            
    end

  


end
