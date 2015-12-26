-module(uberpt_test).

-compile({parse_transform, uberpt}).
-compile(export_all).

-export([
		test/1
	]).

-ast_fragment([]).
test1() ->
	1.

-ast_fragment([]).
test2(A, B, C) ->
	{X, Y} = {A, B},
	{C, X, Y, B}.

test(A) ->
	{
		test1(),
		test2(A, ast(2), ast(3))
	}.

-ast_fragment2([]).
test3_(
		{in, [Foo]},
		{out, [Bar]},
		{temp, []}
	) ->
	Bar = Foo + 1.

test4() ->
	A = ast(1),
	ast(quote(A) + 1).

test5(Ast) ->
	A = ast(begin x(), y() end),
	ast_function(foo, fun (A) -> quote(A); ({B}) -> quote(Ast) end).
