var w1 >= 0;
var wk6 >= 0; #k budget in graph with degree max 6
var wk5 >= 0; #k budget in graph with degree max 5
var wk4 >= 0; #k budget in graph with degree max 4
var wk3 >= 0; #k budget in graph with degree max 3
var wk2 >= 0; #k budget in graph with degree max 2
var ws >= 0;
var alpha6 >= 0;
var alpha5 >= 0;
var alpha4 >= 0;
var alpha3 >= 0;
var alpha2 >= 0;
var alpha >= 0 ; #we can solve yes instance smaller than 0.718n, what's left are those bigger than 0.718n



var base;
param l; #lower bound of piece
param u; #upper bound of piece
param b_s;#budget on the independent set


param threec = 1.3289;#1.3217 gives you 1.7153
param c = log(threec)/log(2); #d = log_2(1.3289)

#var run_b = w1 + wk6 * u + wk5 * u + wk4 * u + wk3 * u+ wk2 * u  + ws * b_s+ c * u; #branching algo when width based algo is not triggered

var run_b = w1 + wk6 * (u - alpha6) + wk5 * (u - alpha5) + wk4 * (u - alpha4) + wk3 * (u - alpha3)+ wk2 * (u - alpha2) + ws * b_s+ c * u; #branching algo when width based algo is not triggered
var run_w = 4^alpha; #width based algo
var run;


minimize Obj: run;

subject to con_thre_abs_order_1:
	alpha6 <= max(0,(45 * alpha - 23)/22);

subject to con_thre_abs_order_2:
	alpha5 <= max(0,(30 * alpha - 13)/17);

subject to con_thre_abs_order_3:
	alpha4 <= max(0,(3 * alpha - 1)/2);

subject to con_thre_abs_order_4:
	alpha3 <= max(0,(6 * alpha - 1)/5);

subject to con_thre_abs_order_5:
	alpha6 <= alpha5;

subject to con_thre_abs_order_6:
	alpha5 <= alpha4;
	
subject to con_thre_abs_order_7:
	alpha4 <= alpha3;

subject to con_thre_abs_order_8:
	alpha3 <= alpha2;
	
subject to con_thre_abs_order_9:
	alpha2 <= alpha;

	
subject to con_thre_abs_order_10:
	alpha <= 1;

subject to alpha_u:
	alpha <= u;

subject to run_time_con_1:
	run >= 2^run_b;
	
subject to run_time_con_2:
	run >= run_w;

subject to con_deg_7_and_above: 
	2^(-(
		w1
	)) + 2^(-(
		8 * w1 + ws
	)) <= 1;
	
subject to con_deg_6:
	2^(-(
		w1 + wk6
	)) + 2^(-(
		7 * w1 + 6 * wk6 + ws
	)) <= 1;

subject to con_deg_5:
	2^(-(
		w1 + wk6 + wk5
	)) + 2^(-(
		6 * w1  + 5 * wk6 + 5 * wk5 + ws
	)) <= 1;

subject to con_deg_4: 
	2^(-(
		w1 +  wk6 + wk5 + wk4
	)) + 2^(-(
		5 * w1 + 4 * wk6 + 4 * wk5 + 4 * wk4 + ws
	)) <= 1;

subject to con_deg_3: 
	2^(-(
		w1  + wk6 + wk5 + wk4 + wk3 
	)) + 2^(-(
		4 * w1 + 3 * wk6 + 3 * wk5 + 3 * wk4 + 3 * wk3 + ws
	)) <= 1;

# after exhaustively apply the above rule, the maximum degree of graph is 2. The only object lefts are either paths or cycles
# there are at most 3n/4 of them


subject to con_deg_2: 
	2^(-(
		w1  + wk6 + wk5 + wk4 + wk3 + wk2
	)) + 2^(-(
		3 * w1  + 2 * wk6 + 2 * wk5 + 2 * wk4 + 2 * wk3  + 2 * wk2 + ws
	)) <= 1;



subject to con_deg_1: 
	2^(-(
		2* w1  + wk6 + wk5 + wk4 + wk3 + wk2 + ws
	)) + 2^(-(
		2* w1  + wk6 + wk5 + wk4 + wk3 + wk2 + ws
	)) <= 1;




