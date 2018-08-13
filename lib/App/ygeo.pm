# ABSTRACT: Extract companies data from Yandex Maps to csv file

package App::ygeo;

=head1 SYNOPSIS

    use App::ygeo;
    my $ygeo = App::ygeo->new( apikey => '12345', city => "ROV" );
    $ygeo->get_and_print(text => 'autoservice', city => 'ROV', csv_filename => 'auto.csv', verbose => 1);

=head1 DESCRIPTION

By default it:

get data about maximum 500 companies (Yandex API restriction)

Order of looking for apikey 

- provided params

- C<.ygeo> file (firsty it search C<.ygeo> file in current directory, then in home directory)

C<.ygeo> config has yaml syntax. You can reuse L<App::ygeo::yaml> in your own projects

=cut

use strict;
use warnings;
use Text::CSV;
use Carp;
use Yandex::Geo;
use utf8;

use feature 'say';

sub new {
    my ( $class, %params ) = @_;
    croak "No yandex maps api key provided" unless defined $params{apikey} && length $params{apikey};
    bless { %params }, $class;
}


=head2 get_and_print

    $ygeo->get_and_print(text => 'autoservice', city => 'ROV', csv_filename => 'auto.csv', verbose => 1);

Get and prints data in csv data

Params:

text - search text
city - city to search, e.g. ROV is Rostov-on-Don
csv_filename - name of output csv file
results_limit -number of results returned

Columns sequence is according L<Yandex::Geo::Company/to_array> method

Results are printed like

    my $res = $yndx_geo->y_companies( $text );
    for my $company (@$res) {
        $csv->print( $fh, $company->to_array );
    }
    
Return 1 if finished fine

=cut

sub get_and_print {
    my ($self, %params) = @_;
    
    my $text = $params{text};
    croak "No search text defined" unless defined $text && length $text;
    
    my $city = $self->{city} || $params{city};
    my $csv_filename = $params{csv_filename} || $params{text}.'.csv';
    
    my $csv = Text::CSV->new() or die "Cannot use CSV: ".Text::CSV->error_diag ();
    $csv->eol ("\012");
    $csv->sep_char (";");
    
    open my $fh, ">:encoding(utf8)", $csv_filename or die "$csv_filename: $!";
    
    my $yndx_geo = Yandex::Geo->new(
        apikey => $self->{apikey},
        only_city => $city,
        results => $params{results_limit} || 500
    );

    my $res = $yndx_geo->y_companies( $text );
    
    say "Search: $text in city: $city"          if ( $self->{verbose} || $params{verbose} );
    say "Yandex Maps API key: $self->{apikey}"  if ( $self->{verbose} || $params{verbose} );
    say "Companies found: ".scalar @$res        if ( $self->{verbose} || $params{verbose} );

    for my $company (@$res) {
        $csv->print( $fh, $company->to_array );
    }
    
    close $fh or die "$csv_filename: $!";
    
    no warnings 'utf8';
    say "Data was written in $csv_filename" if ( $self->{verbose} || $params{verbose} );
    
    return 1;
}

1;