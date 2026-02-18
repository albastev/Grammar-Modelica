use v6;

unit role Grammar::Modelica::Actions::ClassDefinition;

method class_def($/) {
    make {
        node      => 'ClassDefStmt',
        final     => so $<final>,
        class_def => self!made-or-raw($<class_definition>),
        loc       => self!loc($/),
    };
}

method class_definition($/) {
    my $prefix = self!made-or-raw($<class_prefixes>);
    my $kind = Nil;
    if $prefix ~~ Associative && $prefix<kind>.defined {
        $kind = $prefix<kind>;
    }

    make {
        node         => 'ClassDef',
        encapsulated => so $<encapsulated>,
        kind         => $kind,
        prefixes     => $prefix,
        spec         => self!made-or-raw($<class_specifier>),
        loc          => self!loc($/),
    };
}

method class_prefixes($/) {
    my $s = $/.Str.trim;
    my $kind = do given $s {
        when / 'operator' \s+ 'record' / { 'operator record' }
        when / 'operator' \s+ 'function' / { 'operator function' }
        when / 'expandable' \s+ 'connector' / { 'expandable connector' }
        when / 'connector' / { 'connector' }
        when / 'function' / { 'function' }
        when / 'package' / { 'package' }
        when / 'block' / { 'block' }
        when / 'record' / { 'record' }
        when / 'model' / { 'model' }
        when / 'class' / { 'class' }
        when / 'type' / { 'type' }
        when / 'operator' / { 'operator' }
        default { $s }
    };

    make {
        node    => 'ClassPrefixes',
        kind    => $kind,
        partial => so $<partial>,
        raw     => $s,
        loc     => self!loc($/),
    };
}

method class_specifier($/) {
    make self!made-or-raw(
        $<long_class_specifier>
        // $<short_class_specifier>
        // $<der_class_specifier>
    );
}

method long_class_specifier($/) {
    make {
        node => 'LongClassSpecifier',
        text => $/.Str,
        loc  => self!loc($/),
    };
}

method short_class_specifier($/) {
    make {
        node => 'ShortClassSpecifier',
        text => $/.Str,
        loc  => self!loc($/),
    };
}

method der_class_specifier($/) {
    make {
        node => 'DerClassSpecifier',
        text => $/.Str,
        loc  => self!loc($/),
    };
}
