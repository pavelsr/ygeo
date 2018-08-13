# NAME

ygeo - command line utility based on Yandex::Geo that prints data to csv

# VERSION

version 0.02

# SYNOPSIS

    ygeo "автомойки самообслуживания" ROV 25

1st positional argument is text to search 

2nd positional argument (optional) is IATA city code (see ["get" in Yandex::Geo](https://metacpan.org/pod/Yandex::Geo#get) and ["cities\_bbox" in Yandex::Geo](https://metacpan.org/pod/Yandex::Geo#cities_bbox) for more info). If no specified ygeo will take city from cfg.

3rd positional argument (optional) is number of results to return. By default: 500

# DESCRIPTION

Command line utility that do search via Yandex Maps Company Search API in specified city and prints result in csv file

By default it:

    prints maximum 500 companies (API restriction)

    looks for apikey and city in C<.ygeo> file. C<.ygeo> config has yaml syntax. Firsty it search C<.ygeo> file in current directory, then in home directory

# AUTHOR

Pavel Serikov <pavelsr@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Pavel Serikov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
