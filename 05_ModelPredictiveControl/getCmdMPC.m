% Calculate control command u(k) for MPC

% XiaoCY 2021-10-28

%%
function [u,U] = getCmdMPC(xk,A,B,Q,R,F,N)
    n = size(A,1);
    M = eye(n*(N+1),n);
    C = zeros(n*(N+1),N*size(B,2));
    
    Mi = eye(n);
    Bi = B;
    for i = 1:N
        Mi = A*Mi;
        rowM = (i*n+1):(i*n+n);
        M(rowM,:) = Mi;

        if i >= 2
            Bi = A*Bi;
        end

        rowC = (i*n+1):n*(N+1);
        colC = 1:(N+1-i)*size(B,2);
        C(rowC,colC) = C(rowC,colC) + kron(eye(N+1-i),Bi);
    end

    Qbar = blkdiag(kron(eye(N),Q),F);
    Rbar = kron(eye(N),R);
    H = C'*Qbar*C + Rbar;
    f = C'*Qbar'*M*xk;

    opts = optimoptions('quadprog','Display','off');
    U = quadprog(H,f,[],[],[],[],[],[],[],opts);
    u = U(1);
end