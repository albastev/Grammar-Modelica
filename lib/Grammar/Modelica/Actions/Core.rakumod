use v6;

unit role Grammar::Modelica::Actions::Core;

method TOP($/) {
    my $within = $<within> ?? $<within>.made !! Nil;
    my @classes = self!made-list($<class_def>);

    make {
        ast_version => 1,
        node        => 'CompilationUnit',
        within      => $within,
        classes     => @classes,
        loc         => self!loc($/),
    };
}

method within($/) {
    make {
        node  => 'Within',
        parts => $<name> ?? self!name-parts($<name>) !! [],
        loc   => self!loc($/),
    };
}

method !loc($/) {
    {
        from => $/.from,
        to   => $/.to,
    }
}

method !made-or-raw($match) {
    return Nil unless $match;
    return $match.made if $match.made.defined;

    {
        node => 'Raw',
        text => $match.Str,
        loc  => self!loc($match),
    }
}

method !made-list($match) {
    return [] unless $match;

    if $match ~~ Positional {
        return $match.map({ self!made-or-raw($_) }).Array;
    }

    [ self!made-or-raw($match) ];
}

method !name-parts($name-match) {
    $name-match.Str.split('.').grep(*.chars).Array
}
