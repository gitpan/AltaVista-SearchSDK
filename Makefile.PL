use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
use Config;
use Getopt::Long;
use File::Find;


# Options
$::opt_a = '.';   # path to location of avs.h and libavs*.a


GetOptions(qw(a=s v=s))
   or die "Invalid arguments";

my %avs_os_dir_name = (
		       'dec_osf' => 'dunix',
		       'solaris' => 'solaris'
		      );

my $subdir;

if ($::opt_v =~ /^3\.[0-9a-z]+/) {
	print "Your AVS SDK is version 3.x (or at least YOU said so)\n";
	$def_version = '-DAVS_VERSION_3';
	print "Operating system is $^O, AVS SDK library dir will be '$::opt_a'\n";
	$subdir = '.';
}
else { # ASSUMES pre-3.x
	print "Your AVS SDK is version 2.6 or before (or at least YOU said so)\n";
	$def_version = '';
	die "Unsupported operating system (see Makefile.PL)" if !$avs_os_dir_name{$^O};
	$subdir = $avs_os_dir_name{$^O};
	print "Operating system is $^O, AVS SDK library dir will be '$subdir'\n";
}


my ($headerdir, $libdir, @libs) = find_headers ($::opt_a, $subdir);


$libs = join (" -l", @libs);


WriteMakefile(
    'NAME'	=> 'AltaVista::SearchSDK',
    'VERSION_FROM' => 'SearchSDK.pm', # finds $VERSION
    'LIBS'	=> ["-lm -L$libdir $libs"],   # e.g., '-lm' 
    'DEFINE'	=> "$def_version",     # e.g., '-DHAVE_SOMETHING' 
    'INC'	=> "-I$headerdir",     # e.g., '-I/usr/include/other' 
);


exit 0;

#################################################

sub find_headers {
   my $base_dir = shift;
   my $os_dir = shift;
   
   my $headerdir = undef;
   my $libdir = undef;
   my %libhash = undef;
   
   find( sub {
	    if (/^avs\.h$/) {
	       $headerdir = $File::Find::dir;
	    }
	    elsif (/lib(avs.*?[^_r])\.a$/) {
	       next if $^O eq 'solaris' && ($File::Find::dir =~ /bin64/); # 64bit not supported on Solaris (yet)
	       $libhash{$1} = 1 unless exists $libhash{$1};
	       if ($File::Find::dir =~ m!$os_dir!) {
		  $libdir = $File::Find::dir;
	       }
	    }
	 }, $base_dir );
   die qq{
   Unable to find AltaVista SearchSDK header file (avs.h).
   Maybe you should specify or check -a <path-to-your-AVS-SDK-installation>
} unless $headerdir;
   die qq{
   Unable to find AltaVista SearchSDK library file.
   Maybe you should specify or check -a <path-to-your-AVS-SDK-installation>
} unless $libdir; # $lib may be set but $libdir not.
   print "Found header in $headerdir\nand library(ies) '" . join(" ", keys %libhash) . "' in $libdir.\n";
   return ($headerdir, $libdir, keys %libhash);
}
