use ExtUtils::MakeMaker;
my %options = %{
{
  'CC' => 'g++ -D_REENTRANT -D_GNU_SOURCE -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++',
  'CCFLAGS' => ' -D_REENTRANT -D_GNU_SOURCE -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-literal-suffix -Wall -Wextra -Wno-delete-non-virtual-dtor -Wl,-E -Wl,-rpath,/usr/lib/perl5/5.36/core_perl/CORE -L"/usr/lib/perl5/5.36/core_perl/CORE" -L"/usr/lib/perl5/5.36/site_perl/auto/share/dist/Alien-PCRE2/lib" -D__CPP__TYPES -D__TYPE__INTEGER__LONG -D__TYPE__NUMBER__DOUBLE',
  'INC' => '-iquote"/usr/bin/site_perl" -I/usr/share/perl5/site_perl -Ilib -I/usr/lib/perl5/5.36/site_perl/auto/share/dist/Alien-PCRE2/include -I/usr/lib/perl5/5.36/site_perl/auto/share/dist/Alien-JPCRE2/include -I.',
  'LIBS' => [
    '-lstdc++'
  ],
  'NAME' => 'eval_62_cac1',
  'OPTIMIZE' => ' -O3 -fomit-frame-pointer -march=native -g',
  'TYPEMAPS' => [
    '/usr/share/perl5/core_perl/ExtUtils/typemap',
    '/usr/share/perl5/site_perl/typemap.rperl'
  ],
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
