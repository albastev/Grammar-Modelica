use v6;

unit role Grammar::Modelica::Actions::Expressions;

method expression($/) {
    if $<simple_expression> {
        make self!made-or-raw($<simple_expression>);
        return;
    }

    make {
        node => 'IfExpr',
        text => $/.Str,
        loc  => self!loc($/),
    };
}

method simple_expression($/) {
    my @parts = self!made-list($<logical_expression>);
    if @parts.elems <= 1 {
        make @parts[0] // { node => 'SimpleExpr', text => $/.Str, loc => self!loc($/) };
        return;
    }

    my %range = (
        node  => 'RangeExpr',
        start => @parts[0],
        stop  => @parts[*-1],
        loc   => self!loc($/),
    );
    %range<step> = @parts[1] if @parts.elems == 3;
    make %range;
}

method logical_expression($/) {
    make self!fold-left('or', self!made-list($<logical_term>), self!loc($/));
}

method logical_term($/) {
    make self!fold-left('and', self!made-list($<logical_factor>), self!loc($/));
}

method logical_factor($/) {
    my $relation = self!made-or-raw($<relation>);
    if $/.Str.trim.starts-with('not') {
        make {
            node => 'UnaryOp',
            op   => 'not',
            expr => $relation,
            loc  => self!loc($/),
        };
        return;
    }

    make $relation;
}

method relation($/) {
    my @arith = self!made-list($<arithmetic_expression>);
    if @arith.elems == 2 {
        make {
            node  => 'BinaryOp',
            op    => $<relational_operator>.Str,
            left  => @arith[0],
            right => @arith[1],
            loc   => self!loc($/),
        };
        return;
    }

    make @arith[0] // { node => 'Relation', text => $/.Str, loc => self!loc($/) };
}

method arithmetic_expression($/) {
    make self!fold-infix(self!made-list($<term>), self!str-list($<add_operator>), self!loc($/));
}

method term($/) {
    make self!fold-infix(self!made-list($<factor>), self!str-list($<mul_operator>), self!loc($/));
}

method factor($/) {
    my @primaries = self!made-list($<primary>);
    if @primaries.elems == 2 {
        make {
            node  => 'BinaryOp',
            op    => '^',
            left  => @primaries[0],
            right => @primaries[1],
            loc   => self!loc($/),
        };
        return;
    }

    make @primaries[0] // { node => 'Factor', text => $/.Str, loc => self!loc($/) };
}

method primary($/) {
    my $text = $/.Str.trim;

    if $<UNSIGNED_NUMBER> {
        make {
            node  => 'Literal',
            kind  => 'number',
            value => $<UNSIGNED_NUMBER>.Str,
            loc   => self!loc($/),
        };
        return;
    }

    if $<STRING> {
        make {
            node  => 'Literal',
            kind  => 'string',
            value => $<STRING>.Str,
            loc   => self!loc($/),
        };
        return;
    }

    if $text eq 'true' || $text eq 'false' {
        make {
            node  => 'Literal',
            kind  => 'boolean',
            value => $text eq 'true',
            loc   => self!loc($/),
        };
        return;
    }

    if $<component_reference> && $<function_call_args> {
        my $args = self!made-or-raw($<function_call_args>);
        my $call-args = self!as-array($args);
        if $args ~~ Associative && $args<args>.defined {
            $call-args = $args<args>;
        }
        make {
            node   => 'Call',
            callee => self!made-or-raw($<component_reference>),
            args   => $call-args,
            loc    => self!loc($/),
        };
        return;
    }

    if $<component_reference> {
        make self!made-or-raw($<component_reference>);
        return;
    }

    make {
        node => 'Primary',
        text => $/.Str,
        loc  => self!loc($/),
    };
}

method component_reference($/) {
    my @parts = self!str-list($<IDENT>).map({ { name => $_ } }).Array;
    make {
        node     => 'ComponentRef',
        absolute => $/.Str.trim.starts-with('.'),
        parts    => @parts,
        loc      => self!loc($/),
    };
}

method function_call_args($/) {
    my @args;
    if $<function_arguments> {
        my $made = self!made-or-raw($<function_arguments>);
        if $made ~~ Associative && $made<args>.defined {
            @args = $made<args>.Array;
        }
        else {
            @args = self!as-array($made);
        }
    }

    make {
        node => 'CallArgs',
        args => @args,
        loc  => self!loc($/),
    };
}

method function_arguments($/) {
    my @args;
    @args.append(self!made-list($<expression>));
    @args.append(self!as-array(self!made-or-raw($<function_arguments_non_first>))) if $<function_arguments_non_first>;
    @args.append(self!as-array(self!made-or-raw($<named_arguments>))) if $<named_arguments>;

    make {
        node => 'FunctionArguments',
        args => @args,
        loc  => self!loc($/),
    };
}

method function_arguments_non_first($/) {
    if $<named_arguments> {
        make self!made-or-raw($<named_arguments>);
        return;
    }

    make self!made-list($<function_argument>);
}

method named_arguments($/) {
    make self!made-list($<named_argument>);
}

method named_argument($/) {
    make {
        node  => 'NamedArg',
        name  => $<IDENT>.Str,
        value => self!made-or-raw($<function_argument>),
        loc   => self!loc($/),
    };
}

method function_argument($/) {
    if $<function_partial_application> {
        make self!made-or-raw($<function_partial_application>);
        return;
    }

    make self!made-or-raw($<expression>);
}

method function_partial_application($/) {
    make {
        node => 'FunctionPartialApplication',
        name => $<name>.Str,
        loc  => self!loc($/),
    };
}

method name($/) {
    make {
        node  => 'Name',
        parts => self!name-parts($/),
        loc   => self!loc($/),
    };
}

method !str-list($match) {
    return [] unless $match;
    return $match.map(*.Str).Array if $match ~~ Positional;
    [ $match.Str ];
}

method !as-array($value) {
    return [] unless $value.defined;
    return $value.Array if $value ~~ Positional;
    [ $value ];
}

method !fold-left(Str $op, @items, %loc) {
    return { node => 'Raw', text => '', loc => %loc } unless @items.elems;
    return @items[0] if @items.elems == 1;

    my $expr = @items[0];
    for @items[1..*] -> $right {
        $expr = {
            node  => 'BinaryOp',
            op    => $op,
            left  => $expr,
            right => $right,
            loc   => %loc,
        };
    }
    $expr;
}

method !fold-infix(@values, @ops, %loc) {
    return { node => 'Raw', text => '', loc => %loc } unless @values.elems;

    my $expr;
    my $op-index = 0;
    my $value-index = 1;

    if @ops.elems == @values.elems {
        $expr = {
            node => 'UnaryOp',
            op   => @ops[0],
            expr => @values[0],
            loc  => %loc,
        };
        $op-index = 1;
    }
    else {
        $expr = @values[0];
    }

    while $op-index < @ops.elems && $value-index < @values.elems {
        $expr = {
            node  => 'BinaryOp',
            op    => @ops[$op-index],
            left  => $expr,
            right => @values[$value-index],
            loc   => %loc,
        };
        $op-index++;
        $value-index++;
    }

    $expr;
}
