import casadi.*

dimInput = 3;
dimOutput = 1;

%% Data
XData = linspace(-2,2,10);
YData = (XData > -1) .*( XData<1);
%%

Nhiddenlayers = 3;
Nneurons = 4;
%


weights = {};
bias = {};

weights{1} =  casadi.SX.sym('wI',[Nneurons dimInput]);
bias{1}    =  casadi.SX.sym('bI',[dimInput 1]); 

for ilayer = 1:Nhiddenlayers
       string = ['w',num2str(ilayer)];
       weights{ilayer+1} = casadi.SX.sym(string,[Nneurons Nneurons]); 
       string = ['b',num2str(ilayer)];
       bias{ilayer+1}    = casadi.SX.sym(string,[Nneurons 1]); 

end

weights{ilayer+2} =  casadi.SX.sym('wO',[dimOutput Nneurons]);
bias{ilayer+2}    =  casadi.SX.sym('bO',[dimOutput 1]); 

%%
sigmoi = @(x) 0.5 + 0.5*tanh(2*x); 

%%

XDataSym = casadi.SX.sym('XData',[dimInput]);
YDataSym = casadi.SX.sym('YData',[dimOutput]);

%% 
J = sigmoi(weights{1}*XDataSym);
for ilayer = 1:Nhiddenlayers
   J = sigmoi(weights{ilayer+1}*J);
end
J = sigmoi(weights{ilayer+2}*J);
%%



