use 5.00503;
use ExtUtils::MakeMaker;

eval {
  require LWP;
  if ($LWP::VERSION eq "5.76") {
    print STDERR <<'EOF';

*** Warning: it is not recommended to use this version of link checker with
*** libwww-perl version 5.76.  Version 5.76 of libwww-perl has a bug which
*** may cause the link checker to follow redirects to file: URLs.

EOF
  }
};


WriteMakefile(
  NAME          => 'W3C::LinkChecker',
  ABSTRACT      => 'W3C Link Checker',
  AUTHOR        => 'The W3C Link Checker Team <www-validator@w3.org>',
  VERSION_FROM  => 'bin/checklink',
  PREREQ_PM     => {
                     CGI             => 0,
                     Config::General => 2.06,
                     HTML::Parser    => 3.00,
                     LWP             => 5.66,
                     Net::IP         => 0, # Optional, see the docs.
                     Term::ReadKey   => 2.00,
                     Time::HiRes     => 0,
                     URI             => 0,
                     # For the test suite:
                     Test::Simple    => 0,
                     File::Spec      => 0,
                   },
  EXE_FILES     => [ 'bin/checklink' ],
  MAN1PODS      => { 'bin/checklink.pod' =>
                     '$(INST_MAN1DIR)/checklink.$(MAN1EXT)',
                   },
  dist          => { TARFLAGS => '--owner=0 --group=0 -cvf' },
  clean         => { FILES => 'ChangeLog.bak' },
);

sub MY::postamble {
  return <<'MAKE_FRAG';
changelog:
	cvs2cl --FSF --utc --prune \
	  --ignore ChangeLog --ignore cvsignore --ignore SIGNATURE \
	  --ignore Makefile.PL --ignore META.yml --ignore MANIFEST \
	  --ignore NEWS
MAKE_FRAG
}