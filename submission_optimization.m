function [l, fval, flag, output] = submission_optimization(x, y, lb, ub, x0, init_condi)

    % x - x position of the protopodium
    % y - y position of the protopodium
    % lb - lower limits of the muscle lenghts and angle
    % ub - upper limits of the muscle lengths and angle
    % x0 - previouse lengths and angle for the initial state of the optimization
    % init_condi - initial muscle lengths (to calculate the energy)

    % fmincon() optimization parameters
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    l_init = [init_condi(1:5),0];
    
    fun = @(l) cost(l, x, y, x0, l_init);
    options = optimoptions('fmincon','Display','off');

    [l, fval, flag, output] = fmincon(fun, x0, A, b, Aeq, beq, lb, ub, [], options);

    % cost function
    function c = cost(l, x, y, x0, l_init)

        % assign the stiffness
        I = eye(6)*1.3*5;

        % adjust the stiffness of VL
        I(1,1) = 1.3*4;

        % adjust the stiffness of VO
        I(3,3) = 1.3*3;

        % muscle length change for smooth length variation
        delta_l = x0-l;

        % muscle (spring) contraction for energy
        spring_change = l_init - l;

        % model prediction of the protopodium
        [T1,T2] = submission_forwardModel(l);

        % loop error
        loop_error = norm(T1-T2);

        % error between actual and prediction
        cart_error = norm([T1-[x y 0], T2-[x y 0]]);
        
        % weighted errors
        c = 5 * loop_error + 100 * cart_error;
        c = c + 30 * sqrt(spring_change * I * spring_change');
        c = c + 10 * norm(delta_l);
    
    end

end