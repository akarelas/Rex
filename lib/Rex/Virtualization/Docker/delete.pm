#
# (c) Jan Gehring <jan.gehring@gmail.com>
#

package Rex::Virtualization::Docker::delete;

use 5.12.5;
use warnings;

our $VERSION = '9999.99.99_99'; # VERSION

use Rex::Logger;
use Rex::Helper::Run;

sub execute {
  my ( $class, $arg1, %opt ) = @_;

  unless ($arg1) {
    die("You have to define the container ID!");
  }

  my $dom = $arg1;
  Rex::Logger::debug("deleteing container $dom");

  unless ($dom) {
    die("VM $dom not found.");
  }

  i_run "docker rm \"$dom\"", fail_ok => 1;
  if ( $? != 0 ) {
    die("Error deleteing container $dom");
  }

}

1;

