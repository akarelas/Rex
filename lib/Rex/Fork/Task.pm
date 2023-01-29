#
# (c) Jan Gehring <jan.gehring@gmail.com>
#

package Rex::Fork::Task;

use 5.12.5;
use warnings;
use POSIX ":sys_wait_h";

our $VERSION = '9999.99.99_99'; # VERSION

sub new {
  my $that  = shift;
  my $proto = ref($that) || $that;
  my $self  = {@_};

  bless( $self, $proto );

  $self->{'running'} = 0;

  return $self;
}

sub start {
  my ($self) = @_;

  $self->{'running'} = 1;
  $self->{pid}       = fork;

  if ( !$self->{pid} ) {
    $self->{coderef}->($self);
    $self->{'running'} = 0;
    exit();
  }
}

sub wait {
  my ($self) = @_;
  my $rpid = waitpid( $self->{pid}, &WNOHANG );
  if ( $rpid == -1 ) { $self->{'running'} = 0; }

  return $rpid;
}

1;
