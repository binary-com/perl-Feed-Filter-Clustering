use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'TimeSeries::AdaptiveFilter',
    AUTHOR             => q{Binary.com <support@binary.com>},
    VERSION_FROM       => 'lib/TimeSeries/AdaptiveFilter.pm',
    ( eval { ExtUtils::MakeMaker->VERSION(6.64) } ?
        (
            CONFIGURE_REQUIRES => {
                "ExtUtils::MakeMaker" => "6.64",
            },
            PREREQ_PM => {
              'List::Util' => 0,
            },
            BUILD_REQUIRES => {
                'Test::More'  => 0,
                'Test::Warnings' => 0,
            },
        ) : (
            PREREQ_PM => {
                "ExtUtils::MakeMaker" => '6.64',
                'List::Util'          => 0,
                'Test::More'          => 0,
                'Test::Warnings'      => 0,
            },
        )
    ),
    ( eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
    ( eval { ExtUtils::MakeMaker->VERSION(6.46) } ?
        (
            META_MERGE => {
                resources => {
                    repository => 'https://github.com/binary-com/perl-TimeSeries-AdaptiveFilter',
                },
            }
        ) : ()
    ),
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? ( MIN_PERL_VERSION => '5.10.0') : ()),
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'TimeSeries-AdaptiveFilter*' },
);
