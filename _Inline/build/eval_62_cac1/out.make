Running Mkbootstrap for eval_62_cac1 ()
chmod 644 "eval_62_cac1.bs"
"/usr/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- eval_62_cac1.bs blib/arch/auto/eval_62_cac1/eval_62_cac1.bs 644
"/usr/bin/perl" "/usr/share/perl5/core_perl/ExtUtils/xsubpp"  -typemap "/usr/share/perl5/core_perl/ExtUtils/typemap" -typemap "/usr/share/perl5/site_perl/typemap.rperl"   eval_62_cac1.xs > eval_62_cac1.xsc
mv eval_62_cac1.xsc eval_62_cac1.c
g++ -D_REENTRANT -D_GNU_SOURCE -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++ -c  -iquote"/usr/bin/site_perl" -I/usr/share/perl5/site_perl -Ilib -I/usr/lib/perl5/5.36/site_perl/auto/share/dist/Alien-PCRE2/include -I/usr/lib/perl5/5.36/site_perl/auto/share/dist/Alien-JPCRE2/include -I. -D_REENTRANT -D_GNU_SOURCE -fwrapv -fno-strict-aliasing -pipe -fstack-protector-strong -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-literal-suffix -Wall -Wextra -Wno-delete-non-virtual-dtor -Wl,-E -Wl,-rpath,/usr/lib/perl5/5.36/core_perl/CORE -L"/usr/lib/perl5/5.36/core_perl/CORE" -L"/usr/lib/perl5/5.36/site_perl/auto/share/dist/Alien-PCRE2/lib" -D__CPP__TYPES -D__TYPE__INTEGER__LONG -D__TYPE__NUMBER__DOUBLE -O3 -fomit-frame-pointer -march=native -g   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl5/5.36/core_perl/CORE"   eval_62_cac1.c
rm -f blib/arch/auto/eval_62_cac1/eval_62_cac1.so
LD_RUN_PATH="/usr/lib" cc  -shared -Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -flto=auto -L/usr/local/lib -fstack-protector-strong  eval_62_cac1.o  -o blib/arch/auto/eval_62_cac1/eval_62_cac1.so  \
   -lstdc++   \
  
chmod 755 blib/arch/auto/eval_62_cac1/eval_62_cac1.so
