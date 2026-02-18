#!perl6

use v6;
use Test;
use lib 'lib';
use Grammar::Modelica;
use Grammar::Modelica::Actions;

plan 11;

my $actions = Grammar::Modelica::Actions.new;

my $compilation = Grammar::Modelica.parse(
    'within A.B; model X end X;',
    :actions($actions),
);
ok $compilation, 'compilation unit parses with actions';
is $compilation.made<node>, 'CompilationUnit', 'root node is CompilationUnit';
is $compilation.made<ast_version>, 1, 'AST version is set';
is-deeply $compilation.made<within><parts>, ['A', 'B'], 'within name is segmented';
ok $compilation.made<classes>.elems >= 1, 'contains class definitions';

my $expr = Grammar::Modelica.parse(
    '1+2*3',
    :rule<expression>,
    :actions($actions),
);

ok $expr, 'expression parses with actions';
is $expr.made<node>, 'BinaryOp', 'expression normalized to BinaryOp';
is $expr.made<op>, '+', 'top operator is +';
is $expr.made<left><node>, 'Literal', 'left side is a literal';
is $expr.made<right><node>, 'BinaryOp', 'right side preserves precedence';
is $expr.made<right><op>, '*', 'nested operator is *';
