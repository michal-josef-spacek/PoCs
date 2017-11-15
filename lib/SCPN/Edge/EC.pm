package SCPN::Edge::EC;

use Moo;
use namespace::clean;
use Mojo::Exception;

has output_condition => (
	is => 'rw',
	isa => sub {
		return unless defined $_[0];

		Mojo::Exception->throw("EC: output_event is not SCPN::Condition.")
			unless $_[0]->isa("SCPN::Condition")
	},
	default => sub { return undef }
);

sub send {
	my ($self, $item) = @_;

	return unless $self->output_condition;

	$self->output_condition->add_item(
		item_id => generate_item_id(),
		item => $item
	);

	return 1;
}

sub generate_item_id {
	my $rand_str;
	$rand_str .= chr( int(rand(25) + 65) ) foreach (1..32);

	return $rand_str;
}

1;