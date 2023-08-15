#! /bin/perl

# get_correct_suffix.pl

# Get the correct suffix for the name of a file at a given path, ignoring the existing suffix (if any) and
# basing our type determination on the "checktype_filename" method of modules "File::Type" and/or on direct
# examination of the contents of the file. If we are unable to determine the correct suffix through these
# methods, then return the existing suffix (if any), or return '.unk' if there is no existing suffix,
# or return '***ERROR***' if an error occurs (no file, not-data-file, file open/read/close error, perms, etc).
sub get_correct_suffix :prototype($) ($path) {
   if ($db) {
      say STDERR '';
      say STDERR "In get_correct_suffix(), at top.";
      say STDERR "\$path = $path";
   }

   # Return an error code unless $path points to an existing data file:
   return '***ERROR***' unless is_data_file($path);

   # Try to determine the correct suffix using the checktype_filename() method from module "File::Type":
   my $name  = get_name_from_path($path);
   my $suff  = get_suffix($name);
   my $typer = File::Type->new(); # File-typing functor.
   my $type  = $typer->checktype_filename($path); # Get media-type of file at $path.

   # If checktype_filename() crashed, either the file is corrupt or we don't have permission to access it;
   # either way, it's an error:
   return '***ERROR***' unless defined $type;

   # If we get to here, we've successfully obtained the media type of the file at $path.
   # Now lets "normalize" that type, converting it to all-lower-case and getting rid of cruft:
   $type = lc $type;      # Lower-case the type.
   $type =~ s%/x(-|.)%/%; # Get rid of "unregistered "markers ("x-" and variants).
   $type =~ s%\+\pL+%%;  # Get rid of alternate type interpretations (eg, xml for svg).

   # Announce type if debugging:
   if ( $db ) {
      say STDERR '';
      say STDERR "In get_correct_suffix(), just got type.";
      say STDERR "\$type = $type";
   }

   # Match normalized type against known types and choose extension if possible:
   for ($type) {
      m%^video/msvideo$%                                   and return '.avi'  ;
      m%^image/bmp$%                                       and return '.bmp'  ;
      m%^application/freearc$%                             and return '.arc'  ;
      m%^text/css$%                                        and return '.css'  ;
      m%^text/csv$%                                        and return '.csv'  ;
      m%^application/msword$%                              and return '.doc'  ;
      m%^application/epub$%                                and return '.epub' ; # Also epub+zip
      m%^image/gif$%                                       and return '.gif'  ;
      m%^application/gzip$%                                and return '.gzip' ;
      m%^text/html$%                                       and return '.html' ;
      m%^image/vnd.microsoft.icon$%                        and return '.ico'  ;
      m%^application/java-archive$%                        and return '.jar'  ;
      m%^image/jpeg$%                                      and return '.jpg'  ;
      m%^text/javascript$%                                 and return '.js'   ;
      m%^application/javascript$%                          and return '.js'   ;
      m%^application/json$%                                and return '.json' ;
      m%^audio/midi$%                                      and return '.mid'  ;
      m%^audio/mp3$%                                       and return '.mp3'  ;
      m%^video/mp4$%                                       and return '.mp4'  ;
      m%^video/mpeg$%                                      and return '.mpg'  ;
      m%^application/vnd.oasis.opendocument.presentation$% and return '.odp'  ;
      m%^application/vnd.oasis.opendocument.spreadsheet$%  and return '.ods'  ;
      m%^application/vnd.oasis.opendocument.text$%         and return '.odt'  ;
      m%^audio/ogg$%                                       and return '.ogg'  ;
      m%^font/otf$%                                        and return '.otf'  ;
      m%^image/png$%                                       and return '.png'  ;
      m%^application/pdf$%                                 and return '.pdf'  ;
      m%^application/httpd-php$%                           and return '.php'  ;
      m%^application/vnd.ms-powerpoint$%                   and return '.ppt'  ;
      m%^application/vnd.rar$%                             and return '.rar'  ;
      m%^application/rtf$%                                 and return '.rtf'  ;
      m%^application/sh$%                                  and return '.sh'   ;
      m%^image/svg$%                                       and return '.svg'  ; # Also svg+xml
      m%^application/tar$%                                 and return '.tar'  ;
      m%^text/plain$%                                      and return '.txt'  ; # Never actually comes up.
      m%^image/tiff$%                                      and return '.tiff' ;
      m%^font/ttf$%                                        and return '.ttf'  ;
      m%^audio/wav$%                                       and return '.wav'  ;
      m%^audio/webm$%                                      and return '.weba' ;
      m%^video/webm$%                                      and return '.webm' ;
      m%^image/webp$%                                      and return '.webp' ;
      m%^application/vnd.ms-excel$%                        and return '.xls'  ;
      m%^text/xml$%                                        and return '.xml'  ;
      m%^application/vnd.mozilla.xul$%                     and return '.xul'  ; # Also xul+xml
      m%^application/zip$%                                 and return '.zip'  ;
      m%^application/7z-compressed$%                       and return '.7z'   ;
   }

   # If we get to here, we haven't returned a suffix yet, which means that checktype_filename() from CPAN
   # module "File::Type" was NOT able to determine the type of this file. So we'll have to use other methods.

   # If this file is at-least 32 bytes in size, let's grab AT-LEAST the first 32 bytes of its contents,
   # up to a max of 1048576 bytes, and examine the contents for clues as to what kind of file this is,
   # or if we CAN'T read at least 32 bytes, return "***ERROR***":
   my $size = -s e $path;
   my $buffer = '';
   if ( $size >= 32 ) {
      my $fh = undef;
      open($fh, '< :raw', e $path)                    or return '***ERROR***' ; # File can't be opened.
      read($fh, $buffer, 1048576)                     or return '***ERROR***' ; # File can't be read.
      close($fh)                                      or return '***ERROR***' ; # File can't be closed.
      my $bytes = length($buffer);
      $bytes >= 32                                    or return '***ERROR***' ; # Didn't read 32 bytes.

      if ( $db ) {
         say STDERR '';
         say STDERR "In get_correct_suffix(), just loaded \$buffer.";
         say STDERR "\$size  = $size";
         say STDERR "\$bytes = $bytes";
      }

      # Pore over the contents of $buffer and try to glean clues as to what type of file this is:
      if ( $type eq 'application/octet-stream' ) {
         'wOFF' eq substr($buffer,0,4)                     and return '.woff' ; # Web Open Font Format
         is_ascii($buffer)                                 and return '.txt'  ; # ASCII      text file.
         is_iso_8859_1($buffer)                            and return '.txt'  ; # ISO-8859-1 text file.
         is_utf8($buffer)                                  and return '.txt'  ; # UTF-8      text file.
      }
      "AVI" eq substr($buffer, 8, 3)                       and return '.avi'  ; # AVI (Windows video)
      pack('C4',195,202,4,193) eq substr($buffer,0,4)      and return '.ccf'  ; # CCF (Chrome Cache File)
      'fLaC' eq substr($buffer,0,4)                        and return '.flac' ; # fLaC (high-quality sound)
      'FLV' eq substr($buffer,0,3)                         and return '.flv'  ; # FLV (FLash Video)
      'GIF' eq substr($buffer,0,3)                         and return '.gif'  ; # GIF (lo-color grphcs; anim)
      $buffer =~ m%^<!DOCTYPE HTML%                        and return '.html' ; # HTML (markup)
      '\xFF\xD8\xFF' eq substr($buffer,0,3)                and return '.jpg'  ; # JPG (lossy compression)
      'ftypmp4' eq substr($buffer,4,7)                     and return '.mp4'  ; # MP4 (good video format)
      'PAR2' eq substr($buffer,0,4)                        and return '.par2' ; # PAR2 (checksum)
      'PDF' eq substr($buffer,1,3)                         and return '.pdf'  ; # PDF (Portable Document Fmt.)
      'PNG' eq substr($buffer,1,3)                         and return '.png'  ; # PNG (Portable Network Grph.)
      'Rar' eq substr($buffer,0,3)                         and return '.rar'  ; # RAR (compressed archive)
      'WAVEfmt' eq substr($buffer,8,7)                     and return '.wav'  ; # WAV (lossless sound)
      pack('C[16]',  48,  38, 178, 117, 142, 102, 207,  17,
                    166, 217,   0, 170,   0,  98, 206, 108)
         eq substr($buffer,0,16)                           and return '.wma'  ; # WMA (Windows Media Audio)
      '\x30\x26\xB2\x75\x8E\x66\xCF\x11'.
      '\xA6\xD9\x00\xAA\x00\x62\xCE\x6C'
         eq substr($buffer,0,16)                           and return '.wmv'  ; # WMV (Windows Media Video)
   }

   # If we get to here, we've failed to definitively determine the correct suffix for-sure, so return the
   # original suffix, unless it was blank, in which case return '.unk':
   $suff eq ''                                             and return '.unk'    # File of unknown type.
                                                            or return $suff   ; # Return original suffix.
} # end sub get_correct_suffix :prototype($) ($path)

1
