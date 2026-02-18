#!perl6

use v6;
use lib 'lib';
use Grammar::Modelica;

# Usage:
#   raku -Ilib examples/parseThemAll.p6 <modelica-dir> [--jobs=N]
#
# Output:
#   - One line per file: OK/FAIL/ERROR
#   - Final summary: passed/failed/total
#
# Exit code:
#   - 0 when all files parse successfully
#   - 1 when any file fails

sub parse-one(IO::Path:D $file --> Bool) {
    my $contents = $file.slurp;
    my $match = Grammar::Modelica.parse($contents);

    if $match {
        say "OK\t$file";
        True;
    }
    else {
        say "FAIL\t$file";
        False;
    }
}

sub MAIN(
    Str:D $modelica-dir,
    Int:D :$jobs = $*KERNEL.cpu-cores
) {
    die "Can't find directory: $modelica-dir" if !$modelica-dir.IO.d;

    # https://docs.perl6.org/routine/dir
    my @stack = $modelica-dir.IO;
    my @files;
    while @stack {
        for @stack.pop.dir -> $path {
            @files.push($path) if $path.f && $path.extension.lc eq 'mo';
            @stack.push: $path if $path.d;
        }
    }

    @files = @files.sort;
    die "No .mo files found under: $modelica-dir" if @files.elems == 0;

    say "Directory: $modelica-dir";
    say "Found {@files.elems} .mo files";
    say "Using $jobs parallel worker(s)";

    my @results = @files.race(:degree($jobs)).map(-> $file {
        my $ok = try {
            parse-one($file);
        };

        unless $ok.defined {
            my $error = $! // 'Unknown error';
            say "ERROR\t$file\t$error";
            $ok = False;
        }

        $ok;
    }).Array;

    my $failed = @results.grep({ !$_ }).elems;
    my $passed = @results.elems - $failed;

    say "Summary: passed=$passed failed=$failed total={@results.elems}";
    exit($failed == 0 ?? 0 !! 1);
}
