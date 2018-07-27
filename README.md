# NAME

App::ygeo::yaml - Set of functions for working with yaml config files

# VERSION

version 0.01

# SYNOPSIS

    use App::ygeo::yaml qw[:ALL];
    
    my @config_files = (
        File::Spec->catfile(getcwd(), '.ygeo'), 
        $ENV{"HOME"}.'/.ygeo'
    );
    my @required_keys = qw/api_key city/;

    my $params = data_from_first_valid_cfg( \@config_files, \@required_keys );
    $params = create_cfg($config_files[0], @required_keys) unless $params;

# data\_from\_first\_valid\_cfg

Check for first valid config and return data from it as hash

    data_from_first_valid_cfg( [ '.ygeo', '~/.ygeo' ], [ 'apikey', 'city'] );

If no valid config found return undef

# keys\_exists\_no\_empty

Check that all required keys exists and their values are not empty

    keys_exists_no_empty( { api_key => 1111, city => 'ROV' } , ['api_key', 'city'] )

# create\_cfg

Create config in current directory with required parameters

    create_cfg( '.ygeo', 'apikey', 'city' );

Will create user promt 

Return hash with inputed parameters

# AUTHOR

Pavel Serikov <pavelsr@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Pavel Serikov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
