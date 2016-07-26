package WocliApiServer;
use Mojo::Base 'Mojolicious';

use WocliApiServer::Model::Users;

# This method will run once at server start
sub startup {
	my $self = shift;
	$self->secrets(['Mojolicious rocks']);
	$self->helper(users => sub { state $users = WocliApiServer::Model::Users->new });

	my $r = $self->routes;
	$r->post('/login')->to('login#login')->name('login');

	my $logged_in = $r->under('/')->to('login#logged_in');
	$logged_in->get('/protected')->to('login#protected');

	$r->get('/logout')->to('login#logout');
}

1;
