# AltaVista Search SDK support package
# Copything (C) 1998 The Christian Science Publishing Society. 
# All rights reserved
# This program is free software, you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
package AltaVista::SearchSDK;

use strict;
use Carp;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT_OK = qw(
	AVS_ADDDOC_IO_ERR
	AVS_BADARGS_ERR
	AVS_CHARSET_ASCII8
	AVS_CHARSET_LATIN1
	AVS_CHARSET_UTF8
	AVS_COMPACT_IO_ERR
	AVS_COUNTS_ERR
	AVS_DATE_ERR
	AVS_DOCDATA_ERR
	AVS_DOCID_ERR
	AVS_DOCLIST_ERR
	AVS_DOC_EXISTS
	AVS_DOC_LIMIT_ERR
	AVS_DOC_NOTFOUND
	AVS_FIELD_ERR
	AVS_FILTER_ERR
	AVS_GETDATA_ERR
	AVS_INDEX_ERR
	AVS_LICENSE_EXPIRED
	AVS_LOCK_ERR
	AVS_MALLOC_ERR
	AVS_MAX_BUCKETS
	AVS_MAX_DOCDATA
	AVS_MAX_DOCID
	AVS_MAX_TIERS
	AVS_MAX_WORDSIZE
	AVS_MKSTABLE_IO_ERR
	AVS_MKVIS_IO_ERR
	AVS_NOMORE_WORDS
	AVS_OK
	AVS_OPEN_ERR
	AVS_OPTION_RANKBYDATE
	AVS_OPTION_SEARCHBYDATE
	AVS_OPTION_SEARCHSINCE
	AVS_OPT_FLAGS_RANK_TO_BOOL
	AVS_PARSE_ERR
	AVS_PARSE_SGML
	AVS_RESULTNUM_ERR
	AVS_SEARCH_ERR
	AVS_STARTDOC_ERR
	AVS_SYNC_ERR
	AVS_UNK_EXCEPTION_ERR
	AVS_UPDATE_ERR
	AVS_VERSION_ERR
	VALTYPE_NAME_LEN
	_AVS_INTERFACE_VERSION
             avs_open
	     avs_querymode
	     avs_buildmode
	     avs_errmsg
	     avs_getindexmode
	     avs_adddate
	     avs_addfield
	     avs_addliteral
	     avs_addrankterms
	     avs_addvalue
	     avs_addword
	     avs_buildmode_ex
	     avs_close
	     avs_compact
	     avs_compactionneeded
	     avs_compact_minor
	     avs_count
	     avs_count_close
	     avs_count_getcount
	     avs_count_getword
	     avs_create_options
	     avs_default_options
	     avs_define_valtype
	     avs_delete_docid
	     avs_enddoc
	     avs_getindexversion
	     avs_getindexversion_counts_v
	     avs_getindexversion_search_v
	     avs_getsearchresults
	     avs_getsearchterms
	     avs_getsearchversion
	     avs_lookup_valtype
	     avs_makestable
	     avs_newdoc
	     avs_release_valtypes
	     avs_search
	     avs_search_close
	     avs_search_ex
	     avs_search_genrank
	     avs_search_getdata
	     avs_search_getdatalen
	     avs_search_getdate
	     avs_search_getdocid
	     avs_search_getrelevance
	     avs_setdocdata
	     avs_setdocdate
	     avs_setdocdatetime
	     avs_setparseflags
	     avs_setrankval
	     avs_startdoc
	     avs_timer
	     avs_version
	     avs_create_options
);
$VERSION = '1.00';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
		croak "Your vendor has not defined AltaVista::SearchSDK macro $constname";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap AltaVista::SearchSDK $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

AltaVista::SearchSDK - Perl extension for AltaVista Search Software Development Kit

=head1 SYNOPSIS

  use AltaVista::SearchSDK;

avs_adddate(idx, yr, mo, da, startloc)

avs_addfield(idx, pFname, startloc, endloc)	

avs_addliteral(idx, pWord, loc)

avs_addvalue(idx, valtype, value, loc)

avs_addword(idx, pWords, loc, pNumWords)

avs_buildmode(idx)

avs_buildmode_ex(idx, ntiers)

avs_close(idx)

avs_compact(idx, bMore_p)

avs_compactionneeded(idx)

avs_compact_minor(idx, bMore_p)

avs_count(idx, pWordPrefix, pCountsHdl)

avs_count_close(CountsHdl)

avs_count_getcount(CountsHdl)

avs_countnext(CountsHdl)

avs_count_getword(CountsHdl)

avs_default_options(pOptions)

avs_define_valtype(name, minval, maxval, valtype_p)

avs_deletedocid(idx, pDocId, pCount)

avs_enddoc(idx)

avs_errmsg(code)

avs_getindexmode(idx)

avs_getindexversion(idx)

avs_getindexversion_counts_v(countsHdl)

avs_getindexversion_search_v(searchHdl)

avs_getsearchresults(searchHdl, resultNum)

avs_getsearchterms(psearchHdl, termNum, term, count)

avs_lookup_valtype(name)

avs_makestable(idx)

avs_open(path, mode, pIdx) # pre-3.0 syntax
avs_open(path, mode, pIdx, license_key) # post-3.0 syntax
You'll need to pass I<license_key> if you are using AVS SDK 3.0 or
later releases. In case you do not set license_key, the module
will use the default LICENSEKEY_LIMITED which is valid for 500 documents.
This key however seems to limit some functionality so it is not
recommended for use with this module (by the author, not by AltaVista!)

avs_querymode(idx)

avs_release_valtypes()

avs_search(idx, pQuery, pBoolQuery, pOptions, pDocsFound, pDocsReturned, pTermCount, pSearchHdl)

avs_search_close(pSearchHdl)

avs_search_ex(idx, pQuery, pBoolQuery, pOptions, searchsince, pDocsFound, pDocsReturned, pTermCount, pSearchHdl)

avs_search_genrank(idx, pBoolQuery, pRankTerms, pRankSetup, pOptions, searchsince, pDocsFound, pDocsReturned, pSearchHdl)

avs_search_getdata(searchHdl)

avs_search_getdatalen(searchHdl)

avs_search_getdate(psearchHdl, year, month, day)

avs_search_getdocid(searchHdl)

avs_search_getdocidlen(searchHdl)

avs_search_getrelevance(psearchHdl)

avs_setdocdata(idx, pDocData, len)

avs_setdocdate(idx, year, month, day)

avs_setdocdatetime(idx, year, month, day, hour, minute, second)

avs_setparseflags(idx, parseflags)

avs_setrankval(idx, valtype, value)

avs_startdoc(idx, pDocId, flags, pStartLoc)

avs_timer(current)

avs_version()  # pre-3.0 syntax
avs_version(license_key) # post-3.0 syntax

avs_create_options(limit, timeout, flags)

=head1 DESCRIPTION

This set of extensions provides wrappers for all the C functionality of
the AltaVista Search software development kit (SDK) except for a few functions that did not make sense to export to perl.

Document converters functions available in SDK 3.0 and later are
not available in this release (yet).
All the functions of the 97 Rev B kit are available as advertised, 
except for the following:

=over 4

=item I<avs_add_ms_callback> UNIMPLEMENTED

It makes no sense to implement this function, since it would require being able to pass a C function handle through perl.

=item I<avs_addrankterms> UNIMPLEMENTED

Internal function

=item I<avs_newdoc> UNIMPLEMENTED

No easy way to provide filter function

=item I<avs_search_getdata_copy> UNIMPLEMENTED

No need for this function

=item I<avs_search_getdocid_copy> UNIMPLEMENTED

No need for this function

=item I<avs_search_getrelevance> RETURN ARGUMENT

Relevance is returned as a string representation of the float

=back

=head1 PREREQUITES

Perl 5.004, the AltaVista SearchSDK 97 Rev B or later (last tested 3.0.1).

=head1 LICENSE KEY REQUIREMENTS

There was a change in license key usage as of versione 3.0 of the AVS SDK.
In version 3.0, you need to pass the license key explicitly to avs_version
(and, more important, to avs_open) in order to have the toolkit recognize
your right to use the software. Previously, the key was embedded in your library.
This module tries to detect the correct situation. In order to have
a working program, please make sure you pass your license key to avs_version
and avs_open (each and every call). If you do not pass a license key, the module
will supply the default license key which allows 500 documents and seems
to limit the workings of a number of functions.
Please see 'INSTALLATION' for additional instructions.

=head1 INSTALLATION

To install this module, move into the directory where this file is
located. Then type the
following:

	perl Makefile.PL B<-a> I<path-to-AVS-SDK> [B<-v> 3.0]
	make
For version 3.0 and beyond, you'll need to set the environment variable
AVS_LICENSE_KEY with a valid license in order to have all the tests
execute correctly. Otherwise, some tests will fail but this
will not necessarily mean problems with the software.
	make test
Verify tests have succeeded, and then...
	make install

Makefile.PL will try to detect automatically the needed headers and libraries
basing on the path you pass to B<-a>. In order to switch on support for 3.0
use B<-v> I<version> (currently supported 3.0). This will modify the definitions
of avs_version and avs_open in order to accept an optional parameter,
the license key, needed to have the software (and this module) work correctly.

=head1 PLATFORM-SPECIFIC NOTES

=head2 Solaris
This module currently supports only the 32-bits version of the AVS SDK
librery on this platform.


=head1 AUTHORS

Version 1.00 and later: Davide Migliavacca <davide.migliavacca@inferentia.it>.
Version 0.99b and before: James M. Turner <james@csmonitor.com>

Copyright (C) 2000 Davide Migliavacca and Inferentia, Milano ITALY.

Version 0.99b: Copyright (C) 1998 The Christian Science Publishing Society. 
All rights reserved

This program is free software, you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

perl(1), AltaVista Search SDK documentation.

=head1 BUGS

This version has been tested in a live environment for certain
conditions, but has by no means been extensively tested.
It has been tested on Solaris and Digital Unix (now Compaq Tru64).
Please let me know if you get it work under other platforms or
operating systems.

=cut

