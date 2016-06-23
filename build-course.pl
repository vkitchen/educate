#!/usr/bin/perl
use strict;
use warnings;

# use Data::Dumper qw(Dumper);
use JSON;

my $outfolder = "api/1/python/";

my $file = $ARGV[0];
my $document = do {
    local $/ = undef;
    open my $fh, "<", $file or die "Could not open $file: $!";
    <$fh>;
};

my $filenumber = 0;
my %outfile;
my $mode = 1;

sub write_file {
    my $file = $_[0];
    my $data = $_[1];
    open my $fh, ">", $file or die("Could not open file $file: $!");
    print $fh $data;
    close $fh;
}

my @lines = split /\n/, $document;

# Count pages
my $pagecount = 0;
foreach my $line (@lines) {
    if ($line =~ /^    :::/) {
        $pagecount++;
    }
}

# Build each page
foreach my $line (@lines) {
    # Reverse order so that they don't cascade
    if ($mode == 2 && not ($line =~ /^    /)) {
        $mode = 1; # Back to a lesson block
        $outfile{"total_items"} = $pagecount;
        write_file("$outfolder$filenumber.json", encode_json \%outfile);
        %outfile = ();
        $filenumber += 1;
    }
    if ($mode == 1 && $line =~ /^    /) {
        $mode = 2; # We've now got the code block
    }
    if ($mode == 1) {
        $outfile{"lesson"} .= $line ."\n";
    }
    if ($mode == 2 && not ($line =~ /^    :::/)) {
        $line =~ /^    (.*)/;
        $outfile{"code"} .= $1 ."\n" if ($1);
    }
}

$outfile{"total_items"} = $pagecount;
write_file("$outfolder$filenumber.json", encode_json \%outfile);
