/**
    Main file for running the simple Elevator examples.

    This file loads the interpreter and the application file, and has a main/0 and main/1 predicate to run the available controllers.

    This file needs to be combined after a configuration file, such as config.pl, is loaded (defining interpreter/1).
**/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSULT NECESSARY FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% top-level interpreter (interpreter/1 is defined in config.pl)
:- dir(indigolog, F), consult(F).
:- dir(eval_bat, F), consult(F). 

% 4 - Consult application
:- [klondike].

em_address(localhost, 8000).

load_devices([simulator]).

load_device(simulator, Host:Port, [pid(PID)]) :-
	dir(dev_simulator, File),
	ARGS = ['-e', 'swipl', '-t', 'start', File, '--host', Host, '--port', Port],
	logging(
		info(5, app), "Command to initialize device simulator: xterm -e ~w", [ARGS]),
	process_create(
		path(xterm), ARGS,
		[process(PID)]).

how_to_execute(Action, simulator, sense(Action)) :-
	sensing_action(Action, _).

how_to_execute(Action, simulator, Action) :-
	 \+ sensing_action(Action, _).


translate_exog(ActionCode, Action) :-
	actionNum(Action, ActionCode), !.
translate_exog(A, A).
translate_sensing(_, SR, SR).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN PREDICATE - evaluate this to run demo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% main/0: Gets INDIGOLOG to evaluate a chosen mainControl procedure
main :-
	findall(C,
		proc(
			control(C), _), LC),
	length(LC, N), repeat,
	format('Controllers available: ~w\n', [LC]),
	forall(
		(
			between(1, N, I),
			nth1(I, LC, C)),
		format('~d. ~w\n', [I, C])), nl, nl,
	write('Select controller: '),
	read(NC), nl,
	number(NC),
	nth1(NC, LC, C),
	format('Executing controller: *~w*\n', [C]), !,
	main(
		control(C)).

main(C) :-
	assert(
		control(C)),
	indigolog(C).


:- set_option(log_level, 5).
:- set_option(log_level, em(1)).
:- set_option(wait_step, 1).

legality_task :-
	read(Q), nl,
	indigolog(Q).

projection_task :- 
	write("Conditions: \n"),
	read(C), nl,
	write("Actions: \n"),
	read(Q), nl,
	(eval(C, Q, true) -> format("~w=true -> True", C); format("~w=true -> False", C)), 
	nl.
	